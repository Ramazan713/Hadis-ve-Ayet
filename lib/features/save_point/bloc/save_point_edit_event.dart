import 'package:equatable/equatable.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/save_point/constants/scope_filter_enum.dart';
import 'package:hadith/db/entities/savepoint.dart';
import 'package:hadith/features/save_point/save_point_bloc/save_point_event.dart';
import 'package:hadith/features/save_point/save_point_param.dart';

abstract class ISavePointEditEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SavePointEditEventInitialRequest extends ISavePointEditEvent{
  final SavePointParam savePointParam;

  SavePointEditEventInitialRequest({required this.savePointParam});

  @override
  List<Object?> get props => [savePointParam];
}

class SavePointEditEventChangeSavePoint extends ISavePointEditEvent{
  final SavePoint savePoint;
  SavePointEditEventChangeSavePoint(this.savePoint);
}

class SavePointEditEventChangeScopeFilter extends ISavePointEditEvent{
  final ScopeFilterEnum scopeFilter;
  SavePointEditEventChangeScopeFilter(this.scopeFilter);
}

class SavePointEditEventInsert extends ISavePointEditEvent{
  final SavePointParam savePointParam;
  final DateTime dateTime;
  final String title;

  SavePointEditEventInsert({required this.savePointParam,required this.dateTime,required this.title});

  @override
  List<Object?> get props => [savePointParam,dateTime,title];
}

class SavePointEditEventOverride extends ISavePointEditEvent{
  final SavePoint selectedSavePoint;
  final SavePointParam savePointParam;

  SavePointEditEventOverride({required this.selectedSavePoint,required this.savePointParam});
  @override
  List<Object?> get props => [selectedSavePoint,savePointParam];
}


