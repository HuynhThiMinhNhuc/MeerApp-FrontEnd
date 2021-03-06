import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/controllers/controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/models/post.dart';
import 'package:meerapp/present/component/loading_page.dart';
import 'package:meerapp/present/component/map.dart';
import 'package:meerapp/present/models/status_emerency.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:meerapp/present/page/home_page/add_joiner_page.dart';
import 'package:meerapp/present/page/home_page/widget/join_campaign_user_widget.dart';
import 'package:meerapp/present/page/profile/Wrapper/MyImage.dart';

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
  late List imagePost;
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
                title: const Text('L???i'),
                content: const Text(
                    'Kh??ng th??? t???i trang s??? ki???n n??y, vui l??ng th??? l???i sau'),
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
        imagePost = [post!.imageUrl, post!.bannerUrl];
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
                    Stack(children: [
                      Center(
                        child: SizedBox(
                          height: 300.h,
                          child: Swiper(
                            control: const  SwiperControl(
                                 iconPrevious: Icons.circle,
                                 iconNext: Icons.circle,
                                 color: Colors.transparent,
                               ),
                            itemBuilder: (context, index) {
                              return MyImage(
                                  imagePost[index],
                                  Image.asset(
                                    "asset/failedimage.png",
                                    fit: BoxFit.cover,
                                  ));
                            },
                            indicatorLayout: PageIndicatorLayout.COLOR,
                            autoplay: false,
                            itemCount: 2,
                            pagination: const SwiperPagination(
                              builder: SwiperPagination.dots,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40.h,
                        left: 20.w,
                          child: IconButton(
                        icon: Icon(FontAwesomeIcons.arrowLeft),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ))
                    ]),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Text(
                        "Kh???n c???p - " + post!.title,
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
                              "M???i",
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
                              "K???t th??c",
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
                            "Th??ng tin ng?????i g???p n???n",
                            style: ktext18BoldBlack,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Text.rich(
                              TextSpan(
                                  text: 'H??? v?? t??n: ',
                                  style: kText15BoldBlack,
                                  children: [
                                    TextSpan(
                                        text: post!.creator.name,
                                        style: kText15RegularBlack)
                                  ]),
                            ),
                          ),
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Text.rich(
                                TextSpan(
                                    text: '?????a ??i???m g???p n???n: ',
                                    style: kText15BoldBlack,
                                    children: [
                                      TextSpan(
                                          text: post!.address,
                                          style: ktext15RegularBlue.copyWith(
                                              decoration:
                                                  TextDecoration.underline))
                                    ]),
                              ),
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
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Text.rich(
                              TextSpan(
                                  text: 'S??? ??i???n tho???i: ',
                                  style: kText15BoldBlack,
                                  children: [
                                    TextSpan(
                                        text: post!.phone ?? "Kh??ng c??",
                                        style: kText15RegularBlack)
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text.rich(
                              TextSpan(
                                  text: 'Email: ',
                                  style: kText15BoldBlack,
                                  children: [
                                    TextSpan(
                                        text: post!.email,
                                        style: kText15RegularBlack)
                                  ]),
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
                            "T??nh h??nh hi???n t???i",
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
                          'Danh s??ch tham gia',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text('T??nh nguy???n vi??n ???? gi??p ?????'),
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
          number.toString() + " th??nh vi??n",
          style: kText13BoldBlack,
        ),
        SizedBox(
          width: 15.w,
        ),
      ],
    );
  }
}
