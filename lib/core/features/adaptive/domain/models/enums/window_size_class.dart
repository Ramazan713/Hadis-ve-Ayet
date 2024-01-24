
enum WindowSizeClass{
  Compact, Medium, Expanded;

  bool get isCompact  => this == WindowSizeClass.Compact;
  bool get isMedium => this == WindowSizeClass.Medium;
  bool get isExpanded => this == WindowSizeClass.Expanded;
}