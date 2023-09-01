
import 'package:hadith/core/domain/models/i_menu_item.dart';

enum LocalDestinationScope with IMenuItem{
  wide,restrict;

  String getDescription(){
    switch(this){
      case LocalDestinationScope.wide:
        return "Hepsi";
      case LocalDestinationScope.restrict:
        return "Geçerli Alan";
    }
  }

  @override
  get title => getDescription();

  @override
  get iconInfo => null;

}
