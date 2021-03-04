import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../checkbox_list.dart';
import 'checkbox_list_view.dart';

class CheckboxListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CheckboxListModel(CheckboxItemRepository().list),
      child: CheckboxListView(),
    );
  }
}
