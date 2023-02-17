
import 'package:equatable/equatable.dart';

class NavigationState extends Equatable{
  final String destination;
  final Object? parameters;

  const NavigationState({required this.destination,required this.parameters});

  @override
  List<Object?> get props => [destination,parameters];
}