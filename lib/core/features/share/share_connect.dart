import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/features/share/bloc/share_state.dart';
import 'package:hadith/core/features/share/share_ui_event.dart';
import 'package:hadith/utils/loading_util.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:share_plus/share_plus.dart';

class ShareConnect extends StatelessWidget {

  final Widget child;

  const ShareConnect({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShareBloc>();

    return BlocListener<ShareBloc,ShareState>(
      listener: (context,state){
        final uiEvent = state.shareUiEvent;
        final message = state.message;
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
          }
          bloc.add(ShareEventClearShareUiEvent());
        }

        if(message!=null){
          ToastUtils.showLongToast(message);
          bloc.add(ShareEventClearMessage());
        }

        if(state.loading){
          LoadingUtil.requestLoading(context);
        }else{
          LoadingUtil.requestCloseLoading(context);
        }

      },
      child: child,
    );
  }
}
