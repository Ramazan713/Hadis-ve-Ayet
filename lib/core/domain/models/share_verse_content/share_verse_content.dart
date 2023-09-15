
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/extensions/string_ext.dart';
part 'share_verse_content.freezed.dart';

@freezed
class ShareVerseContent with _$ShareVerseContent{
  const ShareVerseContent._();

  const factory ShareVerseContent({
    String? title,
    String? arabicContent,
    String? meaningContent,
    String? content,
    Map<String,String?>? others
  }) = _ShareVerseContent;

  String getShareText(){
    final buffer = StringBuffer();

    if(title!=null){
      buffer.write("$title\n\n");
    }

    final shareArabicContent = arabicContent;
    if(shareArabicContent.isNotEmptyString){
      buffer.write("Arapçası:\n");
      buffer.write("$shareArabicContent\n\n");
    }

    final shareContent = content;
    if(shareContent.isNotEmptyString){
      buffer.write("Okunuşu:\n");
      buffer.write("$content\n\n");
    }

    final shareMeaningContent = meaningContent;
    if(shareMeaningContent.isNotEmptyString){
      buffer.write("Anlamı:\n");
      buffer.write("$shareMeaningContent\n\n");
    }

    final shareOthers = others;
    if(shareOthers!=null){
      for(final key in shareOthers.keys){
        final value = shareOthers[key];
        if(value.isEmptyString) continue;
        buffer.write("$key:\n");
        buffer.write("$value\n\n");
      }
    }

    return buffer.toString();
  }
}