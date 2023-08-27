
import 'package:hadith/core/utils/resource_custom.dart';

extension ResourceCustomExt<T,Y> on ResourceCustom<T,Y>{

  A? handle<A>({
    A Function(T data)? onSuccess,
    A Function(Y error)? onError,
  }){
    final resource = this;

    if(resource is ResourceCustomSuccess<T,Y>){
      return onSuccess?.call(resource.data);
    }
    else if(resource is ResourceCustomError<T,Y>){
      return onError?.call(resource.error);
    }
    return null;
  }

  ResourceCustom<A,Y> handleForResourceReturnType<A>({
    ResourceCustom<A,Y> Function(T data)? onSuccess,
    ResourceCustom<A,Y> Function(Y error)? onError,
    required Y defaultError
  }){
    final result = handle(
        onError: (error){
          if(onError!=null){
            return onError(error);
          }else{
            return ResourceCustom<A,Y>.error(error);
          }
        },
        onSuccess: onSuccess
    );
    return result ?? ResourceCustom<A,Y>.error(defaultError);
  }

}