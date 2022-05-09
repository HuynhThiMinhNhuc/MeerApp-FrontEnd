import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/controllers/controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/models/post.dart';
import 'package:meerapp/present/component/loading_page.dart';
import 'package:meerapp/present/component/map.dart';
import 'package:meerapp/present/component/my_alert_dialog_3.dart';
import 'package:meerapp/present/models/status_emerency.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:meerapp/present/page/home_page/add_joiner_page.dart';
import 'package:meerapp/present/page/home_page/widget/join_campaign_user_widget.dart';

import '../../component/my_alert_dialog.dart';

class DetailEmerencyPage extends StatefulWidget {
  final StatusEmerency mode;
  final int postId;
  final PostController _postController = sl.get<PostController>();
  DetailEmerencyPage({Key? key, required this.mode, required this.postId})
      : super(key: key);

  @override
  State<DetailEmerencyPage> createState() => _DetailEmerencyPageState();
}

class _DetailEmerencyPageState extends State<DetailEmerencyPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = true;
  DetailEmergencyPost? post;
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadInit();
  }

  void _loadInit() {
    setState(() {
      isLoading = true;
    });
    widget._postController.getEmergencyPostById(widget.postId).then((value) {
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
          : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 300.h,
                        child: Swiper(
                          itemBuilder: (context, index) {
                            return Image.asset(
                              "asset/demo.jpg",
                              fit: BoxFit.fill,
                            );
                          },
                          indicatorLayout: PageIndicatorLayout.COLOR,
                          autoplay: false,
                          itemCount: 2,
                          pagination: const SwiperPagination(
                            builder: SwiperPagination.rect,
                          ),
                          control: const SwiperControl(
                            color: meerColor80Black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Text(
                        "Khẩn cấp - " + post!.title,
                        style: kText20BoldRed,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              //alignment: Alignment.center,
                              primary: meerColorMain,
                              fixedSize: Size(100.w, 30.h),
                            ),
                            child: Text(
                              "Mời",
                              style: kText13BoldWhite,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddJoinerPage(post: post!)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              primary: meerColorRed,
                              fixedSize: Size(100.w, 30.h), // Background color
                            ),
                            child: Text(
                              "Kết thúc",
                              style: kText13BoldWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Thông tin người gặp nạn",
                            style: ktext18BoldBlack,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text.rich(
                            TextSpan(
                                text: 'Họ và tên: ',
                                style: kText15BoldBlack,
                                children: [
                                  TextSpan(
                                      text: post!.creator.name,
                                      style: kText15RegularBlack)
                                ]),
                          ),
                          InkWell(
                            child: Text.rich(
                              TextSpan(
                                  text: 'Địa điểm gặp nạn: ',
                                  style: kText15BoldBlack,
                                  children: [
                                    TextSpan(
                                        text: post!.address,
                                        style: ktext15RegularBlue.copyWith(
                                            decoration:
                                                TextDecoration.underline))
                                  ]),
                            ),
                            onTap: () => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MyMap(initLocation: post!.position),
                                ),
                              )
                            },
                          ),
                          Text.rich(
                            TextSpan(
                                text: 'Số điện thoại: ',
                                style: kText15BoldBlack,
                                children: [
                                  TextSpan(
                                      text: post!.phone ?? "Không có",
                                      style: kText15RegularBlack)
                                ]),
                          ),
                          Text.rich(
                            TextSpan(
                                text: 'Email: ',
                                style: kText15BoldBlack,
                                children: [
                                  TextSpan(
                                      text: post!.email,
                                      style: kText15RegularBlack)
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tình hình hiện tại",
                            style: ktext18BoldBlack,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(post!.content, style: kText15RegularBlack),
                        ],
                      ),
                    ),
                    ExpansionTile(
                        title: Text(
                          'Danh sách tham gia',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text('Tình nguyện viên đã giúp đỡ'),
                        children: post!.doned
                            .map((user) => JoinCampaignUserItem(user: user))
                            .toList()
                        // List.generate(
                        //     5,
                        //     (index) => const JoinCampaignUserItem(
                        //         fullName: "Minh Nhuc",
                        //         avatarUrl: "asset/avt1.jpg")),
                        ),
                  ]),
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
