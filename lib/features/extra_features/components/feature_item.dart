import 'package:flutter/material.dart';


class FeatureItem extends StatelessWidget {
  final String title;
  final String assetPath;
  final Function() onClick;
  const FeatureItem(
      {Key? key,
        required this.title,
        required this.assetPath,
        required this.onClick})
      : super(key: key);

  final double imageSize = 100;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(7),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                assetPath,
                width: imageSize,
                height: imageSize,
              ),
              const SizedBox(height: 8,),
              Text(title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}