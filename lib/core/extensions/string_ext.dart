
extension StringExt on String?{

  bool get isEmptyString => this == null || this?.isEmpty == true;

  bool get isNotEmptyString => !isEmptyString;

}