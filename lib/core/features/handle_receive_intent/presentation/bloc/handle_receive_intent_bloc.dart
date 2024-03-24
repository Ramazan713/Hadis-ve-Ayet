
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
import 'package:hadith/core/extensions/resource_extension.dart';
import 'package:hadith/core/features/handle_receive_intent/presentation/bloc/handle_receive_intent_event.dart';
import 'package:hadith/core/features/handle_receive_intent/presentation/bloc/handle_receive_intent_state.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/manager/prayer_custom_share_manager.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class HandleReceiveIntentBloc extends Bloc<IHandleReceiveIntentEvent,HandleReceiveIntentState>{


  StreamSubscription<List<SharedMediaFile>>? _subsListener;

  late final PrayerCustomShareManager _prayerCustomShareManager;

  HandleReceiveIntentBloc({
    required PrayerCustomShareManager prayerCustomShareManager
  }): super(HandleReceiveIntentState.init()){
    _prayerCustomShareManager = prayerCustomShareManager;

    on<HandleReceiveIntentEventInit>(_onInit,transformer: restartable());
    on<HandleReceiveIntentEventClearNavigation>(_onClearNavigation,transformer: restartable());
    on<HandleReceiveIntentEventClearMessage>(_onClearMessage,transformer: restartable());
    on<HandleReceiveIntentEventUpdateState>(_onUpdateState,transformer: restartable());
    on<HandleReceiveIntentEventClearCompletedLoading>(_onClearCompletedLoading,transformer: restartable());

    add(HandleReceiveIntentEventInit());
  }

  void _onInit(HandleReceiveIntentEventInit event,Emitter<HandleReceiveIntentState>emit)async{

    ReceiveSharingIntent.getInitialMedia().then((files) {
      _handleResults(files);
      ReceiveSharingIntent.reset();
    });

    _subsListener = ReceiveSharingIntent.getMediaStream().listen((files) {
      _handleResults(files);
    });
  }

  void _onUpdateState(HandleReceiveIntentEventUpdateState event,Emitter<HandleReceiveIntentState>emit)async{
    emit(event.state);
  }

  void _onClearNavigation(HandleReceiveIntentEventClearNavigation event,Emitter<HandleReceiveIntentState>emit)async{
    emit(state.copyWith(navigateToCustomPrayer: false));
  }

  void _onClearMessage(HandleReceiveIntentEventClearMessage event,Emitter<HandleReceiveIntentState>emit)async{
    emit(state.copyWith(message: null));
  }

  void _onClearCompletedLoading(HandleReceiveIntentEventClearCompletedLoading event,Emitter<HandleReceiveIntentState>emit)async{
    emit(state.copyWith(loadingEnum: LoadingEnum.idle));
  }


  void _handleResults(List<SharedMediaFile> files) async{
    if(files.isEmpty)return;
    final file = files.first;

    add(HandleReceiveIntentEventUpdateState(state: state.copyWith(
      navigateToCustomPrayer: true
    )));

    switch(file.mimeType){
      case "text/plain":
        await _prayerCustomShareManager.addWithText(file.path);
        add(HandleReceiveIntentEventUpdateState(state: state.copyWith(
          message: "Başarılı",
        )));
        break;
      case "application/json":
        final result = await _prayerCustomShareManager.parseFile(file.path);
        result.handle(
          onError: (error){
            add(HandleReceiveIntentEventUpdateState(state: state.copyWith(message: error)));
          },
          onSuccess: (x){
            add(HandleReceiveIntentEventUpdateState(state: state.copyWith(
              message: "Başarılı",
            )));
          }
        );
        break;
    }
  }



  @override
  Future<void> close() {
    _subsListener?.cancel();
    return super.close();
  }

}