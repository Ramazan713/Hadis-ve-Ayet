

class Hadith{
  final int? id;
  final int bookId;
  final String content;
  final String source;
  final int contentSize;

  const Hadith({this.id,required this.bookId,required this.content,required this.contentSize,required this.source});
}