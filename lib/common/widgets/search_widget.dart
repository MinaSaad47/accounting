import 'dart:async';

import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Timer? _debouncer;

  @override
  void dispose() {
    _debouncer?.cancel();
    super.dispose();
  }

  void _debounce(VoidCallback callback,
      {Duration duration = const Duration(milliseconds: 1000)}) {
    if (_debouncer != null) {
      _debouncer!.cancel();
    }
    _debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search),
        hintText: widget.hintText,
      ),
      onChanged: (query) => _debounce(
        () {
          widget.onChanged(query);
        },
      ),
    );
  }
}
