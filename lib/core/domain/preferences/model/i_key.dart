
import 'package:equatable/equatable.dart';

abstract class IKey extends Equatable{
  String get key;

  @override
  List<Object?> get props => [key];
}