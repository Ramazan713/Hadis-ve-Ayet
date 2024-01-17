
import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';

class VerseNumber extends Equatable implements ISearchableSelectItem{
  final String text;

  const VerseNumber({required this.text});

  @override
  List<Object?> get props => [text];

  @override
  String get searchableText => text.toLowerCase();

  @override
  String get title => text;

  static List<VerseNumber> from(List<String> items){
    return items.map((e) => VerseNumber(text: e)).toList();
  }
}