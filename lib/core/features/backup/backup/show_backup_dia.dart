import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_bloc.dart';
import 'package:hadith/core/features/backup/backup/bloc/backup_event.dart';
import 'package:hadith/core/features/backup/backup_meta/show_select_download_backup_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/features/backup/components/icon_text_item.dart';
import 'package:hadith/widgets/buttons/custom_button1.dart';
import 'package:hadith/widgets/buttons/custom_button_positive.dart';

void showBackupDia(BuildContext context){

  final backupBloc = context.read<BackupBloc>();

  showDialog(context: context, builder: (context){
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 7),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19,vertical: 13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const IconTextItem(
                        iconData: Icons.cloud,
                        title: "Bulut yedekleme",
                      ),
                      const SizedBox(height: 29,),
                      CustomButtonPositive(onTap: (){
                        showCustomAlertDia(
                          context,
                          title: "Devam etmek istiyor musunuz?",
                          content: "Bazı yedek dosyalarınızın değişmesine neden olabilir",
                          btnApproved: (){
                            backupBloc.add(BackupEventUploadBackup(isAuto: false));
                          });
                      },label:"Yedek Oluştur" ,),
                      const SizedBox(height: 13,),
                      CustomButtonPositive(
                        onTap: (){
                          showDownloadBackupDia(context);
                        },
                        label:"Buluttan İndir" ,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 23,),
              CustomButton1(onTap: (){
                Navigator.pop(context);
              },label: "Iptal",)
            ],
          ),
        ),
      ),
    );
  });
}