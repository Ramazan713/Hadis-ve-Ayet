
var _isOpenDialog = false;

Future<void> duplicateDialogHandler({
  required Future<void> Function() func
})async{

  if(_isOpenDialog) return;
  _isOpenDialog = true;

  return func().then((value){
    _isOpenDialog = false;
  });
}