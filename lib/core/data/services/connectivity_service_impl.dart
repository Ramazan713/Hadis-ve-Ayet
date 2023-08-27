
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hadith/core/domain/services/connectivity_service.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityServiceImpl extends ConnectivityService{

  @override
  Future<bool> get hasConnected async{
   return _isConnectInternet(await Connectivity().checkConnectivity());
  }

  @override
  ValueStream<bool> get hasConnectionStream => Connectivity().onConnectivityChanged
      .map((event) => _isConnectInternet(event)).shareValue();


  bool _isConnectInternet(ConnectivityResult result){
    return [
      ConnectivityResult.ethernet,
      ConnectivityResult.mobile,
      ConnectivityResult.wifi
    ].contains(result);
  }
}