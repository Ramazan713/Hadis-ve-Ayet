

import 'package:async/async.dart';
import 'package:hadith/features/verses/shared/domain/model/audio_edition.dart';
import 'package:hadith/models/resource.dart';

abstract class EditionRepo{


  Future<Resource<List<AudioEdition>>> getEditions();

  Stream<List<AudioEdition>> getStreamEditions();

  Future<Resource<AudioEdition?>> getSelectedEdition();

  Stream<AudioEdition?> getSelectedStreamEdition();
}