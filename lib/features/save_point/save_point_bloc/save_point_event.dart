import 'package:equatable/equatable.dart';
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/features/save_point/model/savepoint.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/save_point/save_point_param.dart';
import 'package:hadith/models/save_point_argument.dart';

abstract class ISavePointEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SavePointEventRequest extends ISavePointEvent{
  final SavePointLoadArg savePointArg;
  final OriginTag originTag;

  SavePointEventRequest({required this.savePointArg,required this.originTag});
}

class SavePointEventRequestWithId extends ISavePointEvent{
  final int savePointId;
  SavePointEventRequestWithId({required this.savePointId});
}

class SavePointEventAutoInsert extends ISavePointEvent{
  final SavePointParam savePointParam;
  SavePointEventAutoInsert({required this.savePointParam});

  @override
  List<Object?> get props => [savePointParam];
}



class SavePointEventRename extends ISavePointEvent{
  final SavePoint savePoint;
  final String newTitle;
  SavePointEventRename({required this.savePoint,required this.newTitle});

  @override
  List<Object?> get props => [savePoint,newTitle];
}

class SavePointEventDelete extends ISavePointEvent{
  final SavePoint savePoint;
  SavePointEventDelete({required this.savePoint});

  @override
  List<Object?> get props => [savePoint];
}



