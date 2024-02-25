
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/features/verse_audio/domain/notification/i_verse_download_audio_notification.dart';
import 'package:hadith/core/features/verse_audio/domain/notification/i_verse_listen_audio_notification.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';

Future<void> handleAudioPermission({
  required BuildContext context,
  required bool showRationale,
  bool usedForDownloading = false,
  void Function(bool)? onResult,
  void Function()? onAfterRequest,
  void Function()? onPermanentDeclined,
  String? content,
  String? title,
})async{
  if(showRationale){
    showCustomAlertDia(
      context,
      title: title ?? _getTitle(usedForDownloading),
      content: content ?? _getContent(usedForDownloading),
      approveLabel: "İzin ver",
      middleWidget: TextButton(
        onPressed: ()async{
          _savePrefDeclinedResult(context, usedForDownloading).then((value){
            Navigator.of(context).pop();
            onPermanentDeclined?.call();
            onResult?.call(false);
          });
        },
        child: const Text("Bir daha sorma")
      ),
      btnApproved: ()async{
        final result = await _requestPermission(usedForDownloading);
        onResult?.call(result);
        onAfterRequest?.call();
      }
    );
  }else{
    final result = await _requestPermission(usedForDownloading);
    onResult?.call(result);
    onAfterRequest?.call();
  }
}


String _getTitle(bool usedForDownloading){
  return "Bildirim görmek için izin gerekli";
}

String _getContent(bool usedForDownloading){
  if(usedForDownloading){
    return "indirme durumunu görmek ve yönetmek için gerekebilir";
  }
  return "ses oynatıcısını yönetmek ve durum bilgisini görmek için gerekebilir";
}

Future<void> _savePrefDeclinedResult(BuildContext context, bool usedForDownloading)async{
  final appPref = context.read<AppPreferences>();
  final prefKey = usedForDownloading ? KPref.askDownloadAudioNotificationPermission
      : KPref.askListenAudioNotificationPermission;
  return appPref.setItem(prefKey, false);
}



Future<bool> _requestPermission(bool usedForDownloading)async{
  if(usedForDownloading){
    return await IVerseDownloadAudioNotification.requestNotificationPermission();
  }
  return  await IVerseListenAudioNotification.requestNotificationPermission();
}
