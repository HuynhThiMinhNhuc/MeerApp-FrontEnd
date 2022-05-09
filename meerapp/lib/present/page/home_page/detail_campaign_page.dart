import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/models/post.dart';
import 'package:meerapp/present/component/loading_page.dart';
import 'package:meerapp/present/models/status_compaign.dart';
import 'package:meerapp/present/page/home_page/add_joiner_page.dart';
import 'package:meerapp/present/page/home_page/invite_member_page.dart';
import 'package:meerapp/present/page/home_page/widget/introduce_campaignwidget.dart';
import 'package:meerapp/present/page/home_page/widget/join_campaign_user_widget.dart';
import 'package:meerapp/present/page/home_page/widget/report_campaign_widget.dart';
import 'package:meerapp/present/page/profile/Wrapper/MyImage.dart';

import '../../../config/helper.dart';
import '../../../controllers/controller.dart';

class DetailCampaignPage extends StatefulWidget {
  final StatusCompaign mode;
  final int postId;
  final PostController _postController = sl.get<PostController>();

  DetailCampaignPage({
    Key? key,
    required this.mode,
    required this.postId,
  }) : super(key: key);

  @override
  State<DetailCampaignPage> createState() {
    return _DetailCampaignPageState();
  }
}

class _DetailCampaignPageState extends State<DetailCampaignPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = true;
  int currentTab = 0;
  DetailCampaignPost? post;
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
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _loadInit();
  }

  void _loadInit() {
    setState(() {
      isLoading = true;
    });
    widget._postController
        .getCampaignPostById(widget.postId)
        .then((value) async {
      post = value;
    }).onError((error, stackTrace) async {
      log(error?.toString() ?? "Can not load campaign by id");
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Lỗi'),
                content: const Text(
                    'Không thể tải trang sự kiện này, vui lòng thử lại sau'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ok'),
                  ),
                ],
              ));
      Navigator.of(context).popUntil((route) => route.isFirst);
    }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: meerColorWhite,
      body: (isLoading || post == null)
          ? const LoadingPage()
          : NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, value) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Stack(clipBehavior: Clip.none, children: [
                          Container(
                            height: 200.h,
                            decoration:  BoxDecoration(
                              image: DecorationImage(
                                  image: MyImageProvider( post!.bannerUrl, const AssetImage("asset/failedimage.png")),  fit: BoxFit.cover),
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
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                      image: DecorationImage(
                                          alignment: Alignment(0, -0.8.h),
                                          image: MyImageProvider(post!.imageUrl, const AssetImage("asset/avatardefault.png")),  fit: BoxFit.cover),
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
                                          post!.title,
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
                              visible: widget.mode == StatusCompaign.admin
                                  ? true
                                  : false,
                              child: ElevatedButton(
                                onPressed: () {
                                   Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const InviteMembetPage(),
                              ));
                                },
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
                                onPressed: () {
                                  widget.mode == StatusCompaign.admin
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddJoinerPage(post: post!,),
                                          ))
                                      : null;
                                },
                                child: Text(
                                  widget.mode == StatusCompaign.admin
                                      ? "Kết thúc"
                                      : widget.mode == StatusCompaign.member
                                          ? "Hủy đăng ký"
                                          : "Đăng ký",
                                  style: kText13BoldWhite,
                                ),
                                style: ElevatedButton.styleFrom(
                                  alignment: Alignment.center,
                                  fixedSize: Size(120.w, 30.h),
                                  primary:
                                      widget.mode == StatusCompaign.nonMember
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
                  ? IntroduceCampaintWidget(
                      nameCreator: post!.creator.name,
                      datecreate: DateTimeToString2(post!.timeCreate),
                      content: post!.title,
                      numberjoiner: post!.joined.length,
                      address: post!.address,
                      time: DateTimeToString(post!.timeStart),
                      email: post!.email,
                      phone: post!.phone,
                    )
                  : currentTab == 1
                      ? JoinCamPaignUser(users: post!.joined)
                      : ReportCampignWidget(
                          usersJoin: post!.doned, usersNotJoin: post!.notdone),
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
