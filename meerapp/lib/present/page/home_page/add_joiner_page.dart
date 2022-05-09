import 'dart:developer';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';

import '../../../config/constant.dart';
import '../../../models/user.dart';

Future<String?> showDialogAddCampaignUser(BuildContext context) {
  var listChooseUser = [
    UserOverview(
        id: 1,
        name: "Nguyen Ngoc Anh",
        avatarUri: "",
        address: "Tho Cam, Bac Cai An Giang"),
    UserOverview(
        id: 1,
        name: "Nam Anh",
        avatarUri: "",
        address: "Tho Cam, Bac Cai An Giang"),
    UserOverview(
        id: 1,
        name: "Pham Hong Phuc",
        avatarUri: "",
        address: "Tho Cam, Bac Cai An Giang")
  ];
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) =>
        AddParticipantAlert(listChooseUser: listChooseUser),
  );
}

// ignore: must_be_immutable
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

class AddJoinerPage extends StatefulWidget {
  const AddJoinerPage({Key? key}) : super(key: key);

  @override
  State<AddJoinerPage> createState() => _AddJoinerPageState();
}

class _AddJoinerPageState extends State<AddJoinerPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late int currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tabController.index = currentTab;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(),
        body: SingleChildScrollView(
          child: currentTab == 0
              ? getListUser(["Minh Nhuc", "Thuy Tien", "Duy Bang"])
              : getListUser(["Ngoc thach"]),
        ),
        bottomNavigationBar: getBottomNavigationBar(context));
  }

  Column getListUser(List<String> users) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Text(
          users.length.toString() + " thành viên",
          style: ktext18BoldBlack,
        ),
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return JoinerItem(
            avatarUrl: '',
            fulllName: users[index],
          );
        },
      )
    ]);
  }

  Container getBottomNavigationBar(BuildContext context) {
    return Container(
        height: 60.h,
        color: meerColorBackground,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 5.h),
          child: ElevatedButton(
            onPressed: () {
              showDialogAddCampaignUser(context);
            },
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              primary: meerColorMain,
              minimumSize: const Size.fromHeight(40),
            ),
            child: Text(
              "Thêm tình nguyện viên",
              style: kText13BoldWhite,
            ),
          ),
        ));
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: meerColorBackground,
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: meerColorBlackIcon),
      title: Text(
        "Báo cáo",
        style: ktext18BoldBlack,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: TabBar(
          isScrollable: true,
          indicatorColor: meerColorMain,
          unselectedLabelColor: const Color(0xFF757070),
          controller: _tabController,
          labelColor: meerColorMain,
          labelStyle: kText15BoldMain,
          tabs: <Widget>[
            Container(
                width: 85.w,
                height: 50.h,
                alignment: Alignment.center,
                child: const Text("Thành viên")),
            Container(
                width: 90.w,
                height: 50.h,
                alignment: Alignment.center,
                child: const Text("Bỏ tham gia")),
          ],
          onTap: (index) {
            setState(() {
              currentTab = index;
            });
          },
        ),
      ),
    );
  }
}

class JoinerItem extends StatelessWidget {
  final String avatarUrl;
  final String fulllName;
  const JoinerItem({Key? key, required this.avatarUrl, required this.fulllName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: ListTile(
        leading: Container(
          width: 61.h,
          height: 61.h,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: meerColorGradientActive)),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              width: 60.h,
              height: 60.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                image: DecorationImage(
                    image: avatarUrl == null
                        ? NetworkImage(avatarUrl) as ImageProvider
                        : const AssetImage("asset/demo.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        title: Text(
          fulllName,
          style: kText15RegularBlack,
        ),
        selectedColor: const Color.fromARGB(16, 2, 1, 1),
        trailing: IconButton(
          onPressed: () => {
            //TODO: remove joiner
          },
          icon: const Icon(
            FontAwesomeIcons.circleMinus,
            color: meerColorRed,
          ),
        ),
        onTap: () {
          //TODO: open user profile page
        },
      ),
    );
  }
}
