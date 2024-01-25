import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/controllers/custom_auto_scroll_controller.dart';
import 'package:hadith/core/presentation/dialogs/show_get_number_dia.dart';

class NavigateToIconAuto extends StatelessWidget {

  final CustomAutoScrollController autoScrollController;
  final void Function(int pos) onPosChanged;

  const NavigateToIconAuto({
    Key? key,
    required this.autoScrollController,
    required this.onPosChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showGetNumberDia(
          context,
          listener: (selectedIndex) async{
            onPosChanged(selectedIndex);
          },
          currentIndex: autoScrollController.middleVisiblePos,
          limitIndex: autoScrollController.totalItems - 1,
        );
      },
      icon: const Icon(Icons.map),
      tooltip: "Navigate to position",
    );
  }
}
