import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/page/home_page/widget/introduce_campaignwidget.dart';
import 'package:meerapp/present/page/home_page/widget/join_campaign_user_widget.dart';
import 'package:meerapp/present/page/home_page/widget/report_campaign_widget.dart';
import 'package:meerapp/present/page/profile/Widgets/detail_join.dart';

import '../../../constant/post.dart';

class JoinedView extends StatefulWidget {
  int currentTab = 0;
  JoinedView(this.currentTab, {Key? key}) : super(key: key);

  @override
  State<JoinedView> createState() => _JoinedViewState();
}

class _JoinedViewState extends State<JoinedView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: meerColorGreyText),
          backgroundColor: meerColorBackground,
          centerTitle: true,
          shadowColor: meerColor25GreyNoteText,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: meerColorBlackIcon,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Lịch sử hoạt động",
            style: kText17BoldBlack,
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
                    child: Text("Đã tạo")),
                Container(
                    width: 90.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    child: const Text("Đã tham gia")),
                Container(
                    width: 90.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    child: const Text("Bỏ tham gia")),
              ],
              onTap: (index) {
                setState(() {
                  widget.currentTab = index;
                });
              },
            ),
          ),
        ),
        body: widget.currentTab == 0
            ? DetailJoinWidget(
                campaignList: posts,
                emergencyList: posts,
                status: 0,
              )
            : widget.currentTab == 1
                ? DetailJoinWidget(
                    campaignList: posts,
                    emergencyList: posts,
                    status: 1,
                  )
                : DetailJoinWidget(
                    campaignList: posts,
                    emergencyList: posts,
                    status: 2,
                  ));
  }
}