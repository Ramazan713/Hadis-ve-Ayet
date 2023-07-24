
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hadith/core/domain/services/connectivity_service.dart';

class ConnectivityServiceImpl extends ConnectivityService{

  static final _connectivityBroadCastStream = Connectivity().onConnectivityChanged.asBroadcastStream();

  @override
  Stream<bool> hasConnectionStream() => _connectivityBroadCastStream.map((event) => _isConnectInternet(event));


  @override
  Future<bool> hasConnected()async{
    return _isConnectInternet(await Connectivity().checkConnectivity());
  }

  bool _isConnectInternet(ConnectivityResult result){
    return [
      ConnectivityResult.ethernet,
      ConnectivityResult.mobile,
      ConnectivityResult.wifi
    ].contains(result);
  }
}