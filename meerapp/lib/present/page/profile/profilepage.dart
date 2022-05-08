
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/constant/current_user.dart';
import 'package:meerapp/constant/post.dart';
import 'package:meerapp/present/page/profile/Widgets/profile_overview.dart';
import 'package:meerapp/present/models/statusPost.dart';
import '../../../config/fontconfig.dart';
import '../../component/post.dart';

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
              // TODO: Open comment here
              // children: List.generate(
              //     posts.length,
              //     (index) => Post(
              //           avatarUrl: posts[index]["avatarUrl"],
              //           name: posts[index]["name"],
              //           address: posts[index]["address"],
              //           postImageUrl: posts[index]["postImageUrl"],
              //           title: posts[index]["title"],
              //           time: posts[index]["time"],
              //           content: posts[index]["content"],
              //           addressUser: posts[index]["addressUser"],
              //         ))),
              // ? Test data
              children: [Text('test')],)

        ],
      )
    ],
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
