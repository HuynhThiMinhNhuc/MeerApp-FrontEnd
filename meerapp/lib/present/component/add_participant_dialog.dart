import 'dart:developer';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/config/fontconfig.dart';

import '../../config/constant.dart';
import '../../models/user.dart';

class AddParticipantAlert extends StatelessWidget {
  AddParticipantAlert({
    Key? key,
    required this.listChooseUser,
  }) : super(key: key);

  final List<UserOverview> listChooseUser;
  final List<UserOverview> _listUserBytext = [];
  int count = 0;
  late Debouncer<String> debouncer =
      Debouncer<String>(const Duration(microseconds: 3000), initialValue: '',
          onChanged: (textSearch) async {
    var queryParams = {
      'searchby': 'fullname',
      'searchvalue': textSearch,
      'orderby': 'fullname',
      'orderdirection': 'asc',
      'start': 0,
      'count': 5,
    };
    var response = await myAPIWrapper.get(
      ServerUrl + '/user/select',
      queryParameters: queryParams,
    );

    _listUserBytext.clear();
    _listUserBytext.addAll((response.data as List<dynamic>)
        .map((json) => UserOverview.fromJson(json)));
    log('load complete: ' + (++count).toString());
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Thêm người tham gia',
        style: kText15BoldBlack,
      ),
      content: Autocomplete<UserOverview>(
        displayStringForOption: (option) => option.name,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text.trim() == '') {
            return [];
          }
          debouncer.setValue(textEditingValue.text);
          return _listUserBytext;
        },
        onSelected: (UserOverview selection) {
          debugPrint('You just selected ${selection.name}');
          listChooseUser.add(selection);
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}