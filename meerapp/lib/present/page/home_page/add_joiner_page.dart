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
import '../../component/add_participant_dialog.dart';

// ignore: must_be_immutable


class AddJoinerPage extends StatefulWidget {
  const AddJoinerPage({Key? key}) : super(key: key);

  @override
  State<AddJoinerPage> createState() => _AddJoinerPageState();
}

class _AddJoinerPageState extends State<AddJoinerPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<UserOverview> joined = [];
  final List<UserOverview> notjoined = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<String?> showDialogAddCampaignUser() {
  return showDialog<String>(
    context: context,
    builder: (context) =>
        AddParticipantAlert(listChooseUser: _tabController.index == 0 ? joined : notjoined),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(),
        body: SingleChildScrollView(
          child: _tabController.index == 0
              ? getListUser(joined)
              : getListUser(notjoined),
        ),
        bottomNavigationBar: getBottomNavigationBar(context));
  }

  Column getListUser(List<UserOverview> users) {
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
            avatarUrl: users[index].avatarUri,
            fulllName: users[index].name,
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
              showDialogAddCampaignUser();
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
              _tabController.index = index;
            });
          },
        ),
      ),
    );
  }
}

class JoinerItem extends StatelessWidget {
  final String? avatarUrl;
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
                        ? NetworkImage(avatarUrl!) as ImageProvider
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
