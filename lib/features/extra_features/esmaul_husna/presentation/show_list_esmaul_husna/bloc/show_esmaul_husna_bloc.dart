

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/font_size_enum.dart';
import 'package:hadith/features/extra_features/esmaul_husna/domain/repo/esmaul_husna_repo.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/show_list_esmaul_husna/bloc/show_esmaul_husna_event.dart';
import 'package:hadith/features/extra_features/esmaul_husna/presentation/show_list_esmaul_husna/bloc/show_esmaul_husna_state.dart';
import 'package:hadith/utils/font_size_helper.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowEsmaulHusnaBloc extends Bloc<IShowEsmaulHusnaEvent,ShowEsmaulHusnaState>{

  late final EsmaulHusnaRepo _esmaulHusnaRepo;
  ShowEsmaulHusnaBloc({required EsmaulHusnaRepo esmaulHusnaRepo}) : super(ShowEsmaulHusnaState.init()){
    _esmaulHusnaRepo = esmaulHusnaRepo;

    on<ShowEsmaulHusnaEventInit>(_onInit);

    add(ShowEsmaulHusnaEventInit());
  }

  void _onInit(ShowEsmaulHusnaEventInit event,Emitter<ShowEsmaulHusnaState>emit)async{
    final items = await _esmaulHusnaRepo.getAllEsmaulHusna();
    emit(state.copyWith(items: items));

    await emit.forEach<FontSize>(FontSizeHelper.streamFontSize, onData: (data){
      return state.copyWith(fontSize: data);
    });

  }
}