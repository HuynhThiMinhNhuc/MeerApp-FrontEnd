import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/constant/current_user.dart';
import 'package:meerapp/constant/post.dart';
import 'package:meerapp/present/page/profile/Widgets/profile_overview.dart';
import '../../../config/fontconfig.dart';
import '../../component/post.dart';
import '../home_page/widget/introduce_campaignwidget.dart';
import '../home_page/widget/join_campaign_user.dart';

enum mode { My, Other}
class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int currentTab = 0;
  List userPost = ((currentUser['listpost']) as List);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    List name = currentUser['fullname'].toString().split(' ');
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileOverView(mode.My),
           Column(
              children: List.generate(
                  userPost.length,
                  (index) => Post(
                        avatarUrl: userPost[index]["avatarUrl"],
                        name: userPost[index]["name"],
                        address: userPost[index]["address"],
                        postImageUrl: userPost[index]["postImageUrl"],
                        title: userPost[index]["title"],
                        time: userPost[index]["time"],
                        content: userPost[index]["content"],
                        addressUser: userPost[index]["addressUser"],
                      ))),
        ],
      
      ),
    );
  }
 
}
