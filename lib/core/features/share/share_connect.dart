import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_event.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_state.dart';
import 'package:hadith/core/features/share/share_ui_event.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_full_loading_dia.dart';
import 'package:hadith/core/utils/toast_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareConnect extends StatelessWidget {
  final Widget child;

  const ShareConnect({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShareBloc>();

   return MultiBlocListener(
      listeners: [
        BlocListener<ShareBloc,ShareState>(
          listenWhen: (prevState, nextState){
            return prevState.message != nextState.message;
          },
          listener: (context,state){
            final message = state.message;
            if(message != null){
              ToastUtils.showLongToast(message);
              bloc.add(ShareEventClearMessage());
            }
          }
        ),
        BlocListener<ShareBloc,ShareState>(
          listenWhen: (prevState, nextState){
            return prevState.shareUiEvent != nextState.shareUiEvent;
          },
          listener: (context,state){
            final uiEvent = state.shareUiEvent;
            if(uiEvent!=null){
              switch(uiEvent){
                case ShareUiEventSharedText _:
                  Share.share(uiEvent.sharedText);
                  break;
                case ShareUiEventCopyText _:
                  Clipboard.setData(ClipboardData(text: uiEvent.copiedText));
                  break;
                case ShareUiEventShareFile _:
                  Share.shareXFiles([XFile(uiEvent.filePath,mimeType: uiEvent.mimeType)]);
                  break;
                case ShareUiEventLaunchUrl _:
                  try {
                    launchUrl(Uri.parse(uiEvent.url), mode: uiEvent.launchMode);
                  } catch (e) {
                    ToastUtils.showLongToast("Bilinmeyen bir hata oluştu");
                  }
                  break;
              }
              bloc.add(ShareEventClearShareUiEvent());
            }
          }
        ),
        BlocListener<ShareBloc,ShareState>(
          listenWhen: (prevState, nextState){
            return prevState.loadingEnum != nextState.loadingEnum;
          },
          listener: (context,state){
            final loadingEnum = state.loadingEnum;
            if(loadingEnum == LoadingEnum.loading){
              showFullLoadingDia(context, showLoading: true);
            }else if(loadingEnum == LoadingEnum.completed){
              bloc.add(ShareEventClearCompletedLoading());
              showFullLoadingDia(context, showLoading: false);
            }
          }
        )
      ],
      child: child,
    );
  }
}
