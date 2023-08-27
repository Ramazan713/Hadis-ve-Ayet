

import 'package:rxdart/rxdart.dart';

abstract class ConnectivityService{

  Future<bool> get hasConnected;

  ValueStream<bool> get hasConnectionStream;
}