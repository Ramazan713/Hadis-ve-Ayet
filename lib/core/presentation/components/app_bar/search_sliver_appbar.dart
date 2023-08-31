import 'package:flutter/material.dart';

class SearchSliverAppBar extends StatelessWidget {

  final Function(String) onChanged;
  final Function(String text)? onSubmitted;
  final Function()? onClosed;
  final String hint;
  final TextEditingController textEditingController;


  const SearchSliverAppBar({
    Key? key,
    required this.onChanged,
    required this.textEditingController,
    this.onSubmitted,
    this.onClosed,
    this.hint = "Ara",
  }) : super(key: key);

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
                    onChanged:  onChanged,
                    controller: textEditingController,
                    autofocus: true,
                    restorationId: "searching",
                    decoration: InputDecoration(
                      hintText: hint,
                      icon: IconButton(
                        onPressed: () {
                          _setText("");
                          onClosed?.call();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        )),
                    )),
                ),
              ),
              IconButton(
                onPressed: () {
                  _setText("");
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

  void _setText(String text){
    textEditingController.text = text;
    onChanged(text);
  }

}
