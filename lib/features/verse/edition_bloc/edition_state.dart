
import 'package:equatable/equatable.dart';
import 'package:hadith/db/entities/audio_edition.dart';

class EditionState extends Equatable{
  final List<AudioEdition>items;
  final bool isLoading;
  final String? error;

  const EditionState({required this.items,required this.isLoading,this.error});

  EditionState copyWith({List<AudioEdition>? items,bool? isLoading,String? error,bool setError=false}){
    return EditionState(items: items??this.items, isLoading: isLoading??this.isLoading,
        error: setError?error:this.error);
  }

  static EditionState init(){
    return const EditionState(items: [], isLoading: false);
  }

  @override
  String toString() {
    return "EditionState(isLoading=$isLoading, error=$error, len=${items.length}, items=$items)";
  }

  @override
  List<Object?> get props => [items,isLoading,error];
}
