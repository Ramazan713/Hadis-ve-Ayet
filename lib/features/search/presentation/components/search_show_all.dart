import 'package:flutter/material.dart';


class SearchShowAll extends StatelessWidget {
  final void Function() onTap;

  const SearchShowAll({
    Key? key,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onTap,
        child: const Text("Tümünü Göster"),
      ),
    );
  }
}
