import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_switcher.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';

class StackSecondContent extends StatelessWidget {
  final Widget child;
  final Widget? Function() getSecondChild;
  final bool showStackChild;

  const StackSecondContent({
    super.key,
    required this.child,
    required this.getSecondChild,
    this.showStackChild = true
  });

  @override
  Widget build(BuildContext context) {
    return getMain(context);
  }

  Widget getMain(BuildContext context){
    if(showStackChild){
      return Stack(
        children: [
          child,
          getAnimatedSecondContent()
        ],
      );
    }
    final secondChild = getSecondChild();
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAnimatedSwitcher(
        firstChild: child,
        secondChild: Align(
          alignment: Alignment.center,
          child: secondChild
        ),
        showFirstChild: secondChild == null,
      ),
    );
  }

  Widget getAnimatedSecondContent(){
    final secondChild = getSecondChild();
    return CustomAnimatedVisibility(
      visible: secondChild != null,
      child: Align(
        alignment: Alignment.center,
        child: secondChild
      ),
    );
  }

}
