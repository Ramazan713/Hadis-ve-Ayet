


import 'package:hadith/core/utils/resource.dart';

extension ResourceExt<T> on Resource<T>{

  Y? handle<Y>({
    Y Function(T data)? onSuccess,
    Y Function(String error)? onError,
  }){
    final resource = this;

    if(resource is ResourceSuccess<T>){
      return onSuccess?.call(resource.data);
    }
    else if(resource is ResourceError<T>){
      return onError?.call(resource.error);
    }
    return null;
  }

  Resource<Y> handleForResourceReturnType<Y>({
    Resource<Y> Function(T data)? onSuccess,
    Resource<Y> Function(String error)? onError
  }){
    final result = handle(
        onError: (error){
          if(onError!=null){
            return onError(error);
          }else{
            return Resource<Y>.error(error);
          }
        },
        onSuccess: onSuccess
    );
    return result ?? Resource<Y>.error("Bir şeyler yanlış gitti");
  }


  Future<Y?> handleAsync<Y>({
    Future<Y> Function(T data)? onSuccess,
    Future<Y> Function(String error)? onError,
  })async{
    final resource = this;

    if(resource is ResourceSuccess<T>){
      return onSuccess?.call(resource.data);
    }
    else if(resource is ResourceError<T>){
      return onError?.call(resource.error);
    }
    return null;
  }

  Future<Resource<Y>> handleAsyncForResourceReturnType<Y>({
    Future<Resource<Y>> Function(T data)? onSuccess,
    Future<Resource<Y>> Function(String error)? onError
  })async{
    final response = await handleAsync(
        onError: (error){
          if(onError!=null){
            return onError(error);
          }else{
            return Future.value(Resource<Y>.error(error));
          }
        },
        onSuccess: onSuccess
    );
    final result = response ?? Resource<Y>.error("Bir şeyler yanlış gitti");
    return Future.value(result);
  }

}