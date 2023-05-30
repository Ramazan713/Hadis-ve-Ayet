

import 'dart:io';
import 'dart:typed_data';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/repo/share/share_manager.dart';
import 'package:hadith/core/domain/repo/share/share_pdf_repo.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/features/share/bloc/share_state.dart';
import 'package:hadith/core/features/share/share_ui_event.dart';
import 'package:path_provider/path_provider.dart';

class ShareBloc extends Bloc<IShareEvent,ShareState>{

  late final ShareManager _shareManager;
  late final SharePdfRepo _sharePdfRepo;

  ShareBloc({required ShareManager shareManager,required SharePdfRepo sharePdfRepo}): super(ShareState.init()){

    _sharePdfRepo = sharePdfRepo;
    _shareManager = shareManager;

    on<ShareEventShareImage>(_onShareImage, transformer: restartable());
    on<ShareEventCopyHadithText>(_onCopyHadithText, transformer: restartable());
    on<ShareEventShareHadithText>(_onShareHadithText, transformer: restartable());
    on<ShareEventCopyVerseText>(_onCopyVerseText, transformer: restartable());
    on<ShareEventShareVerseText>(_onShareVerseText, transformer: restartable());

    on<ShareEventSharePdfText>(_onSharePdfText, transformer: restartable());
    on<ShareEventSharePdf>(_onSharePdf, transformer: restartable());

    on<ShareEventClearShareUiEvent>(_onClearShareUiEvent, transformer: restartable());
    on<ShareEventClearMessage>(_onClearMessage, transformer: restartable());
  }

  void _onCopyHadithText(ShareEventCopyHadithText event, Emitter<ShareState> emit)async{
    final sharedText = _shareManager.getHadithSharedText(event.hadith);
    emit(state.copyWith(
        shareUiEvent: ShareUiEventCopyText(copiedText: sharedText),
        setShareUiEvent: true,
        message: "Kopyalandı",
        setMessage: true
    ));
  }

  void _onCopyVerseText(ShareEventCopyVerseText event, Emitter<ShareState> emit)async{
    final sharedText = _shareManager.getVerseSharedText(event.verse);
    emit(state.copyWith(
        shareUiEvent: ShareUiEventCopyText(copiedText: sharedText),
        setShareUiEvent: true,
        message: "Kopyalandı",
        setMessage: true
    ));
  }

  void _onShareHadithText(ShareEventShareHadithText event, Emitter<ShareState> emit)async{
    final sharedText = _shareManager.getHadithSharedText(event.hadith);
    emit(state.copyWith(shareUiEvent: ShareUiEventSharedText(sharedText: sharedText),
        setShareUiEvent: true));
  }

  void _onShareVerseText(ShareEventShareVerseText event, Emitter<ShareState> emit)async{
    final sharedText = _shareManager.getVerseSharedText(event.verse);
    emit(state.copyWith(shareUiEvent: ShareUiEventSharedText(sharedText: sharedText),
        setShareUiEvent: true));
  }


  void _onSharePdf(ShareEventSharePdf event, Emitter<ShareState> emit)async{

    final Uint8List byteData;
    final String fileShortName;

    emit(state.copyWith(loading: true));

    switch(event.sourceType){
      case SourceTypeEnum.hadith:
        fileShortName = "hadith.${event.listName}.pdf";
        final hadiths = await _shareManager.getHadithsWithList(event.listId);
        byteData = await _sharePdfRepo.getHadithPdfContent(hadiths, "Hadisler");
        break;
      case SourceTypeEnum.verse:
        fileShortName = "verse.${event.listName}.pdf";
        final verses = await _shareManager.getVersesWithList(event.listId);
        byteData = await _sharePdfRepo.getVersePdfContent(verses, "Ayetler");
        break;
    }

    final directoryPath=await _getDirectoryPath(isRemoveFiles: true);

    final filePath="$directoryPath/$fileShortName";
    final file = File(filePath);
    await file.create(recursive: true);
    await file.writeAsBytes(byteData);

    emit(state.copyWith(
        setShareUiEvent: true,
        shareUiEvent: ShareUiEventShareFile(filePath: filePath, mimeType: "application/pdf"),
        loading: false
    ));
  }


  void _onSharePdfText(ShareEventSharePdfText event, Emitter<ShareState> emit)async{

    final String content;
    emit(state.copyWith(loading: true));

    switch(event.sourceType){
      case SourceTypeEnum.hadith:
        content = await _shareManager.getHadithSharedTextWithList(event.listId);
        break;
      case SourceTypeEnum.verse:
        content = await _shareManager.getVerseSharedTextWithList(event.listId);
        break;
    }

    if(content.trim().isEmpty){
      emit(state.copyWith(
          setMessage: true,
          message: "Listede herhangi bir ${event.sourceType.shortName} bulunmamaktadır",
          loading: false
      ));
    }else{
      emit(state.copyWith(
          shareUiEvent: ShareUiEventSharedText(sharedText: content),
          setShareUiEvent: true,
          loading: false
      ));
    }

  }


  void _onShareImage(ShareEventShareImage event, Emitter<ShareState> emit)async{
    final dataBytes = event.data?.buffer.asUint8List();

    if(dataBytes == null) return;

    final directoryPath = await _getDirectoryPath();

    final imagePath="$directoryPath/${event.imageName}";
    final file = File(imagePath);
    await file.create(recursive: true);
    await file.writeAsBytes(dataBytes);

    emit(state.copyWith(
      setShareUiEvent: true,
      shareUiEvent: ShareUiEventShareFile(filePath: imagePath, mimeType: "image/png")
    ));
  }


  void _onClearMessage(ShareEventClearMessage event, Emitter<ShareState> emit){
    emit(state.copyWith(setMessage: true));
  }

  void _onClearShareUiEvent(ShareEventClearShareUiEvent event, Emitter<ShareState> emit){
    emit(state.copyWith(setShareUiEvent: true));
  }




  Future<String> _getDirectoryPath({bool isRemoveFiles = true})async{
    final directoryPath = "${(await getExternalStorageDirectory())?.path}/Share";

    final directory = Directory(directoryPath);

    if(!directory.existsSync()){
      await directory.create(recursive: true);
    }else{
      if(isRemoveFiles){
        await directory.delete(recursive: true);
      }
    }
    return Future.value(directoryPath);
  }

}