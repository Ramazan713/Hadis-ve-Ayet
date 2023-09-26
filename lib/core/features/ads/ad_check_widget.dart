import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:hadith/core/features/premium/bloc/premium_bloc.dart';
import 'package:hadith/core/features/premium/bloc/premium_state.dart';
import 'package:hadith/core/utils/ad_util.dart';

class AdCheckWidget extends StatefulWidget {

  final Widget child;

  const AdCheckWidget({
    super.key,
    required this.child
  });

  @override
  State<AdCheckWidget> createState() => _AdCheckWidgetState();
}


class _AdCheckWidgetState extends State<AdCheckWidget>  with WidgetsBindingObserver{


  Timer? _adTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    if(!_isPremium() && AdUtil.interstitialAd == null){
      _checkAdOpeningCounter();
      _checkAdStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusLost: (){
        _adTimer?.cancel();
      },
      onFocusGained: (){
        if(!_isPremium()){
          _checkAdStatus();
        }
      },
      child: BlocBuilder<PremiumBloc,PremiumState>(
        builder: (context, state){
          return WillPopScope(
            onWillPop: (){
              final ad = AdUtil.interstitialAd;
              if (!state.isPremium && ad != null) {
                ad.show();
              }
              return Future.value(true);
            },
            child: widget.child,
          );
        },
      ),
    );
  }

  void _checkAdStatus() {
    _adTimer?.cancel();
    _adTimer = Timer.periodic(const Duration(seconds: AdUtil.tickIntervalSeconds), (timer) {
      AdUtil.increaseConsumeSeconds();
    });
  }

  void _checkAdOpeningCounter() {
    AdUtil.increaseOpeningCounter();
  }


  bool _isPremium(){
    return context.read<PremiumBloc>().state.isPremium;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.resumed){
      if(!_isPremium()){
        _checkAdStatus();
      }
    }else if(state == AppLifecycleState.inactive){
      _adTimer?.cancel();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _adTimer?.cancel();
    super.dispose();
  }

}
