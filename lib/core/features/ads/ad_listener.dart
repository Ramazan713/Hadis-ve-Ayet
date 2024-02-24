import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hadith/core/constants/secrets.dart';
import 'package:hadith/core/features/ads/bloc/ad_bloc.dart';
import 'package:hadith/core/features/ads/bloc/ad_event.dart';
import 'package:hadith/core/features/ads/bloc/ad_state.dart';

class AdListener extends StatelessWidget {
  final Widget child;
  const AdListener({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AdBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<AdBloc,AdState>(
          listenWhen: (prevState, nextState){
            return prevState.loadAd != nextState.loadAd;
          },
          listener: (context, state){
            final loadAd = state.loadAd;
            if(loadAd){
              bloc.add(AdEventClearLoadAd());
              InterstitialAd.load(
                adUnitId: Secrets.interstitialAdId,
                request: const AdRequest(),
                adLoadCallback: InterstitialAdLoadCallback(
                  onAdLoaded: (InterstitialAd ad) {
                    bloc.add(AdEventSetAdd(ad: ad));
                    ad.fullScreenContentCallback = FullScreenContentCallback(
                        onAdDismissedFullScreenContent: (InterstitialAd ad) {
                          ad.dispose();
                        },
                        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
                          ad.dispose();

                          bloc.add(AdEventLoadAdFailure());
                        },
                        onAdShowedFullScreenContent: (ad) {
                          bloc.add(AdEventResetValues());
                        }
                    );
                  },
                  onAdFailedToLoad: (LoadAdError error) {},
                ));
            }
          },
        ),
        BlocListener<AdBloc,AdState>(
          listenWhen: (prevState, nextState){
            return prevState.showAd != nextState.showAd ||
                prevState.ad != nextState.ad;
          },
          listener: (context, state){
            final showAd = state.showAd;
            final ad = state.ad;
            if(showAd && ad != null){
              bloc.add(AdEventClearShowAd());
              ad.show();
            }
          }
        )
      ],
      child: child,
    );
  }
}
