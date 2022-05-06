import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/constant/post.dart';
import 'package:meerapp/present/component/post.dart';
import 'package:meerapp/present/page/new_campaign_page/create_new_campaign_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreateNewCampaign(),
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
          Column(
              children: List.generate(
                  posts.length,
                  (index) => Post(
                        avatarUrl: posts[index]["avatarUrl"],
                        name: posts[index]["name"],
                        address: posts[index]["address"],
                        postImageUrl: posts[index]["postImageUrl"],
                        title: posts[index]["title"],
                        time: posts[index]["time"],
                        content: posts[index]["content"],
                        addressUser: posts[index]["addressUser"],
                      ))),
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
