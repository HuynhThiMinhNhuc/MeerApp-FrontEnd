import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/api/route/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/constant/current_user.dart';
import 'package:meerapp/present/page/profile/Wrapper/MyImage.dart';
import 'package:meerapp/present/page/Login/login_view.dart';
import 'package:meerapp/present/page/profile/join_view.dart';
import 'package:meerapp/singleton/user.dart';

import '../../../../config/fontconfig.dart';
import '../edit_profile.dart';
import '../menuView.dart';
import '../profilepage.dart';

class ProfileOverView extends StatelessWidget {
  mode modeProfile;

  ProfileOverView(this.modeProfile);

  @override
  Widget build(BuildContext context) {
    Widget joinedOverview(
        String title, int number, Widget clickJoinedOverview) {
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

    return StreamBuilder<List<dynamic>>(
      stream: Stream.fromFuture(Future.wait([
        UserAPI.getCurrentUserInfo(),
        UserAPI.getCreatedCampaign(),
        UserAPI.getDonedCampaign(),
        UserAPI.getNotDoneCampaign(),
      ])),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Column();
        }

        if (snapshot.hasError) {
          return Column();
        }

        final userInfo = snapshot.data![0].data as dynamic;
        final avatarImageURI = userInfo["avatarImageURI"];
        final fullname = userInfo["fullname"];
        final description = userInfo["description"];

        final countCreated = snapshot.data![1].data.length;
        final countDoned = snapshot.data![2].data.length;
        final countNotDone = snapshot.data![3].data.length;

        List name = fullname.toString().split(' ');

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
                        image: avatarImageURI == null
                            ? const AssetImage("assets/avt1.jpg")
                            : MyImage(avatarImageURI),
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
                              name[name.length - 2] +
                                  ' ' +
                                  name[name.length - 1],
                              textAlign: TextAlign.center,
                              style: kText18RegularWhite,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          iconSize: 25.h,
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  'Đăng xuất',
                                  style: kText16BoldBlack,
                                ),
                                content: Text(
                                  'Bạn thật sự muốn đăng xuất khỏi tài khoản này?',
                                  style: kText14RegularBlack,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Hủy'),
                                    child: Text(
                                      'Hủy',
                                      style: kText15BoldBlack.copyWith(
                                          color: meerColorGreyNoteText),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      ),
                                    },
                                    child: Text('Đăng xuất',
                                        style: kText15BoldMain),
                                  ),
                                ],
                              ),
                            );
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
                          gradient:
                              LinearGradient(colors: meerColorGradientActive),
                        ),
                        child: Container(
                          width: 86.h,
                          height: 86.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            image: DecorationImage(
                                alignment: Alignment(0, -0.8.h),
                                image: MyImage(avatarImageURI),
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
                        countCreated,
                        JoinedView(
                          currentTab: 0,
                        )),
                    joinedOverview(
                        'Đã tham gia',
                        countDoned,
                        JoinedView(
                          currentTab: 1,
                        )),
                    joinedOverview(
                        'Bỏ tham gia',
                        countNotDone,
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
                        description.toString(),
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
                SizedBox(
                    child: modeProfile == mode.My
                        ? InkWell(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Container(
                                height: 35.h,
                                decoration: const BoxDecoration(
                                  color: meerColorMain,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ), //BorderRadius.all
                                ),
                                child: const Center(
                                  child: Text(
                                    'Chỉnh sửa hồ sơ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'Roboto_Regular',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfile(),
                                  ));
                            },
                          )
                        : Container()),
              ],
            ),
          ],
        );
      },
    );
  }
}
