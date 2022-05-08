import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/models/post.dart';
import 'package:meerapp/present/page/home_page/widget/introduce_campaignwidget.dart';
import 'package:meerapp/present/page/home_page/widget/join_campaign_user_widget.dart';
import 'package:meerapp/present/page/home_page/widget/report_campaign_widget.dart';

enum Status {
  admin,
  member,
  nonMember,
}

class DetailCampaignPage extends StatefulWidget {
  final Status mode;
  final CampaignPost? post;
  const DetailCampaignPage({
    Key? key,
    required this.mode,
    required this.post,
  }) : super(key: key);

  @override
  State<DetailCampaignPage> createState() => _DetailCampaignPageState();
}

class _DetailCampaignPageState extends State<DetailCampaignPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int currentTab = 0;
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
    double cWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: meerColorWhite,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(clipBehavior: Clip.none, children: [
                    Container(
                      height: 200.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("asset/demo.jpg"),
                            // NetworkImage(
                            //  "https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y2hhcml0eXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      left: 10.w,
                      top: 30.h,
                    ),
                    Positioned(
                      bottom: -65.h,
                      left: 5.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 90.h,
                            height: 90.h,
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  colors: meerColorGradientActive),
                            ),
                            child: Container(
                              width: 86.h,
                              height: 86.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                image: DecorationImage(
                                    alignment: Alignment(0, -0.8.h),
                                    image: AssetImage("asset/demo.jpg"),
                                    //const NetworkImage(
                                    //  "https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y2hhcml0eXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SizedBox(
                            width: cWidth - 110.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 35.h,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.post?.title ?? "test nef",
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: kText20MediumBlack,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                  SizedBox(height: 65.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: widget.mode == Status.admin ? true : false,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            fixedSize: Size(100.w, 30.h),
                            primary: meerColorMain,
                          ),
                          child: Text(
                            "Mời ",
                            style: kText13BoldWhite,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            widget.mode == Status.admin
                                ? "Kết thúc"
                                : widget.mode == Status.member
                                    ? "Hủy đăng ký"
                                    : "Đăng ký",
                            style: kText13BoldWhite,
                          ),
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            fixedSize: Size(120.w, 30.h),
                            primary: widget.mode == Status.nonMember
                                ? meerColorMain
                                : meerColorRed,
                          )),
                      SizedBox(
                        width: 20.w,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 0, bottom: 0),
                    child: const Divider(
                      color: Color(0xFFDDDDDD),
                    ),
                  ),
                ],
              ),
            ),
            SliverAppBar(
              pinned: true,
              stretch: true,
              floating: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: TabBar(
                indicatorColor: meerColorMain,
                unselectedLabelColor: const Color(0xFF757070),
                controller: _tabController,
                labelColor: meerColorMain,
                labelStyle: kText15BoldMain,
                tabs: const [
                  Tab(text: "Giới thiệu"),
                  Tab(text: "Thành viên"),
                  Tab(text: "Báo cáo"),
                ],
                onTap: (index) {
                  setState(() {
                    currentTab = index;
                  });
                },
              ),
            ),
          ];
        },
        body: currentTab == 0
            ? const IntroduceCampaintWidget(
                nameCreator: "Huỳnh Thị Minh Nhực",
                datecreate: "17/05/2022",
                content: "Test",
                numberjoiner: 17,
                address: "Khu phố 6 thành p ",
                time: "25/11/2022")
            : currentTab == 1
                ? JoinCamPaignUser()
                : ReportCampignWidget(),
      ),
    );
  }

  Widget iconOverview(IconData icon, int number) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 30.h,
          height: 30.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: meerColorMain,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          number.toString() + " thành viên",
          style: kText13BoldBlack,
        ),
        SizedBox(
          width: 15.w,
        ),
      ],
    );
  }
}
