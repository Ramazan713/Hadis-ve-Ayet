
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/controllers/custom_sing_position_controller.dart';

class CustomPageController with ChangeNotifier{

  late final PageController _pageController;
  late final CustomSinglePositionController _positionController;

  int _currentPageIndex = 0;
  int _currentPos = 0;

  int get currentPageIndex => _currentPageIndex;
  int get currentPos => _currentPos;

  PageController get controller => _pageController;
  CustomSinglePositionController get positionController => _positionController;

  CustomPageController({
    PageController? pageController,
    CustomSinglePositionController? positionController,
    int? startPageIndex,
    int? startPos
  }){
    _pageController = pageController ?? PageController(initialPage: startPageIndex ?? 0);
    _positionController = positionController ?? CustomSinglePositionController(pos: max((startPos ?? 0) - 1, 0));

    controller.addListener(_onChangePageListener);
    _positionController.addListener(_onChangePosListener);

    _currentPageIndex = startPageIndex ?? 0;
    _currentPos = _positionController.pos;
    notifyListeners();
  }


  Future<void> animateToPage({required int pageIndex, int pos = 0})async{
    await _pageController.animateToPage(pageIndex, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    _positionController.setPos(max(pos - 1, 0));
  }

  Future<void> animateToNextPage()async{
    await _pageController.animateToPage(_currentPageIndex + 1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  Future<void> animateToPreviousPage()async{
    await _pageController.animateToPage(_currentPageIndex - 1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void _onChangePageListener(){
    _currentPageIndex = controller.page?.toInt() ?? 1;
    notifyListeners();
  }

  void _onChangePosListener(){
    _currentPos = positionController.pos;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_onChangePageListener);
    _positionController.removeListener(_onChangePosListener);
  }
}