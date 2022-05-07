import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/constant/post.dart';
import 'package:meerapp/controllers/post_controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/present/component/post.dart';
import 'package:meerapp/present/models/post.dart';
import 'package:meerapp/present/page/new_campaign_page/create_new_campaign_page.dart';

class HomePage extends StatelessWidget {
  final PostController _postController = sl.get<PostController>();

  HomePage({Key? key}) : super(key: key);

  Future<List<CampaignPost>> _fetchCampainPosts(
      int startIndex, int number) async {
    return _postController.GetCampaigns(startIndex, number);
  }

  @override
  Widget build(BuildContext context) {
    var w;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CreateNewCampaign(),
          Container(
            color: meerColorBackground,
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.w, 0, 0),
            child: Text(
              "Bài viết",
              style: kText20MediumBlack,
            ),
          ),
          FutureBuilder(
            future: _fetchCampainPosts(0, 10),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return Column(
                //   children: List.generate(
                //     posts.length,
                //     (index) => Post(
                //       avatarUrl: posts[index]["avatarUrl"],
                //       name: posts[index]["name"],
                //       address: posts[index]["address"],
                //       postImageUrl: posts[index]["postImageUrl"],
                //       title: posts[index]["title"],
                //       time: posts[index]["time"],
                //       content: posts[index]["content"],
                //       addressUser: posts[index]["addressUser"],
                //     ),
                //   ),
                // );
                final data = snapshot.data as List<CampaignPost>;
                return Column(
                  children: data.map((post) => Post(postData: post,
                    )).toList(),
                );
              } else if (snapshot.hasError) {
                return Text('fail');
              } else {
                return Text('loading');
              }
            },
          )
        ],
      ),
    );
  }
}

class CreateNewCampaign extends StatelessWidget {
  const CreateNewCampaign({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("asset/demo.jpg"),
              radius: 26,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Container(
                  height: 40.h,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tạo 1 chiến dịch mới nào!",
                    style: kText15RegularGreyNotetext,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateNewCampaignPage()),
        )
      },
    );
  }
}
