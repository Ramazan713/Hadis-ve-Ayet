

import 'package:equatable/equatable.dart';
import 'package:hadith/core/features/share/share_ui_event.dart';

class ShareState extends Equatable{

  final String? message;
  final ShareUiEvent? shareUiEvent;
  final bool loading;

  const ShareState({
    this.message,
    this.shareUiEvent,
    required this.loading
  });

  ShareState copyWith({
    ShareUiEvent? shareUiEvent, bool setShareUiEvent = false,
    String? message, bool setMessage = false,
    bool? loading
  }){
    return ShareState(
        shareUiEvent: setShareUiEvent ? shareUiEvent : this.shareUiEvent,
        message: setMessage ? message : this.message,
        loading: loading ?? this.loading
    );
  }

  static ShareState init(){
    return const ShareState(
        loading: false
    );
  }


  @override
  List<Object?> get props => [shareUiEvent, message, loading];


}