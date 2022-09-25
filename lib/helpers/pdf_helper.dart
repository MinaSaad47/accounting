import 'package:accounting/common/common.dart';
import 'package:accounting/utils/utils.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

late final pw.Font _font1;
late final pw.Font _font2;
late final String _background;
late final PdfColor _color1;
late final PdfColor _color2;
late final PdfColor _color3;

bool _initialized = false;

class PdfHelper {
  static Future<void> generateInvoice(
    BuildContext context, {
    required CompanyModel company,
    required List<IncomeModel> incomes,
    required List<ExpenseModel> expenses,
    required double total,
  }) async {
    if (!_initialized) {
      Utils.log.d('[PdfHelper] loading data');
      _font1 = pw.Font.ttf(
        await rootBundle.load('assets/fonts/Cairo-Regular.ttf'),
      );
      _font2 = pw.Font.ttf(
        await rootBundle.load('assets/fonts/Roboto-Regular.ttf'),
      );
      _background = await rootBundle.loadString(
        'assets/images/page_background.svg',
      );
      _color1 = PdfColors.red;
      _color2 = PdfColors.green;
      _color3 = const PdfColor.fromInt(0x0074bc);
      _initialized = true;
    }

    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageTheme: await _buildTheme(),
        build: (_) => [
          _buildHeader(),
          _buildCompanyContent(context, company),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: ArText(
              'الايرادات',
              style: pw.TextStyle(
                color: _color2,
                fontSize: 1 * PdfPageFormat.cm,
              ),
            ),
          ),
          _buildIncomeContent(incomes),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: ArText(
              'المصروفات',
              style: pw.TextStyle(
                color: _color1,
                fontSize: 1 * PdfPageFormat.cm,
              ),
            ),
          ),
          _buildExpenseContent(expenses),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: ArText(
              'المستحقات',
              style: pw.TextStyle(
                color: _color3,
                fontSize: 1 * PdfPageFormat.cm,
              ),
            ),
          ),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: _buildDues(total),
          ),
        ],
      ),
    );
    // ..addPage(pw.MultiPage(
    //   pageTheme: await _buildTheme(),
    //   build: (_) => [
    //     pw.Align(
    //       alignment: pw.Alignment.centerRight,
    //       child: ArText(
    //         'الايرادات',
    //         style: pw.TextStyle(
    //           color: _color2,
    //           fontSize: 1 * PdfPageFormat.cm,
    //         ),
    //       ),
    //     ),
    //     _buildIncomeContent(incomes),
    //   ],
    // ))
    // ..addPage(
    //   pw.MultiPage(
    //     pageTheme: await _buildTheme(),
    //     build: (_) => [
    //       pw.Align(
    //         alignment: pw.Alignment.centerRight,
    //         child: ArText(
    //           'المصروفات',
    //           style: pw.TextStyle(
    //             color: _color1,
    //             fontSize: 1 * PdfPageFormat.cm,
    //           ),
    //         ),
    //       ),
    //       _buildExpenseContent(expenses),
    //     ],
    //   ),
    // )
    // ..addPage(
    //   pw.MultiPage(
    //     pageTheme: await _buildTheme(),
    //     build: (_) => [
    //       pw.Align(
    //         alignment: pw.Alignment.centerRight,
    //         child: _buildDues(total),
    //       ),
    //     ],
    //   ),
    // );

    Printing.layoutPdf(
      onLayout: (format) => doc.save(),
    );
  }

  static Future<pw.PageTheme> _buildTheme() async {
    return pw.PageTheme(
      theme: pw.ThemeData(
        textAlign: pw.TextAlign.justify,
        defaultTextStyle: pw.TextStyle(
          color: _color3,
          font: _font1,
          fontFallback: [_font2],
        ),
      ),
      pageFormat: PdfPageFormat.standard.applyMargin(
        left: 5 * PdfPageFormat.cm,
        top: 0 * PdfPageFormat.cm,
        bottom: 4 * PdfPageFormat.cm,
        right: 0 * PdfPageFormat.cm,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.SvgImage(
          svg: _background,
        ),
      ),
    );
  }

  static pw.Widget _buildHeader() => pw.Directionality(
        textDirection: pw.TextDirection.rtl,
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                ArText(
                  'الفاتورة',
                  style: const pw.TextStyle(
                    fontSize: 2 * PdfPageFormat.cm,
                  ),
                ),
                pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
                ArText(
                  Utils.formatDate(DateTime.now()),
                  style: const pw.TextStyle(
                    fontSize: 1 * PdfPageFormat.cm,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  static pw.Widget _buildCompanyContent(
    BuildContext context,
    CompanyModel company,
  ) {
    List<List<dynamic>> data = [
      [
        company.id,
        'id',
      ],
      [
        company.owner,
        AppLocalizations.of(context)!.owner,
      ],
      [
        company.commercialFeature,
        AppLocalizations.of(context)!.commercialFeature,
      ],
      [
        company.isWorking
            ? AppLocalizations.of(context)!.working
            : AppLocalizations.of(context)!.notWorking,
        AppLocalizations.of(context)!.isWorking,
      ],
      if (company.recordNumber != null)
        [
          company.recordNumber,
          AppLocalizations.of(context)!.registerNumber,
        ],
      if (company.legalEntity != null)
        [
          company.legalEntity,
          AppLocalizations.of(context)!.legalEntity,
        ],
      if (company.fileNumber != null)
        [
          company.fileNumber,
          AppLocalizations.of(context)!.fileNumber,
        ],
      if (company.registerNumber != null)
        [
          company.registerNumber,
          AppLocalizations.of(context)!.registerNumber,
        ],
      if (company.startDate != null)
        [
          Utils.formatDate(company.startDate!),
          AppLocalizations.of(context)!.startDate,
        ],
      if (company.stopDate != null)
        [
          Utils.formatDate(company.stopDate!),
          AppLocalizations.of(context)!.stopDate,
        ],
      if (company.generalTaxMission != null)
        [
          company.generalTaxMission,
          AppLocalizations.of(context)!.generalTaxMission,
        ],
      if (company.valueTaxMission != null)
        [
          company.valueTaxMission,
          AppLocalizations.of(context)!.valueTaxMission,
        ],
      if (company.activityNature != null)
        [
          company.activityNature,
          AppLocalizations.of(context)!.activityNature,
        ],
      if (company.activityLocation != null)
        [
          company.activityLocation,
          AppLocalizations.of(context)!.activityLocation,
        ],
      if (company.recordNumber != null)
        [
          company.recordNumber,
          AppLocalizations.of(context)!.recordNumber,
        ],
      if (company.username != null)
        [
          company.username,
          AppLocalizations.of(context)!.username,
        ],
      if (company.email != null)
        [
          company.email,
          AppLocalizations.of(context)!.email,
        ],
    ];

    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Table.fromTextArray(
        headers: null,
        data: data,
        cellStyle: pw.TextStyle(
          font: _font1,
          fontSize: 5 * PdfPageFormat.mm,
        ),
        headerAlignment: pw.Alignment.centerRight,
        border: pw.TableBorder.all(
          color: _color3,
          width: 2 * PdfPageFormat.point,
        ),
        cellAlignments: {
          0: pw.Alignment.centerRight,
          1: pw.Alignment.centerRight,
        },
      ),
    );
  }

  static pw.Widget _buildIncomeContent(List<IncomeModel> incomes) {
    final headers = [
      'الوصف',
      'القيمة',
      'التاريخ',
    ];

    final data = incomes.map((item) {
      return [
        item.description,
        (item.value.toStringAsFixed(2)),
        Utils.formatDate(item.time!),
      ];
    }).toList();

    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Table.fromTextArray(
        headers: headers,
        headerStyle: pw.TextStyle(
          font: _font1,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
          fontSize: 5 * PdfPageFormat.mm,
        ),
        cellStyle: pw.TextStyle(
          font: _font1,
          color: _color2,
          fontSize: 5 * PdfPageFormat.mm,
        ),
        headerAlignment: pw.Alignment.centerRight,
        headerDecoration: pw.BoxDecoration(color: _color2),
        border: null,
        data: data,
        columnWidths: {
          0: const pw.FractionColumnWidth(0.5),
        },
        cellAlignments: {
          0: pw.Alignment.centerRight,
          1: pw.Alignment.centerRight,
          2: pw.Alignment.centerRight,
        },
      ),
    );
  }

  static pw.Widget _buildExpenseContent(List<ExpenseModel> expenses) {
    final headers = [
      'الوصف',
      'القيمة',
      'التاريخ',
    ];

    final data = expenses.map((item) {
      return [
        item.description,
        (item.value.toStringAsFixed(2)),
        Utils.formatDate(item.time!),
      ];
    }).toList();

    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Table.fromTextArray(
        headers: headers,
        headerStyle: pw.TextStyle(
          font: _font1,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
          fontSize: 5 * PdfPageFormat.mm,
        ),
        cellStyle: pw.TextStyle(
          font: _font1,
          color: _color1,
          fontSize: 5 * PdfPageFormat.mm,
        ),
        headerDecoration: pw.BoxDecoration(color: _color1),
        headerAlignment: pw.Alignment.centerRight,
        border: null,
        data: data,
        columnWidths: {
          0: const pw.FractionColumnWidth(0.5),
        },
        cellAlignments: {
          0: pw.Alignment.centerRight,
          1: pw.Alignment.centerRight,
          2: pw.Alignment.centerRight,
        },
      ),
    );
  }

  static pw.Widget _buildDues(double total) {
    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Container(
        padding: const pw.EdgeInsets.all(3 * PdfPageFormat.mm),
        decoration: pw.BoxDecoration(
          borderRadius: pw.BorderRadius.circular(10),
          border: pw.Border.all(
            color: _color3,
            width: 2 * PdfPageFormat.point,
          ),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          children: [
            ArText(
              'جنيه',
              style: const pw.TextStyle(
                fontSize: 1 * PdfPageFormat.cm,
              ),
            ),
            ArText(
              total.toStringAsFixed(2),
              style: const pw.TextStyle(
                fontSize: 1 * PdfPageFormat.cm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArText extends pw.Text {
  ArText(super.text, {pw.TextStyle? style})
      : super(
          textDirection: pw.TextDirection.rtl,
          textAlign: pw.TextAlign.left,
          style: style,
        );
}

class EnText extends pw.Text {
  EnText(super.text, {pw.TextStyle? style})
      : super(
          style: style,
        );
}
