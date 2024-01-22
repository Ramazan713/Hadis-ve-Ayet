

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/get_title/domain/repo/title_repo.dart';

import 'get_title_event.dart';
import 'get_title_state.dart';

class GetTitleBloc extends Bloc<IGetTitleEvent,GetTitleState>{

  late final TitleRepo _titleRepo;

  GetTitleBloc({
    required TitleRepo titleRepo
  }): super(GetTitleState.init()){
    _titleRepo = titleRepo;

    on<GetTitleEventRequestTitle>(_onRequestTitle,transformer: restartable());
  }

  void _onRequestTitle(GetTitleEventRequestTitle event,Emitter<GetTitleState>emit)async{
    final title = await _titleRepo.getTitle(event.itemId, event.titleEnum);
    emit(state.copyWith(title: title));
  }

}