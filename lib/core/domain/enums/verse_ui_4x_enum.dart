
import 'package:hadith/core/domain/models/i_menu_item.dart';
import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';

class VerseUi4XEnum with IPrefEnum{

  @override
  final int enumValue;
  const VerseUi4XEnum({required this.enumValue});

  static VerseUi4XEnum get defaultValue =>
      VerseUi4XEnum(enumValue: VerseUi4XEnumOption.defaultTotalValues);

  static VerseUi4XEnum from(int enumValue){
    return VerseUi4XEnum(enumValue: enumValue);
  }

  bool get mealVisible{
    return enumValue % VerseUi4XEnumOption.meal.uiValue == 0;
  }
  bool get arabicVisible{
    return enumValue % VerseUi4XEnumOption.arabic.uiValue == 0;
  }
  bool get pronunciationVisible{
    return enumValue % VerseUi4XEnumOption.pronunciation.uiValue == 0;
  }

  bool get commentVisible{
    return enumValue % VerseUi4XEnumOption.comment.uiValue == 0;
  }

}

enum VerseUi4XEnumOption with IMenuItem{
  arabic(
    uiValue: 2,
    description: "Arapça göster"
  ),
  pronunciation(
    uiValue: 3,
    description: "Okunuşunu göster"
  ),
  meal(
    uiValue: 5,
    description: "Anlamını göster"
  ),
  comment(
    uiValue: 7,
    description: "Açıklamasını göster"
  );

  const VerseUi4XEnumOption({required this.uiValue, required this.description});

  final String description;

  final int uiValue;

  @override
  get title => description;

  @override
  get iconInfo => null;

  static int get defaultTotalValues =>
      VerseUi4XEnumOption.arabic.uiValue *
      VerseUi4XEnumOption.meal.uiValue *
      VerseUi4XEnumOption.pronunciation.uiValue;


  static List<VerseUi4XEnumOption> fromValue(int totalValue){
    final items = <VerseUi4XEnumOption>[];
    if(totalValue % VerseUi4XEnumOption.arabic.uiValue == 0){
      items.add(VerseUi4XEnumOption.arabic);
    }
    if(totalValue % VerseUi4XEnumOption.meal.uiValue == 0){
      items.add(VerseUi4XEnumOption.meal);
    }
    if(totalValue % VerseUi4XEnumOption.pronunciation.uiValue == 0){
      items.add(VerseUi4XEnumOption.pronunciation);
    }
    if(totalValue % VerseUi4XEnumOption.comment.uiValue == 0){
      items.add(VerseUi4XEnumOption.comment);
    }
    if(items.isEmpty) return VerseUi4XEnumOption.values;
    return items;
  }

  static int toValues(List<VerseUi4XEnumOption> options){
    int totalValue = 1;
    for (var element in options) {
      totalValue *= element.uiValue;
    }
    return totalValue;
  }

  static List<VerseUi4XEnumOption> fromVerseUi(VerseUi4XEnum verseUi){
    return VerseUi4XEnumOption.fromValue(verseUi.enumValue);
  }
  static VerseUi4XEnum toVerseUi(List<VerseUi4XEnumOption> options){
    int totalValue = 1;
    for (var element in options) {
      totalValue *= element.uiValue;
    }
    if(totalValue == 1) return VerseUi4XEnum(enumValue: defaultTotalValues);
    return VerseUi4XEnum(enumValue: totalValue);
  }


}