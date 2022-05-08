import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/models/user.dart';
import 'package:meerapp/present/page/home_page/widget/join_campaign_user_widget.dart';

class AddJoinerPage extends StatefulWidget {
  const AddJoinerPage({ Key? key }) : super(key: key);

  @override
  State<AddJoinerPage> createState() => _AddJoinerPageState();
}

class _AddJoinerPageState extends State<AddJoinerPage>  with TickerProviderStateMixin {
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
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                 return JoinCamPaignUser(users: [UserOverview(id: 1, name: "Minh Nhuc", address: 'Nui Thanh Quang Nam', avatarUri: '')]);
                }, 
            )
        ]),
      ),
      bottomNavigationBar: getBottomNavigationBar(context)
    );
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
                  Navigator.pop(context);
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
              ),));
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: meerColorBackground,
      centerTitle: true,
      elevation: 0,
      iconTheme: const  IconThemeData(color: meerColorBlackIcon),
      title: Text("Báo cáo", style: ktext18BoldBlack,),
      bottom:  PreferredSize(
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