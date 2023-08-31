import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/features/lists/domain/list_tab_enum.dart';

class ArchiveListState extends Equatable{

  final List<ListViewModel> listModels;
  final String? message;

  const ArchiveListState({
    required this.listModels,
    this.message
  });

  ArchiveListState copyWith({
    List<ListViewModel>? listModels,
    String? message, bool setMessage = false
  }){
    return ArchiveListState(
        listModels: listModels??this.listModels,
        message: setMessage?message:this.message
    );
  }

  static ArchiveListState init(){
    return const ArchiveListState(
        listModels: []
    );
  }

  @override
  List<Object?> get props => [message,listModels];

}