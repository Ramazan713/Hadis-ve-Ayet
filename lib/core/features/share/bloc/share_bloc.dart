

import 'dart:io';
import 'dart:typed_data';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/loading_enum.dart';
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

  ShareBloc({
    required ShareManager shareManager,
    required SharePdfRepo sharePdfRepo
  }): super(ShareState.init()){

    _sharePdfRepo = sharePdfRepo;
    _shareManager = shareManager;

    on<ShareEventShareImage>(_onShareImage, transformer: restartable());
    on<ShareEventCopyText>(_onCopyText, transformer: restartable());
    on<ShareEventShareText>(_onShareText, transformer: restartable());
    on<ShareEventLaunchUrl>(_onLaunchUrl, transformer: restartable());

    on<ShareEventSharePdfText>(_onSharePdfText, transformer: restartable());
    on<ShareEventSharePdf>(_onSharePdf, transformer: restartable());

    on<ShareEventClearCompletedLoading>(_onClearCompletedLoading, transformer: restartable());
    on<ShareEventClearShareUiEvent>(_onClearShareUiEvent, transformer: restartable());
    on<ShareEventClearMessage>(_onClearMessage, transformer: restartable());
  }

  void _onShareText(ShareEventShareText event, Emitter<ShareState> emit){
    emit(state.copyWith(
      shareUiEvent: ShareUiEventSharedText(sharedText: event.text),
    ));
  }

  void _onCopyText(ShareEventCopyText event, Emitter<ShareState> emit){
    emit(state.copyWith(
      shareUiEvent: ShareUiEventCopyText(copiedText: event.text),
      message: "Kopyalandı",
    ));
  }

  void _onLaunchUrl(ShareEventLaunchUrl event, Emitter<ShareState> emit){
    emit(state.copyWith(
      shareUiEvent: ShareUiEventLaunchUrl(
        url: event.url,
        launchMode: event.launchMode
      )
    ));
  }


  void _onSharePdf(ShareEventSharePdf event, Emitter<ShareState> emit)async{

    final Uint8List byteData;
    final String fileShortName;

    emit(state.copyWith(loadingEnum: LoadingEnum.loading));

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
      shareUiEvent: ShareUiEventShareFile(filePath: filePath, mimeType: "application/pdf"),
        loadingEnum: LoadingEnum.completed
    ));
  }


  void _onSharePdfText(ShareEventSharePdfText event, Emitter<ShareState> emit)async{

    final String content;
    emit(state.copyWith(loadingEnum: LoadingEnum.loading));

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
        message: "Listede herhangi bir ${event.sourceType.shortName} bulunmamaktadır",
        loadingEnum: LoadingEnum.completed
      ));
    }else{
      emit(state.copyWith(
        shareUiEvent: ShareUiEventSharedText(sharedText: content),
        loadingEnum: LoadingEnum.completed
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
      shareUiEvent: ShareUiEventShareFile(filePath: imagePath, mimeType: "image/png")
    ));
  }


  void _onClearMessage(ShareEventClearMessage event, Emitter<ShareState> emit){
    emit(state.copyWith(message: null));
  }

  void _onClearShareUiEvent(ShareEventClearShareUiEvent event, Emitter<ShareState> emit){
    emit(state.copyWith(shareUiEvent: null));
  }

  void _onClearCompletedLoading(ShareEventClearCompletedLoading event, Emitter<ShareState> emit){
    emit(state.copyWith(loadingEnum: LoadingEnum.idle));
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