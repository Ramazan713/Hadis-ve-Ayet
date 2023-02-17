

abstract class IBottomNavEvent{}

class BottomNavChangeVisibilityWithDelay extends IBottomNavEvent{
  final bool isCollapsed;
  final bool withAnimation;
  BottomNavChangeVisibilityWithDelay({required this.isCollapsed,this.withAnimation=true});
}


class BottomNavChangeVisibility extends IBottomNavEvent{
  final bool isCollapsed;
  final bool withAnimation;
  BottomNavChangeVisibility({required this.isCollapsed,this.withAnimation=true});
}