
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'audio_attribute_state.g.dart';

@JsonSerializable(explicitToJson: true)
class AudioAttributeState extends Equatable{
  final int?savepointId;

  const AudioAttributeState({this.savepointId});

  AudioAttributeState copyWith({int?savepointId,bool setSavepointId=false}){
    return AudioAttributeState(
        savepointId: setSavepointId?savepointId:this.savepointId
    );
  }

  static AudioAttributeState init(){
    return const AudioAttributeState();
  }

  factory AudioAttributeState.fromJson(Map<String, dynamic> json) => _$AudioAttributeStateFromJson(json);

  Map<String, dynamic> toJson() => _$AudioAttributeStateToJson(this);

  @override
  List<Object?> get props => [savepointId];
}