

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/component/my_alert_dialog_3.dart';
import 'package:meerapp/present/page/profile/Wrapper/MyImage.dart';

import '../../../models/user.dart';
import '../../component/add_participant_dialog.dart';

// ignore: must_be_immutable

class InviteMembetPage extends StatefulWidget {
  const InviteMembetPage({Key? key}) : super(key: key);

  @override
  State<InviteMembetPage> createState() => _InviteMembetPageState();
}

class _InviteMembetPageState extends State<InviteMembetPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late final List<UserOverview> joined;
  late final List<UserOverview> notjoined;

  bool get isJoinedTab => _tabController.index == 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    joined = [];
    notjoined = [];
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
          child: getListUser(joined ),
        ),
        bottomNavigationBar: getBottomNavigationBar(context));
  }

  Widget getListUser(List<UserOverview> users) {
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
            user: users[index],
            onRemove: () {
              users.removeAt(index);
            },
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
            onPressed: () async {
              UserOverview? object = await _showChooseDialog(context);
              if (object != null) {
                  if (notjoined.any((user) => user.id == object.id)) {
                    showDialog(
                      context: context,
                      builder: (_) => MyAlertDialog3(
                        title: 'Thông báo',
                        content:
                            'Người này đã có trong danh sách vắng, không thể thêm vào danh sách này',
                      ),
                    );
                  } else {
                    joined.add(object);
                  }
                setState(() {});
              } else {}
            },
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              primary: meerColorMain,
              minimumSize: const Size.fromHeight(40),
            ),
            child: Text(
              "Mời tình nguyện viên",
              style: kText13BoldWhite,
            ),
          ),
        ));
  }

  Future<dynamic> _showChooseDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) =>
          AddParticipantAlert(listChooseUser: isJoinedTab ? joined : notjoined),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      actions: [
       TextButton(
            onPressed: (){ 
              //TODO: Save joine member
              Navigator.pop(context);
              },
            child: Text("Lưu", style: kText15BoldMain,))
      ],
      backgroundColor: meerColorBackground,
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: meerColorBlackIcon),
      title: Text(
        "Mời thành viên",
        style: ktext18BoldBlack,
      ),
    );
  }
}

class JoinerItem extends StatelessWidget {
  final UserOverview user;
  final Function()? onRemove;
  const JoinerItem({Key? key, required this.user, this.onRemove})
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
                    image: user.avatarUri != null
                        ? MyImageProvider(user.avatarUri,const  AssetImage("asset/avatardefault.png"))
                        : const AssetImage("asset/avatardefault.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        title: Text(
          user.name,
          style: kText15RegularBlack,
        ),
        selectedColor: const Color.fromARGB(16, 2, 1, 1),
        trailing: IconButton(
          onPressed: () => onRemove?.call(),
          icon: const Icon(
            FontAwesomeIcons.circleMinus,
            color: meerColorRed,
          ),
        ),
        onTap: () {
          // TODO: open home page of this user
          // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          // }));
        },
      ),
    );
  }
}
