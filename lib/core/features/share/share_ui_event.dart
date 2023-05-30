

sealed class ShareUiEvent{}

class ShareUiEventCopyText extends ShareUiEvent{
  final String copiedText;
  ShareUiEventCopyText({required this.copiedText});
}

class ShareUiEventSharedText extends ShareUiEvent{
  final String sharedText;
  ShareUiEventSharedText({required this.sharedText});
}

class ShareUiEventShareFile extends ShareUiEvent{
  final String filePath;
  final String mimeType;
  ShareUiEventShareFile({required this.filePath, required this.mimeType});
}