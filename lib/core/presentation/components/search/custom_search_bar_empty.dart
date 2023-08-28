import 'package:flutter/material.dart';

class CustomSearchBarEmpty extends StatelessWidget {

  final EdgeInsets? margins;
  final EdgeInsets? paddings;
  final String? hintText;
  final void Function()? onTap;
  final List<Widget> suffixIcons;
  final Widget? prefixIcon;
  final bool showDefaultPrefixIcon;

  const CustomSearchBarEmpty({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.showDefaultPrefixIcon = true,
    this.suffixIcons = const [],
    this.margins,
    this.paddings,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final borderRadius =  BorderRadius.circular(19);
    final currentPaddings = paddings ?? const EdgeInsets.symmetric(horizontal: 16,vertical: 17);
    final currentMargins = margins ?? const EdgeInsets.symmetric(vertical: 1,horizontal: 7);

    return Padding(
      padding: currentMargins,
      child: Material(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: TextField(
            readOnly: true,
            showCursor: false,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: hintText ?? "Ara",
              contentPadding: currentPaddings,
              filled: false,
              isCollapsed: true,
              border: InputBorder.none,
              prefixIcon: getPrefixIcon(context),
              suffixIcon: IntrinsicWidth(
                child: Row(
                  children: suffixIcons,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget? getPrefixIcon(BuildContext context){
    if(prefixIcon != null) return prefixIcon;
    if(showDefaultPrefixIcon){
      return const Icon(
        Icons.search,
      );
    }
    return null;
  }

}
