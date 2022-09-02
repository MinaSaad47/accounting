import 'package:accounting/utils/utils.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/services.dart';
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
  static Future<void> generateInvoice({
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

    doc
      ..addPage(
        pw.MultiPage(
          pageTheme: await _buildTheme(),
          build: (context) => [
            _buildHeader(),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: ArText('الايرادات', style: pw.TextStyle(color: _color2)),
            ),
            _buildIncomeContent(incomes),
          ],
        ),
      )
      ..addPage(
        pw.MultiPage(
          pageTheme: await _buildTheme(),
          build: (context) => [
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: ArText('المصروفات', style: pw.TextStyle(color: _color1)),
            ),
            _buildExpenseContent(expenses),
          ],
        ),
      )
      ..addPage(
        pw.MultiPage(
          pageTheme: await _buildTheme(),
          build: (context) => [
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: _buildDues(total),
            ),
          ],
        ),
      );

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
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                ArText(
                  'الفاتورة',
                  style: const pw.TextStyle(
                    fontSize: 2 * PdfPageFormat.cm,
                  ),
                ),
                pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
                EnText(Utils.formatDate(DateTime.now())),
              ],
            ),
          ],
        ),
      );

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
        ),
        cellStyle: pw.TextStyle(font: _font1, color: _color2),
        headerDecoration: pw.BoxDecoration(color: _color2),
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
        ),
        cellStyle: pw.TextStyle(font: _font1, color: _color1),
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
            width: 2 * PdfPageFormat.mm,
          ),
        ),
        child: pw.Column(
          children: [
            ArText(
              'المستحقات',
              style: const pw.TextStyle(
                fontSize: 0.5 * PdfPageFormat.cm,
              ),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                ArText(
                  'جنيه',
                  style: const pw.TextStyle(
                    fontSize: 0.5 * PdfPageFormat.cm,
                  ),
                ),
                ArText(
                  total.toStringAsFixed(2),
                  style: const pw.TextStyle(
                    fontSize: 0.5 * PdfPageFormat.cm,
                  ),
                ),
              ],
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
