import 'package:flutter/material.dart';


class CategoryItem extends StatelessWidget {
  final String title;
  final String assetPath;
  final Function() onClick;
  final bool expandContent;

  const CategoryItem({
    Key? key,
    required this.title,
    required this.assetPath,
    required this.onClick,
    this.expandContent = false
  }) : super(key: key);

  final double imageSize = 100;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(13);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7,horizontal: 5),
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius
      ),
      child: InkWell(
        onTap: onClick,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 3),
          child: getContent(context)
        ),
      ),
    );
  }

  Widget getContent(BuildContext context){
    if(expandContent){
      return getExtendContent(context);
    }
    return getCollapsedContent(context);
  }


  Widget getCollapsedContent(BuildContext context){
    return Column(
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
    );
  }

  Widget getExtendContent(BuildContext context){
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 16,),
          Image.asset(
            assetPath,
            width: imageSize,
            height: imageSize,
          ),
          const SizedBox(width: 16,),
          Expanded(
            child: Text(title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }


}