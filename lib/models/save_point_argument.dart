

class SavePointLoadArg{
  final String parentKey;
  final int? id;
  final bool loadNearPoint;

  SavePointLoadArg({required this.parentKey,this.id,this.loadNearPoint=false});

  SavePointLoadArg copyWith({String? parentKey,int? id,bool? loadNearPoint, bool setId=false}){
    return SavePointLoadArg(
        parentKey: parentKey ?? this.parentKey,
        loadNearPoint: loadNearPoint ?? this.loadNearPoint,
        id: setId ? id: this.id
    );
  }
}