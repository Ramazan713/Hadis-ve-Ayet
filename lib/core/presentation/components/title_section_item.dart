import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';


class TitleSectionItem extends StatelessWidget {

  final String title;
  final String content;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final bool expandable;
  final bool initExpand;
  final EdgeInsets? paddings;
  final EdgeInsets? margins;
  final double? contentFontSize;
  final bool useDefaultColor;
  final double? elevation;

  const TitleSectionItem({
    super.key,
    required this.title,
    required this.content,
    this.titleStyle,
    this.contentStyle,
    this.paddings,
    this.margins,
    this.contentFontSize,
    this.elevation,
    this.expandable = false,
    this.initExpand = false,
    this.useDefaultColor = false
  });

  @override
  Widget build(BuildContext context) {

    return TitleSectionChild(
      title: title,
      titleStyle: titleStyle,
      paddings: paddings,
      expandable: expandable,
      initExpand: initExpand,
      margins: margins,
      contentFontSize: contentFontSize,
      useDefaultColor: useDefaultColor,
      elevation: elevation,
      content: Text(
        content,
        style: contentStyle ?? Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: contentFontSize
        ),
      ),
    );
  }
}



class TitleSectionChild extends StatelessWidget {

  final String title;
  final Widget content;
  final TextStyle? titleStyle;
  final bool expandable;
  final bool initExpand;
  final EdgeInsets? paddings;
  final EdgeInsets? margins;
  final double? contentFontSize;
  final bool useDefaultColor;
  final double? elevation;


  TitleSectionChild({
    super.key,
    required this.title,
    required this.content,
    this.titleStyle,
    this.paddings,
    this.margins,
    this.contentFontSize,
    this.elevation,
    this.expandable = false,
    this.initExpand = false,
    this.useDefaultColor = false
  });

  BorderRadius get borderRadius => BorderRadius.circular(13);

  final ValueNotifier<bool> expandNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    expandNotifier.value = initExpand || !expandable;

    final colorSchema = Theme.of(context).colorScheme;
    final cardColor = useDefaultColor ? colorSchema.surface : colorSchema.secondaryContainer;

    return Card(
      margin: margins ?? const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
      elevation: elevation,
      color: cardColor,
      child: Padding(
        padding: paddings ?? const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getHeader(context),
            getContent(context),
          ],
        ),
      ),
    );
  }

  Widget getHeader(BuildContext context){
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: expandable == false ? null : (){
        expandNotifier.value = !expandNotifier.value;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getTitle(context),
            getExpandableIcon(),
          ],
        ),
      ),
    );
  }

  Widget getExpandableIcon(){
    if(!expandable) return const SizedBox.shrink();
    return ValueListenableBuilder(
        valueListenable: expandNotifier,
        builder: (context, isExpanded, child){
          if(isExpanded) return  const Icon(Icons.arrow_drop_down,);
          return const Icon(Icons.arrow_drop_up);
        }
    );
  }

  Widget getContent(BuildContext context){
    return ValueListenableBuilder(
        valueListenable: expandNotifier,
        builder: (context, isExpanded, child){
          return CustomAnimatedVisibility(
            visible: isExpanded,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 12),
              child: content,
            ),
          );
        }
    );
  }

  Widget getTitle(BuildContext context){
    return Text(
      title,
      style: titleStyle ?? Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: contentFontSize
      ),
    );
  }
}


