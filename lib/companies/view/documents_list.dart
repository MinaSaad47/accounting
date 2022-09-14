import 'package:accounting/companies/bloc/document_bloc.dart';
import 'package:accounting/utils/utils.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocuementsList extends StatelessWidget {
  const DocuementsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.status == DocumentStatus.loading &&
                state.action == DocumentAction.create)
              const LinearProgressIndicator(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    _BuildDocumentItem(document: state.list[index]),
                itemCount: state.list.length,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _BuildDocumentItem extends StatefulWidget {
  final DocumentModel document;
  const _BuildDocumentItem({
    Key? key,
    required this.document,
  }) : super(key: key);

  @override
  State<_BuildDocumentItem> createState() => _BuildDocumentItemState();
}

class _BuildDocumentItemState extends State<_BuildDocumentItem> {
  double progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.file_present_outlined, size: 30),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                widget.document.name,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              Utils.formatDate(widget.document.time),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.read<DocumentBloc>().add(
                                        DocumentRetreiveRequested(
                                          widget.document.path,
                                          (perc) {
                                            setState(() {
                                              progress = perc;
                                            });
                                          },
                                        ),
                                      );
                                },
                                icon: const Icon(Icons.file_download_outlined),
                              ),
                              IconButton(
                                onPressed: () => Utils.adminDo(context, fn: () {
                                  context.read<DocumentBloc>().add(
                                      DocumentDeleteRequested(
                                          widget.document.path));
                                }),
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            if (0.0 < progress && progress < 1.0)
              LinearProgressIndicator(value: progress),
          ],
        ),
      ),
    );
  }
}

class _BuilderDivider extends StatelessWidget {
  const _BuilderDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      height: 20,
      width: 2,
      color: Colors.grey,
    );
  }
}
