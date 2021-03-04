import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CheckboxListModel extends ChangeNotifier {
  final List<CheckboxItem> _list;

  CheckboxListModel(UnmodifiableListView<CheckboxItem> list)
      : this._list = List.from(list);

  UnmodifiableListView<CheckboxItem> get list => UnmodifiableListView(_list);

  void change(int id, bool isChecked) {
    _list.singleWhere((item) => item.id == id).isChecked = isChecked;
    notifyListeners();
  }

  bool get isAllChecked => _list.any((item) => item.isChecked == false);

  void changeAll() {
    final bool isAll = isAllChecked;
    _list.map((item) => item.isChecked = isAll).toList();
    notifyListeners();
  }

  bool _isSortedUp;

  bool get isSortedUp => _isSortedUp;

  void _sortUp() {
    _list
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    _isSortedUp = true;
  }

  void _sortDown() {
    _list
        .sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
    _isSortedUp = false;
  }

  void sort() {
    if (_isSortedUp == null)
      _sortUp();
    else
      _isSortedUp ? _sortDown() : _sortUp();
    notifyListeners();
  }
}

class CheckboxItem {
  final int id;
  final String title;
  bool isChecked;

  CheckboxItem({
    @required this.id,
    @required this.title,
    this.isChecked = false,
  })  : assert(id != null),
        assert(title != null),
        assert(isChecked != null);
}

class CheckboxItemRepository {
  final List<String> _list = ['Second', 'First', 'Third'];

  UnmodifiableListView<CheckboxItem> get list {
    final List<CheckboxItem> list = [];
    _list
        .asMap()
        .forEach((id, title) => list.add(CheckboxItem(id: id, title: title)));
    return UnmodifiableListView(list);
  }
}
