
extension StringExt on String?{

  bool get isEmptyString => this == null || this?.isEmpty == true;

  bool get isNotEmptyString => !isEmptyString;

  String subStartString(int length,{String suffix = ""}){
    if(this == null) return "";
    if(this!.length <= length) return this!;
    return "${this!.substring(0,length)}$suffix";
  }
}