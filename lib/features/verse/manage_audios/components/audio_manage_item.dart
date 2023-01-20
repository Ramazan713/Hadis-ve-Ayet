import 'package:flutter/material.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/features/verse/manage_audios/manage_audio_model.dart';

class AudioManageItem extends StatelessWidget {
  final void Function()? btnApproved;
  final ManageAudioModel item;
  const AudioManageItem({Key? key,this.btnApproved,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: ListTile(
        title: Text("${item.key} ${item.keyName}",style: Theme.of(context).textTheme.bodyLarge,),
        tileColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        trailing: IconButton(
            onPressed: (){
              showCustomAlertBottomDia(
                  context,
                  title: "Silmek istediğinize emin misiniz?",
                  content: "Bu işlem geri alınamaz",
                  btnApproved: btnApproved
              );
            },
            icon: Icon(Icons.delete_forever,color: Theme.of(context).errorColor,)
        ),
      ),
    );
  }
}