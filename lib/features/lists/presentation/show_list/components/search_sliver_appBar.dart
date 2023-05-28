import 'package:flutter/material.dart';

class SearchSliverAppBar extends StatefulWidget {
  final Function(String) onChanged;
  final Function(String text)? onSubmitted;
  final Function()? onClosed;
  final String hint;

  const SearchSliverAppBar(
      {Key? key,
      required this.onChanged,
      this.onSubmitted,
      this.onClosed,
      this.hint = "Ara"})
      : super(key: key);

  @override
  State<SearchSliverAppBar> createState() => _SearchSliverAppBarState();
}

class _SearchSliverAppBarState extends State<SearchSliverAppBar> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      actions: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: TextField(
                      onChanged: widget.onChanged,
                      controller: _textEditingController,
                      autofocus: true,
                      onSubmitted: widget.onSubmitted,
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        icon: IconButton(
                            onPressed: () {
                              widget.onChanged("");
                              widget.onClosed?.call();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                            )),
                      )),
                ),
              ),
              IconButton(
                  onPressed: () {
                    _textEditingController.clear();
                    widget.onChanged("");
                  },
                  icon: const Icon(
                    Icons.clear,
                  ))
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    widget.onChanged("");
    _textEditingController.dispose();
    super.dispose();
  }
}
