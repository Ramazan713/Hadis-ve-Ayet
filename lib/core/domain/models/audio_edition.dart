

import 'package:equatable/equatable.dart';

class AudioEdition extends Equatable{
  final String identifier;
  final String name;
  final bool isSelected;
  final String? fileName;

  const AudioEdition({
    required this.identifier,
    required this.name,
    required this.isSelected,
    this.fileName
  });

  @override
  List<Object?> get props => [identifier,name,isSelected];
}