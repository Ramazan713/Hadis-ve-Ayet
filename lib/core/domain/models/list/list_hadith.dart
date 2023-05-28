

class ListHadith{
  final int listId;
  final int hadithId;
  final int pos;

  const ListHadith({required this.listId,required this.hadithId,required this.pos});


  ListHadith copyWith({int? listId, int? hadithId, int? pos}){
    return ListHadith(
        listId: listId ?? this.listId,
        hadithId: hadithId ?? this.hadithId,
        pos: pos ?? this.pos
    );
  }
}