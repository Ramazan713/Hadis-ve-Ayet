

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hadith/features/extra_features/extra_features_page.dart';
import 'package:hadith/features/home/home_screen.dart';
import 'package:hadith/features/list/list_screen.dart';
import 'package:hadith/features/search/search_page.dart';

const kBottomPageModels = [
  _BottomSearch(),
  _BottomHome(),
  _BottomFeatures(),
  _BottomList()
];

const kStartPageModel = _BottomHome();


class BottomBarModel extends Equatable{
  final String keyName;
  final Widget page;
  final Icon icon;
  final String label;

  const BottomBarModel._({required this.keyName,required this.page,
    required this.icon,required this.label});

  const factory BottomBarModel.home() = _BottomHome;
  const factory BottomBarModel.search() = _BottomSearch;
  const factory BottomBarModel.list() = _BottomList;
  const factory BottomBarModel.features() = _BottomFeatures;

  @override
  List<Object?> get props => [keyName];
}

class _BottomHome extends BottomBarModel{
  const _BottomHome(): super._(
      keyName: "Home",
      label: "Ana Sayfa",
      icon: const Icon(Icons.home),
      page: const HomePage()
  );
}

class _BottomSearch extends BottomBarModel{
  const _BottomSearch(): super._(
      keyName: "Search",
      label: "Arama",
      icon: const Icon(Icons.search),
      page: const SearchPage()
  );
}

class _BottomList extends BottomBarModel{
  const _BottomList(): super._(
      keyName: "List",
      label: "Liste",
      icon: const Icon(Icons.view_list),
      page: const ListScreen()
  );
}

class _BottomFeatures extends BottomBarModel{
  const _BottomFeatures(): super._(
      keyName: "Features",
      label: "Kategoriler",
      icon: const Icon(Icons.dataset),
      page: const ExtraFeaturesPage()
  );
}
