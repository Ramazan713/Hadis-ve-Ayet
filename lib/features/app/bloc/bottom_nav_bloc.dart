import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';




class BottomNavBloc extends Bloc<IBottomNavEvent,BottomNavState>{
  BottomNavBloc() : super(const BottomNavState(isCollapsed: false,withAnimation: false)){
    on<BottomNavChangeVisibility>(_onSetVisibility,transformer: restartable());
    on<BottomNavChangeVisibilityWithDelay>(_onSetVisibilityWithDelay,transformer: restartable());
  }

  Timer? _timer;

  void _onSetVisibility(BottomNavChangeVisibility event,Emitter<BottomNavState>emit)async {

    _timer?.cancel();
    _timer=Timer(const Duration(milliseconds: 300),(){
      add(BottomNavChangeVisibilityWithDelay(isCollapsed: event.isCollapsed,withAnimation: event.withAnimation));
    });

  }
  void _onSetVisibilityWithDelay(BottomNavChangeVisibilityWithDelay event,Emitter<BottomNavState>emit)async {
    emit(state.copyWith(isCollapsed:event.isCollapsed,withAnimation: event.withAnimation));
  }

}