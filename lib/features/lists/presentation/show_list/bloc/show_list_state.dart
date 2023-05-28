
import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/features/lists/presentation/show_list/models/list_tab_enum.dart';

class ShowListState extends Equatable{

  final ListTabEnum currentTab;
  final bool searchBarVisible;
  final bool fabVisible;
  final List<ListViewModel> listHadiths;
  final List<ListViewModel> listVerses;
  final String? message;

  const ShowListState({
    required this.currentTab,
    required this.searchBarVisible,
    required this.fabVisible,
    required this.listHadiths,
    required this.listVerses,
    this.message
  });

  ShowListState copyWith({
    ListTabEnum? listTab,
    bool? searchBarVisible,
    bool? fabVisible,
    List<ListViewModel>? listHadiths,
    List<ListViewModel>? listVerses,
    String? message, bool setMessage = false
  }){
    return ShowListState(
        currentTab: listTab ?? currentTab,
        searchBarVisible: searchBarVisible??this.searchBarVisible,
        fabVisible: fabVisible??this.fabVisible,
        listHadiths: listHadiths??this.listHadiths,
        listVerses: listVerses??this.listVerses,
        message: setMessage?message:this.message
    );
  }

  static ShowListState init(){
    return ShowListState(
        currentTab: ListTabEnumExt.defaultTab,
        searchBarVisible: false,
        fabVisible: true,
        listHadiths: const [],
        listVerses: const []
    );
  }

  @override
  List<Object?> get props => [message,currentTab,searchBarVisible,fabVisible, listHadiths, listVerses];

}