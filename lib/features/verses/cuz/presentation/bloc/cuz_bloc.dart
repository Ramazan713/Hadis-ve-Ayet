import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/topic_save_point.dart';
import 'package:hadith/core/domain/models/topic_save_point.dart';
import 'package:hadith/core/domain/use_cases/topic_save_point/topic_save_point_use_cases.dart';
import 'package:hadith/features/verses/cuz/domain/repo/cuz_repo.dart';

import 'cuz_event.dart';
import 'cuz_state.dart';

class CuzBloc extends Bloc<ICuzEvent,CuzState>{

  late final CuzRepo _cuzRepo;

  CuzBloc({
    required CuzRepo cuzRepo,
  }) : super(CuzState.init()){

    _cuzRepo = cuzRepo;

    on<CuzEventLoadData>(_onLoadData, transformer: restartable());

    add(CuzEventLoadData());
  }

  void _onLoadData(CuzEventLoadData event,Emitter<CuzState>emit)async{
    final data=await _cuzRepo.getAllCuz();
    emit(state.copyWith(items: data));
  }

}