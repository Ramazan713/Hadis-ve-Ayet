
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class IAdEvent{}

class AdEventStartClock extends IAdEvent{}

class AdEventStopClock extends IAdEvent{}

class AdEventIncreaseCounter extends IAdEvent{}

class AdEventIncreaseConsumeSeconds extends IAdEvent{}

class AdEventResetValues extends IAdEvent{}

class AdEventClearLoadAd extends IAdEvent{}

class AdEventClearShowAd extends IAdEvent{}

class AdEventCheckShowStatus extends IAdEvent{}

class AdEventLoadAdFailure extends IAdEvent{}


class AdEventSetAdd extends IAdEvent{
  final InterstitialAd ad;
  AdEventSetAdd({required this.ad});
}