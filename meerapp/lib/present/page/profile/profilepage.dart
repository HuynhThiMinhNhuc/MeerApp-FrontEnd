import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/api/route/user.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/constant/current_user.dart';
import 'package:meerapp/constant/post.dart';
import 'package:meerapp/models/post.dart';
import 'package:meerapp/present/page/profile/Widgets/profile_overview.dart';
import 'package:meerapp/present/models/statusPost.dart';
import 'package:meerapp/singleton/user.dart';
import '../../../config/fontconfig.dart';
import '../../component/post.dart';

enum mode { My, Other }

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    var dataStream = Stream.fromFuture(Future.wait([
      UserAPI.getCurrentUserInfo(),
      UserAPI.getCreatedCampaign(),
    ]));

    return SingleChildScrollView(
      child: StreamBuilder<List<MyResponse>>(
        stream: dataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userInfo = snapshot.data?[0].data;
            final createdCampaigns = snapshot.data?[1].data as List<dynamic>;
            return Column(
              children: [
                ProfileOverView(
                  mode.My,
                ),
                Column(
                  // TODO: Open comment here
                  children: createdCampaigns
                      .map((e) => Post(postData: CampaignPost.fromJson(e)))
                      .toList(),
                ),
              ],
            );
          } else {
            return Column();
          }
        },
      ),
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
