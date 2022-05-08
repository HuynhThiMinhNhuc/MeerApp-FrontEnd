import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/page/home_page/detail_campaign_page.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData iconMenu;
  final Function() clickMenu;

  const MenuItem({
    Key? key,
    required this.title,
    required this.iconMenu,
    required this.clickMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: clickMenu,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                children: [
                  Icon(
                    iconMenu,
                    color: meerColorGreyText,
                    size: 25.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    title,
                    style: kText16RegularBlack,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Divider(
                color: meerColor25GreyNoteText,
                height: 1.w,
              ),
            )
          ],
        ),
      ),
    );
  }
}
