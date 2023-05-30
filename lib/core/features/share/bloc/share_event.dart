
import 'dart:typed_data';

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/db/entities/verse.dart';

abstract class IShareEvent{}


class ShareEventShareImage extends IShareEvent{
  final ByteData? data;
  final String imageName;

  ShareEventShareImage({required this.data, required this.imageName});
}


class ShareEventCopyHadithText extends IShareEvent{
  final Hadith hadith;
  ShareEventCopyHadithText({required this.hadith});
}

class ShareEventShareHadithText extends IShareEvent{
  final Hadith hadith;
  ShareEventShareHadithText({required this.hadith});
}


class ShareEventCopyVerseText extends IShareEvent{
  final Verse verse;
  ShareEventCopyVerseText({required this.verse});
}

class ShareEventShareVerseText extends IShareEvent{
  final Verse verse;
  ShareEventShareVerseText({required this.verse});
}



class ShareEventSharePdf extends IShareEvent{
  final int listId;
  final String listName;
  final SourceTypeEnum sourceType;
  ShareEventSharePdf({required this.listId, required this.sourceType, required this.listName});
}



class ShareEventSharePdfText extends IShareEvent{
  final int listId;
  final SourceTypeEnum sourceType;
  ShareEventSharePdfText({required this.listId, required this.sourceType});
}

class ShareEventClearMessage extends IShareEvent{}

class ShareEventClearShareUiEvent extends IShareEvent{}

