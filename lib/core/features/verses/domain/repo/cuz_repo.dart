import '../model/cuz.dart';

abstract class CuzRepo{

  Future<List<Cuz>>getAllCuz();

  Future<Cuz?>getCuz(int cuzNo);
}