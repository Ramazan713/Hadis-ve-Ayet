import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_bloc.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_event.dart';
import 'package:hadith/core/presentation/dialogs/show_select_download_backup_dia.dart';
import 'package:hadith/core/presentation/components/icon_text_item.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';

void showBackupDia(BuildContext context){

  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context) {
      return const Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 7),
        child: _DialogContent(),
      );
  });
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getHeader(context),
                  const SizedBox(height: 29,),
                  getFormBackupButton(context),
                  const SizedBox(height: 16,),
                  getDownloadBackupButton(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHeader(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      children: [
        const IconTextItem(
          title: "Bulut Yedekleme",
          iconData: Icons.cloud,
          margins: EdgeInsets.symmetric(horizontal: 48),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        )
      ],
    );
  }

  Widget getFormBackupButton(BuildContext context){
    final backupBloc = context.read<BackupBloc>();
    return FilledButton(
      onPressed: (){
        showCustomAlertDia(
          context,
          title: "Devam etmek istiyor musunuz?",
          content: "Bazı yedek dosyalarınızın değişmesine neden olabilir",
          btnApproved: (){
            backupBloc.add(BackupEventUploadBackup(isAuto: false));
          }
        );
      },
      child: const Text("Yedek Oluştur"),
    );
  }

  Widget getDownloadBackupButton(BuildContext context){
    return FilledButton(
      onPressed: (){
        showDownloadBackupDia(context);
      },
      child: const Text("Buluttan İndir"),
    );
  }
}

