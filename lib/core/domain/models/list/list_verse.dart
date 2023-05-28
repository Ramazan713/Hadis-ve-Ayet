

class ListVerse{

  final int listId;
  final int verseId;
  final int pos;

  const ListVerse({required this.listId,required this.verseId,required this.pos});

  ListVerse copyWith({int? listId, int? verseId, int? pos}){
    return ListVerse(
      listId: listId ?? this.listId,
      verseId: verseId ?? this.verseId,
      pos: pos ?? this.pos
    );
  }

}