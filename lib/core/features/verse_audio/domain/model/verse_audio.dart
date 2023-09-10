

class VerseAudio{
  final int mealId;
  final String identifier;
  final String? fileName;
  final bool hasEdited;

  const VerseAudio({
    required this.mealId,
    required this.identifier,
    required this.fileName,
    required this.hasEdited
  });

  VerseAudio copyWith({bool? hasEdited}){
    return VerseAudio(
      mealId: mealId,
      fileName: fileName,
      identifier: identifier,
      hasEdited: hasEdited ?? this.hasEdited
    );
  }

  static String newFileName(String identifier,int mealId){
    return "arabic/$identifier/m$mealId.mp3";
  }


}