import 'package:accounting/companies/bloc/document_bloc.dart';
import 'package:accounting/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocuementsList extends StatelessWidget {
  const DocuementsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentBloc, DocumentState>(
      listener: (context, state) {
        if (state.status == DocumentStatus.failure) {
          Utils.toast(context, message: state.message, level: ToastLevel.error);
        }
      },
      builder: (context, state) {
        if (state.status == DocumentStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            itemBuilder: (context, index) => Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.picture_as_pdf_outlined),
                    Text(state.list[index].name),
                    Text(Utils.formatDate(state.list[index].time)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.file_download_outlined),
                    ),
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => Container(
              color: Theme.of(context).colorScheme.secondary,
            ),
            itemCount: state.list.length,
          );
        }
      },
    );
  }
}
