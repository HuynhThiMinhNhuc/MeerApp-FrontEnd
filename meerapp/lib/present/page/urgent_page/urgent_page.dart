import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/controllers/controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/present/component/post.dart';
import 'package:meerapp/present/page/new_emergency_page/create_new_emergencypage.dart';

import '../../../models/post.dart';

class UrgentPage extends StatelessWidget {
  PostController _postController = sl.get<PostController>();
  UrgentPage({Key? key}) : super(key: key);

  Future<List<EmergencyPost>> _fetchEmergencyPosts(
      int startIndex, int number) async {
    return _postController.GetEmergencies(startIndex, number);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CreateNewEmergency(),
          Container(
            height: 20.h,
            color: meerColorBackground,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.w, 0, 0),
            child: Text(
              "Tin khẩn cấp",
              style: kText20MediumBlack,
            ),
          ),
          FutureBuilder(
            future: _fetchEmergencyPosts(0, 10),
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
                final data = snapshot.data as List<EmergencyPost>;
                return Column(
                  children: data
                      .map((post) => Post(
                            postData: post,
                          ))
                      .toList(),
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

class CreateNewEmergency extends StatelessWidget {
  const CreateNewEmergency({
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
                    "Khẩn cấp? Đăng ngay..",
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
          MaterialPageRoute(
              builder: (context) => const CreateNewEmergencyPage()),
        )
      },
    );
  }
}
