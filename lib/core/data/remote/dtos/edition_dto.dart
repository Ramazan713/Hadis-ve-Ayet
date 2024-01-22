

class EditionDto{
  final String identifier;
  final String englishName;

  EditionDto({required this.identifier,required this.englishName});

  static EditionDto fromJson(json){
    return EditionDto(identifier: json["identifier"], englishName: json["englishName"]);
  }

  static List<EditionDto> fromJsonArr(json){
    return List.from(json).map((e) => fromJson(e)).toList();
  }
}