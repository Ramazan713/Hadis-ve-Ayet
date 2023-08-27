

import 'package:async/async.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/utils/resource.dart';

abstract class EditionRepo{


  Future<Resource<List<AudioEdition>>> getEditions();

  Stream<List<AudioEdition>> getStreamEditions();

  Future<Resource<AudioEdition?>> getSelectedEdition();

  Stream<AudioEdition?> getSelectedStreamEdition();

  Future<void> setSelectedEdition(String identifier);
}