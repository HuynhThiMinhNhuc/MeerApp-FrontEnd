import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/controllers/controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/present/component/post.dart';
import 'package:meerapp/models/post.dart';

import 'package:meerapp/present/models/statusPost.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CreateNewEmergency(),
          Container(
            height: 15.h,
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
                            postData: post, mode: StatusPost.emergency,
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
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            iconSize: 130.w,
            icon: Container(
                height: 130.w,
                width: 130.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: meerColorRed,
                  boxShadow: [
                    BoxShadow(
                      color: meerColorRed.withOpacity(0.5),
                      spreadRadius: 13,
                      blurRadius: 5,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: IconButton(
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateNewEmergencyPage()),
                          )
                        },
                    icon: const Icon(FontAwesomeIcons.bell,
                        size: 50, color: meerColorWhite))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateNewEmergencyPage()),
              );
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "Khẩn cấp",
            style: kText15BoldBlack,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "Nhấn trong trường hợp khẩn cấp",
            style: kText13RegularNote,
          ),
        ],
      ),
    );
  }
}
