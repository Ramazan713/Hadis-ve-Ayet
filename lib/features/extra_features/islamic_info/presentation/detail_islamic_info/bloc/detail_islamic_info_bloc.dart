

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/extra_features/islamic_info/domain/repo/islamic_info_repo.dart';
import 'package:hadith/features/extra_features/islamic_info/presentation/detail_islamic_info/bloc/detail_islamic_info_event.dart';
import 'package:hadith/features/extra_features/islamic_info/presentation/detail_islamic_info/bloc/detail_islamic_info_state.dart';

class DetailIslamicInfoBloc extends Bloc<IDetailIslamicInfoEvent,DetailIslamicInfoState>{

  late final IslamicInfoRepo _infoRepo;

  DetailIslamicInfoBloc({required IslamicInfoRepo infoRepo}) : super(DetailIslamicInfoState.init()){
    _infoRepo = infoRepo;

    on<DetailIslamicInfoEventSetInit>(_onSetInit);

  }

  void _onSetInit(DetailIslamicInfoEventSetInit event,Emitter<DetailIslamicInfoState>emit)async{
    emit(state.copyWith(isLoading: true,infoType: event.infoType));
    final items = await _infoRepo.islamicInfosByType(event.infoType);
    emit(state.copyWith(items: items, isLoading:false));
  }

}