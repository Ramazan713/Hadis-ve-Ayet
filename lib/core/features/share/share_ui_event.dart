

import 'package:url_launcher/url_launcher_string.dart';

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

class ShareUiEventLaunchUrl extends ShareUiEvent{
  final String url;
  final LaunchMode launchMode;

  ShareUiEventLaunchUrl({
    required this.url,
    this.launchMode = LaunchMode.externalApplication
  });
}