import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/models/status_emerency.dart';

class DetailEmerencyPage extends StatefulWidget {
  final StatusEmerency mode;
  const DetailEmerencyPage({Key? key, required this.mode}) : super(key: key);

  @override
  State<DetailEmerencyPage> createState() => _DetailEmerencyPageState();
}

class _DetailEmerencyPageState extends State<DetailEmerencyPage>
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
                                    "Chiến dịch làm sạch bãi biển Vũng Tàu",
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
                        visible:
                            widget.mode == StatusEmerency.admin ? true : false,
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
          ];
        },
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Text(
              "Khẩn cấp",
              style: kText20BoldRed,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                        TextSpan(text: "Minh Nhực", style: kText15RegularBlack)
                      ]),
                ),
                InkWell(
                  child: Text.rich(
                    TextSpan(
                        text: 'Địa điểm gặp nạn: ',
                        style: kText15BoldBlack,
                        children: [
                          TextSpan(
                              text: "Đoạn đường Linh Trung Thủ đức",
                              style: ktext15RegularBlue.copyWith(
                                  decoration: TextDecoration.underline))
                        ]),
                  ),
                  onTap: () => {
                    //Todo: navigator to map
                  },
                ),
                Text.rich(
                  TextSpan(
                      text: 'Số điện thoại: ',
                      style: kText15BoldBlack,
                      children: [
                        TextSpan(text: "0348771034", style: kText15RegularBlack)
                      ]),
                ),
                Text.rich(
                  TextSpan(text: 'Email: ', style: kText15BoldBlack, children: [
                    TextSpan(
                        text: "huynhthiminhnhuc@gmail.com",
                        style: kText15RegularBlack)
                  ]),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                Text(
                    "Trên đường đi học về mình bị 1 xe máy va chạm rồi bỏ chạy, hiện tại đang bị thương ở chân",
                    style: kText15RegularBlack),
              ],
            ),
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
