import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/constant/current_user.dart';
import 'package:meerapp/present/page/Login/login_view.dart';
import 'package:meerapp/present/page/profile/join_view.dart';

import '../../../../config/fontconfig.dart';
import '../edit_profile.dart';
import '../menuView.dart';
import '../profilepage.dart';

class ProfileOverView extends StatefulWidget {
  mode modeProfile;
  ProfileOverView(this.modeProfile);

  @override
  _ProfileOverViewState createState() => _ProfileOverViewState();
}

class _ProfileOverViewState extends State<ProfileOverView> {
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    List name = currentUser['fullname'].toString().split(' ');
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     SizedBox(
    //       height: 10.h,
    //     ),
    //     Row(
    //       children: [
    //         //Avatar widget
    //         Container(
    //           margin: EdgeInsets.only(left: 10.w),
    //           width: 90.h,
    //           height: 90.h,
    //           padding: const EdgeInsets.all(3),
    //           decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               gradient: LinearGradient(colors: meerColorGradientActive)),
    //           child: Container(
    //             width: 70.h,
    //             height: 70.h,
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               border: Border.all(color: Colors.white, width: 5.h),
    //               image: DecorationImage(
    //                 fit: BoxFit.cover,
    //                 image: AssetImage(currentUser['avatarUrl'].toString()),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Expanded(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               joinedOverview('Đã tạo', 15),
    //               joinedOverview('Đã tham gia', 15),
    //               joinedOverview('Bỏ tham gia', 15),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //     SizedBox(
    //       height: 5.h,
    //     ),
    //     Padding(
    //       padding: EdgeInsets.only(top: 7.h, left: 12.w),
    //       child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               name[name.length - 2] + ' ' + name[name.length - 1],
    //               style: kText15BoldBlack,
    //             ),
    //             SizedBox(
    //               height: 7.h,
    //             ),
    //             Text(
    //               currentUser['phoneNumber'].toString(),
    //               style: kText13RegularBlack,
    //             ),
    //             SizedBox(
    //               height: 7.h,
    //             ),
    //             Text(
    //               currentUser['description'].toString(),
    //               style: kText13RegularBlack,
    //             ),
    //           ]),
    //     ),
    //     SizedBox(
    //       height: 15.h,
    //     ),
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 250.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.darken),
                    image: AssetImage("asset/avt1.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            Positioned.fill(
                top: 0,
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 50.w, top: 14.h),
                        child: Text(
                          name[name.length - 2] + ' ' + name[name.length - 1],
                          textAlign: TextAlign.center,
                          style: kText18RegularWhite,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.ellipsisVertical,
                        color: Colors.white,
                      ),
                      iconSize: 20.h,
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MenuView()),
                        ),
                       
                      },
                    ),
                  ],
                )),
            Positioned(
              bottom: -60.h,
              left: 10.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 90.h,
                    height: 90.h,
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: meerColorGradientActive),
                    ),
                    child: Container(
                      width: 86.h,
                      height: 86.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        image: DecorationImage(
                            alignment: Alignment(0, -0.8.h),
                            image: AssetImage("asset/avt1.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(left: 85.w, top: 10.h),
          child: Padding(
            padding: EdgeInsets.only(bottom: 7.h, left: 20.w, right: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                joinedOverview(
                    'Đã tạo',
                    15,
                    JoinedView(
                      currentTab: 0,
                    )),
                joinedOverview(
                    'Đã tham gia',
                    15,
                    JoinedView(
                      currentTab: 1,
                    )),
                joinedOverview(
                    'Bỏ tham gia',
                    15,
                    JoinedView(
                      currentTab: 2,
                    )),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name[name.length - 2] + ' ' + name[name.length - 1],
                        style: kText15BoldBlack,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                        width: 10.h,
                        height: 10.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: meerColorMain,
                        ),
                      ),
                      SizedBox(width: 5.w),
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Text(
                    currentUser['description'].toString(),
                    style: kText13RegularBlack,
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
           
          ],
        ),
      ],
    );
  }

  Widget joinedOverview(String title, int number, Widget clickJoinedOverview) {
    return InkWell(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => clickJoinedOverview))
      },
      child: Container(
        child: Column(children: [
          Text(
            number.toString(),
            style: kText16BoldBlack,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            title,
            style: kText11RegularHintText,
          ),
        ]),
      ),
    );
  }
}
