

abstract class ConnectivityService{

  Future<bool> hasConnected();

  Stream<bool> hasConnectionStream();
}