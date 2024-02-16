import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuti/common/service/tab_provider.dart';

final navigationSelectedIndexProvider = StateProvider<int>((ref) {
  final List<String> tabs = [
    'personalBranding',
    'tuti',
    'profile',
  ];

  final tab = ref.watch(tabsProvider);

  int selectedIndex = tabs.indexOf(tab);
  return selectedIndex;
});
