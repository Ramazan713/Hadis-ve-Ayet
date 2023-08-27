

sealed class ResourceCustom<T,Y>{
  ResourceCustom._();
  factory ResourceCustom.success(T data)=>ResourceCustomSuccess<T,Y>(data);
  factory ResourceCustom.error(Y error)=>ResourceCustomError<T,Y>(error);
}

class ResourceCustomSuccess<T,Y> extends ResourceCustom<T,Y>{
  final T data;
  ResourceCustomSuccess(this.data) : super._();
}

class ResourceCustomError<T,Y> extends ResourceCustom<T,Y>{
  final Y error;
  ResourceCustomError(this.error):super._();
}
