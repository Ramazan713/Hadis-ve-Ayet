
import 'package:flutter/material.dart';

class PagingLoadingItem{
  final Widget loadingWidget;
  final int childCount;
  PagingLoadingItem({required this.loadingWidget,this.childCount = 1});
}