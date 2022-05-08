import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/page/home_page/detail_campaign_page.dart';

class EventJoinItem extends StatelessWidget {
  final String userName;
  final String? postImageUrl;
  final String title;
  final String time;
  final int status;

  const EventJoinItem({
    Key? key,
    required this.userName,
    required this.postImageUrl,
    required this.title,
    required this.time,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getStatus() {
      String statusString;
      statusString = (status == 0
          ? "Đã tạo"
          : status == 1
              ? "Đã tham gia"
              : "Bỏ tham gia");
      return statusString;
    }

    ;

    Color getColor() {
      Color color;
      color = (status == 0
          ? meerColorLightBlue
          : status == 1
              ? meerColorMain
              : meerColorRed);

      return color;
    }

    double c_width = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        width: c_width,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        child: Row(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10.w,
            ),
            Container(
              width: 50.h,
              height: 50.h,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('asset/demo.jpg'), fit: BoxFit.cover)
                  // NetworkImage(avatarUrl), fit: BoxFit.cover),
                  ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        title,
                        style: kText15BoldBlack,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      'Tổ chức bởi: ' + userName,
                      style: kText13RegularBlack,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(time, style: kText13RegularNote),
                          Text(getStatus(),
                              style:
                                  kText15BoldBlack.copyWith(color: getColor())),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
