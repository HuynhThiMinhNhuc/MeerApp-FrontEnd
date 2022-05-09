import 'dart:developer';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/controllers/controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/present/component/my_alert_dialog_3.dart';

import '../../../config/constant.dart';
import '../../../models/post.dart';
import '../../../models/user.dart';
import '../../component/add_participant_dialog.dart';

// ignore: must_be_immutable

class AddJoinerPage extends StatefulWidget {
  final PostController _postController = sl.get<PostController>();
  final IPost post;
  AddJoinerPage({Key? key, required this.post}) : super(key: key);

  @override
  State<AddJoinerPage> createState() => _AddJoinerPageState();
}

class _AddJoinerPageState extends State<AddJoinerPage>
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
          child: getListUser(isJoinedTab ? joined : notjoined),
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
                if (isJoinedTab) {
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
                } else {
                  if (joined.any((user) => user.id == object.id)) {
                    showDialog(
                      context: context,
                      builder: (_) => MyAlertDialog3(
                        title: 'Thông báo',
                        content:
                            'Người này đã có trong danh sách tham gia, không thể thêm vào danh sách này',
                      ),
                    );
                  } else {
                    notjoined.add(object);
                  }
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
              "Thêm tình nguyện viên",
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
        ElevatedButton(
            onPressed: () async {
              var isSuccess = await widget._postController.FinishPost(
                (widget.post is CampaignPost) ? 'campaign' : 'emergency',
                widget.post.id,
                joined.map((e) => e.id).toList(),
                notjoined.map((e) => e.id).toList(),
              );

              if (isSuccess) {
                await showDialog(
                  context: context,
                  builder: (context) => MyAlertDialog3(
                    title: 'Thông báo',
                    content:
                        'Sự kiện đã chuyển sang chế độ kết thúc thành công',
                  ),
                );
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => MyAlertDialog3(
                    title: 'Lỗi',
                    content:
                        'Không thể thực hiện thao tác này, vui lòng thử lại sau',
                  ),
                );
              }
            },
            child: Text("Đồng ý"))
      ],
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
            setState(() {});
          },
        ),
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
                    image: user.avatarUri == null
                        ? NetworkImage(user.avatarUri!) as ImageProvider
                        : const AssetImage("asset/demo.jpg"),
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
