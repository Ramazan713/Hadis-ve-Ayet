

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hadith/features/verse/verse_download_audio/constants/download_audio_enum.dart';

import '../../../widgets/custom_button_negative.dart';
import '../../../widgets/custom_button_positive.dart';

void showAudioDownloadOptions(BuildContext context,{
  required Function(DownloadAudioEnum) onSelected,List<DownloadAudioEnum>?audioEnums}){
  showDialog(context: context, builder: (context){
    final items = audioEnums??DownloadAudioEnum.values;
    final selectedItem = ValueNotifier<DownloadAudioEnum?>(null);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 19,vertical: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:const EdgeInsets.symmetric(vertical: 7),
              child: Text("Ses dosyaları indirme seçenekleri",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700
                ),),
            ),
            ListView.builder(shrinkWrap: true,itemBuilder: (context,index){
              final item=items[index];
              return ValueListenableBuilder<DownloadAudioEnum?>(valueListenable: selectedItem,
                  builder: (context,value,child){
                    return  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 7),
                      child: ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                        tileColor: value == item?Theme.of(context).selectedRowColor:Theme.of(context).cardColor,
                        title: Text(item.description,style: Theme.of(context).textTheme.bodyMedium,),
                        onTap: (){
                          selectedItem.value=item;
                        },
                      ),
                    );
                  });
            },itemCount: items.length,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButtonNegative(onTap: (){Navigator.pop(context);}),
                CustomButtonPositive(onTap: (){
                  final item = selectedItem.value;
                  if(item!=null){
                    Navigator.of(context,rootNavigator: true).pop();
                    onSelected.call(item);
                  }
                }),
              ],
            )
          ],
        ),
      ),
    );
  });
}