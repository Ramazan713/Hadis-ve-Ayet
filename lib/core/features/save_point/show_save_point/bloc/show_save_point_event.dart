
import 'package:hadith/core/domain/enums/save_point/save_point_type.dart';
import 'package:hadith/core/domain/models/save_point.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

abstract class IShowSavePointEvent{}


class ShowSavePointEventLoadData extends IShowSavePointEvent{
  final List<BookScopeEnum> scopes;
  final SavePointType? filter;
  ShowSavePointEventLoadData({required this.scopes, required this.filter});
}


class ShowSavePointEventChangeMenuItem extends IShowSavePointEvent{
  final SavePointType savePointType;
  ShowSavePointEventChangeMenuItem({required this.savePointType});
}


class ShowSavePointEventRename extends IShowSavePointEvent{
  final SavePoint savePoint;
  final String newTitle;
  ShowSavePointEventRename({required this.savePoint,required this.newTitle});
}

class ShowSavePointEventDelete extends IShowSavePointEvent{
  final SavePoint savePoint;
  ShowSavePointEventDelete({required this.savePoint});
}

class ShowSavePointEventSelect extends IShowSavePointEvent{
  final SavePoint? savePoint;
  ShowSavePointEventSelect({required this.savePoint});
}

class ShowSavePointEventLoadAndGo extends IShowSavePointEvent {}

