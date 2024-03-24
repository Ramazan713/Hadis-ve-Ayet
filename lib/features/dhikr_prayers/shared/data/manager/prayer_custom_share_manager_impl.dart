


import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/manager/prayer_custom_share_manager.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_custom_repo.dart';

class PrayerCustomShareManagerImpl extends PrayerCustomShareManager{

  late final PrayerCustomRepo _prayerCustomRepo;
  PrayerCustomShareManagerImpl({
    required PrayerCustomRepo prayerCustomRepo
  }){
    _prayerCustomRepo = prayerCustomRepo;
  }

  @override
  Future<void> addWithText(String text) async{
    if(text.length > K.addExternalPrayerLenLimit){
      return;
    }
    final prayer = PrayerCustom(
      name: "İsimsiz",
      pronunciationContent: text,
    );
    await _prayerCustomRepo.insertPrayerCustom(prayer);
  }

  @override
  Future<Resource<void>> parseFile(String filePath) async{
    try{
      File file = File(filePath);

      if(await file.exists() && await file.length() > K.parseJsonFileSize){
        return ResourceError("size error");
      }

      final rawData = await file.readAsBytes();
      final Map<String, dynamic> data = jsonDecode(utf8.decode(rawData));

      if(
        !data.containsKey("arabic") ||
        !data.containsKey("name") ||
        !data.containsKey("pronunciation") ||
        !data.containsKey("meaning") ||
        !data.containsKey("source")
      ){
        return ResourceError("Bir hata oluştu:");
      }

      final arabic = data["arabic"];
      final name = data["name"];
      final pronunciation = data["pronunciation"];
      final meaning = data["meaning"];
      final source = data["source"];

      final prayer = PrayerCustom(
        name: name,
        source: source,
        arabicContent: arabic,
        meaningContent: meaning,
        pronunciationContent: pronunciation
      );

      await _prayerCustomRepo.insertPrayerCustom(prayer);
      return ResourceSuccess(null);
    }catch(e){
      return ResourceError("Bir hata oluştu");
    }
  }


  @override
  Uint8List getJsonData(PrayerCustom prayer){
    final jsonData = {
      "app": "Hadith And Verse",
      "name": prayer.name,
      "arabic": prayer.arabicContent,
      "pronunciation": prayer.pronunciationContent,
      "meaning": prayer.meaningContent,
      "source": prayer.source
    };
    return utf8.encode(jsonEncode(jsonData));
  }

}