
enum AdaptiveDropdownMenuType{
  bottomSheet, dropdownMenu;

  bool get isBottomSheet => this == AdaptiveDropdownMenuType.bottomSheet;
  bool get isDropdownMenu => this == AdaptiveDropdownMenuType.dropdownMenu;

}