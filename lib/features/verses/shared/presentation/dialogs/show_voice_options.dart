

import 'package:flutter/material.dart';
import 'package:hadith/core/presentation/handlers/duplicate_dialog_handler.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:hadith/features/verses/shared/domain/enums/audio_service.dart';
import 'package:hadith/features/verses/shared/domain/model/select_audio_option.dart';

void showVoiceOptions(
    BuildContext context,
    {
      void Function(QuranAudioOption option)?onTap,
      required SelectAudioOption selectOp,
      required AudioServiceEnum audioServiceEnum
    }
  )
{
  duplicateDialogHandler(func: ()async{
    if(selectOp == SelectAudioOption.verse){
      onTap?.call(QuranAudioOption.verse);
      return;
    }

    final shortTitle = audioServiceEnum == AudioServiceEnum.listenAudio ?
    "Dinlemek" : "Indirmek";
    final items = selectOp.getSelectOptions();

    showModalBottomSheet(
        context: context,
        builder: (context){
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20,top: 5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.close)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Text("$shortTitle istediğiniz kategoriyi seçiniz",style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center),
                  ),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      final option = items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 7),
                        child: ListTile(
                          title: Text(option.description,style: Theme.of(context).textTheme.bodyLarge,),
                          onTap: (){
                            onTap?.call(option);
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)
                          ),
                          tileColor: Theme.of(context).selectedRowColor,
                        ),
                      );
                    },
                    itemCount: items.length,
                  ),
                ],
              ),
            ),
          );
        }
    );
  });
}