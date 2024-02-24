import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:hadith/core/features/ads/bloc/ad_bloc.dart';
import 'package:hadith/core/features/ads/bloc/ad_event.dart';
import 'package:hadith/core/features/premium/presentation/bloc/premium_bloc.dart';
import 'package:hadith/core/features/premium/presentation/bloc/premium_state.dart';

class AdCheckWidget extends StatefulWidget {

  final Widget child;

  const AdCheckWidget({
    super.key,
    required this.child
  });

  @override
  State<AdCheckWidget> createState() => _AdCheckWidgetState();
}


class _AdCheckWidgetState extends State<AdCheckWidget> with WidgetsBindingObserver{

  late final AdBloc adBloc;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    adBloc =  context.read<AdBloc>();
    if(!_isPremium()){
      adBloc.add(AdEventIncreaseCounter());
      adBloc.add(AdEventStartClock());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusLost: (){
        adBloc.add(AdEventStopClock());
      },
      onFocusGained: (){
        if(!_isPremium()){
          adBloc.add(AdEventStartClock());
        }
      },
      child: BlocBuilder<PremiumBloc,PremiumState>(
        builder: (context, state){
          return WillPopScope(
            onWillPop: (){
              if (!state.isPremium) {
                adBloc.add(AdEventCheckShowStatus());
              }
              return Future.value(true);
            },
            child: widget.child,
          );
        },
      ),
    );
  }

  bool _isPremium(){
    return context.read<PremiumBloc>().state.isPremium;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      if(!_isPremium()){
        adBloc.add(AdEventStartClock());
      }
    }else if(state == AppLifecycleState.inactive){
      adBloc.add(AdEventStopClock());
    }
  }

  @override
  void dispose() {
    adBloc.add(AdEventStopClock());
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}