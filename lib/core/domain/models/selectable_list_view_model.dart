
import 'package:hadith/core/domain/models/list/list_view_model.dart';

class SelectableListViewModel{
  final ListViewModel listViewModel;
  final bool isSelected;

  SelectableListViewModel({required this.listViewModel, required this.isSelected});
}