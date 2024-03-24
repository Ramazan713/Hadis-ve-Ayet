



import 'package:hadith/core/features/handle_receive_intent/presentation/bloc/handle_receive_intent_state.dart';

abstract class IHandleReceiveIntentEvent{}

class HandleReceiveIntentEventInit extends IHandleReceiveIntentEvent{}

class HandleReceiveIntentEventUpdateState extends IHandleReceiveIntentEvent{
  final HandleReceiveIntentState state;
  HandleReceiveIntentEventUpdateState({required this.state});
}

class HandleReceiveIntentEventClearCompletedLoading extends IHandleReceiveIntentEvent{}

class HandleReceiveIntentEventClearNavigation extends IHandleReceiveIntentEvent{}

class HandleReceiveIntentEventClearMessage extends IHandleReceiveIntentEvent{}
