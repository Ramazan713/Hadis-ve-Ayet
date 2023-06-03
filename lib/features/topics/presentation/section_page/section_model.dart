

import 'package:hadith/features/topics/domain/model/section_view_model.dart';

class SectionModel{
  final SectionViewModel sectionViewModel;
  final bool isBookSection;
  SectionModel({required this.sectionViewModel, this.isBookSection = false});
}