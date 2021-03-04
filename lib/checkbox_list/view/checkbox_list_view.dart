import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../checkbox_list.dart';

class CheckboxListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print('CheckboxListView');

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox List'),
        actions: [
          _SortButton(),
          _CheckboxButton(),
        ],
      ),
      body: _ListView(),
    );
  }
}

class _ListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UnmodifiableListView<CheckboxItem> list =
        context.watch<CheckboxListModel>().list;

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => _CheckboxTile(list[index]),
    );
  }
}

class _SortButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(context.select<CheckboxListModel, bool>(
              (value) => value.isSortedUp == null)
          ? Icons.sort
          : context.select<CheckboxListModel, bool>((value) => value.isSortedUp)
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_down),
      onPressed: () {
        context.read<CheckboxListModel>().sort();
      },
    );
  }
}

class _CheckboxButton extends StatelessWidget {
  const _CheckboxButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
          context.select<CheckboxListModel, bool>((model) => model.isAllChecked)
              ? Icons.check_box_outlined
              : Icons.check_box_outline_blank_outlined),
      onPressed: () {
        context.read<CheckboxListModel>().changeAll();
      },
    );
  }
}

class _CheckboxTile extends StatelessWidget {
  final CheckboxItem item;

  const _CheckboxTile(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isChecked = context.select<CheckboxListModel, bool>((model) =>
        model.list.singleWhere((element) => element.id == item.id).isChecked);
    return CheckboxListTile(
      value: isChecked,
      onChanged: (value) {
        context.read<CheckboxListModel>().change(item.id, value);
      },
      title: Text(item.title),
    );
  }
}
