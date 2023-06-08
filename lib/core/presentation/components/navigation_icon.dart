import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/controllers/custom_position_controller.dart';
import 'package:hadith/dialogs/show_get_number_bottom_dia.dart';


class NavigationIcon extends StatelessWidget {

  final CustomPositionController positionController;
  final void Function(int pos) onPosChanged;
  const NavigationIcon({Key? key,required this.positionController, required this.onPosChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: positionController,
        builder: (context, child){
          return IconButton(
            onPressed: () {
              showGetNumberBottomDia(
                context, (selectedIndex) {
                  onPosChanged(selectedIndex);
                },
                currentIndex: positionController.middleVisiblePos,
                limitIndex: positionController.totalItems - 1,
              );
            },
            icon: const Icon(Icons.map),
            tooltip: "Navigation",
          );
        });
  }
}
