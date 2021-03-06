import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/api/route/user.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/models/post.dart';
import 'package:meerapp/present/page/profile/Widgets/profile_overview.dart';
import 'package:meerapp/singleton/user.dart';
import '../../../config/fontconfig.dart';
import '../../component/post.dart';

enum mode { My, Other }

class ProfilePage extends StatefulWidget {
  final int userId;
  ProfilePage({
    required this.userId,
  });
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late List<bool> stateToggle = [true, false];
  late TabController _tabController;

  mode getMode() {
    if (widget.userId == UserSingleton.instance.auth!.userId) {
      return mode.My;
    } else {
      return mode.My;
    }
  }

  @override
  void initState() {
    super.initState();
    //UserSingleton.instance.refreshUserInfo();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: StreamBuilder(
        stream: UserSingleton.instance.userInfoStream.stream,
        builder: (context, snapshot) {
          return Column(
            children: [
              ProfileOverView(
                modeProfile: getMode(),
                userId: widget.userId,
              ),
              _buildToggleButton(),
              _buildPost(stateToggle),
            ],
          );
        },
      ),
    );
  }

  Widget _buildToggleButton() {
    return Container(
      height: 40.h,
      child: ToggleButtons(
          borderRadius: BorderRadius.circular(30),
          fillColor: meerColorMain,
          borderColor: meerColorMain,
          selectedBorderColor: meerColorMain,
          color: meerColorBlack,
          selectedColor: meerColorWhite,
          onPressed: (int index) {
            setState(() {
              // for (int buttonIndex = 0;
              //     buttonIndex < stateToggle.length;
              //     buttonIndex++) {
              //   if (buttonIndex == index) {
              //     stateToggle[buttonIndex] = true;
              //   } else {
              //     stateToggle[buttonIndex] = false;
              //   }
              // }
              if (index == 0) {
                stateToggle = [true, false];
              } else {
                stateToggle = [false, true];
              }
            });
          },
          isSelected: stateToggle,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 36) / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chi???n d???ch",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.h),
              child: Container(
                width: (MediaQuery.of(context).size.width - 36) / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Kh???n c???p",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  Widget _buildPost(List<bool> stateToggle) {
    if (stateToggle[0]) {
      return _buildListCreatedCampaign();
    } else {
      return _buildListCreatedEmergency();
    }
  }

  Widget _buildListCreatedCampaign() {
    return FutureBuilder<MyResponse>(
      future: UserAPI.getCreatedCampaign(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Column(
            children: [CircularProgressIndicator()],
          );
        }

        final createdCampaigns = snapshot.data!.data as List<dynamic>;
        return Column(
          children: createdCampaigns
              .map((e) => Post(postData: EmergencyPost.fromJson(e)))
              .toList(),
        );
      },
    );
  }

  Widget _buildListCreatedEmergency() {
    return FutureBuilder<MyResponse>(
      future: UserAPI.getCreatedEmergency(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Column(
            children: [CircularProgressIndicator()],
          );
        }

        final createdEmergencys = snapshot.data!.data as List<dynamic>;
        return Column(
          children: createdEmergencys
              .map((e) => Post(postData: EmergencyPost.fromJson(e)))
              .toList(),
        );
      },
    );
  }

  Widget joinedOverview(String title, int number) {
    return Column(
      children: [
        Text(
          number.toString(),
          style: kText15BoldBlack,
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          title,
          style: kText11RegularHintText,
        ),
      ],
    );
  }
}
