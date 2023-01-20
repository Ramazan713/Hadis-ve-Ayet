

import 'package:flutter/material.dart';
import 'package:hadith/features/save_point/constants/origin_tag_enum.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';

void showVoiceOptions(BuildContext context,{Function(QuranAudioOption option)?onTap,Function()?onClose,OriginTag?originTag}){
  final List<QuranAudioOption> options = [];
  if(originTag!=null){
    switch(originTag){
      case OriginTag.surah:
        options.addAll([QuranAudioOption.surah,QuranAudioOption.page,QuranAudioOption.verse,]);
        break;
      case OriginTag.cuz:
        options.addAll(QuranAudioOption.values);
        break;
      default:
        onTap?.call(QuranAudioOption.verse);
        return;
    }
  }else{
    options.addAll(QuranAudioOption.values);
  }

  showModalBottomSheet(
      context: context,
      builder: (context){
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20,top: 5),
            child: Column(
              children: [
                Align(
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.close)),
                  alignment: Alignment.topRight,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Text("Dinlemek istediğiniz kategoriyi seçiniz",style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center),
                ),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    final option = options[index];
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
                  itemCount: options.length,
                ),
              ],
            ),
          ),
        );
      }
  ).then((value){
    onClose?.call();
  });
}