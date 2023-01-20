
import 'package:equatable/equatable.dart';

abstract class IEditionEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class EditionEventInit extends IEditionEvent{}

class EditionEventRefreshData extends IEditionEvent{
  final bool forceRemote;
  EditionEventRefreshData({this.forceRemote=false});

  @override
  List<Object?> get props => [forceRemote];
}

class EditionEventSetSelected extends IEditionEvent{
  final String identifier;
  EditionEventSetSelected({required this.identifier});

  @override
  List<Object?> get props => [identifier];
}

