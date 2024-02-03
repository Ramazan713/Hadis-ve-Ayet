import 'package:flutter/material.dart';
import 'package:hadith/features/search/domain/model/history.dart';

class HistoryItem extends StatelessWidget {
  final History history;
  final void Function() onClick;
  final void Function() onRemoveClick;

  const HistoryItem({
    Key? key,
    required this.history,
    required this.onClick,
    required this.onRemoveClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final borderRadius = BorderRadius.circular(13);

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onClick,
        child: Row(
          children: [
            const SizedBox(width: 19,),
            Expanded(
              child: Text(
              history.name,
              style: Theme.of(context).textTheme.bodyMedium,)
            ),
            IconButton(
              onPressed: onRemoveClick,
              icon: const Icon(Icons.clear)
            ),
            const SizedBox(width: 7,)
          ],
        ),
      )
    );
  }
}
