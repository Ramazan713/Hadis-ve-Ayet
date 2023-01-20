import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService{

  static final _connectivityBroadCastStream = Connectivity().onConnectivityChanged.asBroadcastStream();

  static Future<bool>isConnectedInternet()async{
    return _isConnectInternet(await Connectivity().checkConnectivity());
  }

  static bool _isConnectInternet(ConnectivityResult result){
    return result==ConnectivityResult.mobile||result==ConnectivityResult.wifi;
  }
  static Stream<ConnectivityResult> getConnectionStream() => _connectivityBroadCastStream;

  static bool isConnectedInternetWithResult(ConnectivityResult connectivity){
    return _isConnectInternet(connectivity);
  }

}