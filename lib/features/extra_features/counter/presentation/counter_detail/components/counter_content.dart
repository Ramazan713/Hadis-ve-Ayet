import 'package:flutter/material.dart';
import 'package:hadith/features/extra_features/counter/presentation/counter_detail/components/counter_content_with_child.dart';


class CounterContent extends StatelessWidget {
  final String title;
  final String content;
  final double fontSize;
  const CounterContent({Key? key,required this.title,required this.content,required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterContentWithChild(
        title: title,
        fontSize: fontSize,
        child: Text(content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: fontSize
          ),
        )
    );
  }
}
