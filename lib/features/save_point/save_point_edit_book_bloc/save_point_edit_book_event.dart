

import 'package:equatable/equatable.dart';
import 'package:hadith/db/entities/savepoint.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';

abstract class ISavePointBookEditEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SavePointBookEditEventRequest extends ISavePointBookEditEvent{
  final List<BookScopeEnum>bookScopes;
  final OriginTag? filter;
  SavePointBookEditEventRequest({
    required this.bookScopes,this.filter});

  @override
  List<Object?> get props => [bookScopes,filter];
}

class SavePointBookEditEventSelectSavePoint extends ISavePointBookEditEvent{
  final SavePoint? savePoint;
  SavePointBookEditEventSelectSavePoint({required this.savePoint});
}

class SavePointBookEditEventSelectOrigin extends ISavePointBookEditEvent{
  final OriginTag? originTag;
  SavePointBookEditEventSelectOrigin({required this.originTag});
}
