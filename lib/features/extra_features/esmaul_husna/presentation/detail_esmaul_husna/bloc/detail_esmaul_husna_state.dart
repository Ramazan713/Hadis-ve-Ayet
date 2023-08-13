

import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/model/esmaul_husna.dart';
import 'package:hadith/models/navigation_state.dart';

class DetailEsmaulHusnaStateOld extends Equatable{
  final List<EsmaulHusna> items;
  final EsmaulHusna? currentItem;
  final bool jumpToPage;
  final String? message;
  final NavigationState? navigationState;
  final bool isLoading;
  final FontSize fontSize;

  const DetailEsmaulHusnaStateOld({required this.items,this.message,required this.isLoading,
    this.currentItem,required this.jumpToPage,this.navigationState,
    required this.fontSize
  });

  DetailEsmaulHusnaStateOld copyWith({List<EsmaulHusna>? items,
    NavigationState?navigationState,bool setNavigationState=false,
    EsmaulHusna?currentItem,bool setCurrentItem=false,bool?jumpToPage,
    bool?isLoading,
    String?message,bool setMessage=false,
    FontSize? fontSize
  }){
    return DetailEsmaulHusnaStateOld(
        items: items??this.items,
        currentItem: setCurrentItem?currentItem:this.currentItem,
        jumpToPage: jumpToPage??this.jumpToPage,
        message: setMessage?message:this.message,
        navigationState: setNavigationState?navigationState:this.navigationState,
        isLoading: isLoading??this.isLoading,
        fontSize: fontSize??this.fontSize
    );
  }

  static DetailEsmaulHusnaStateOld init(){
    return const DetailEsmaulHusnaStateOld(
        items: [],
        jumpToPage:false,
        isLoading: false,
        fontSize: FontSize.medium
    );
  }

  @override
  List<Object?> get props => [items,currentItem,jumpToPage,message,
    navigationState,isLoading,fontSize];
}