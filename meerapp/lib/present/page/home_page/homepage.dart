import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/constant/post.dart';
import 'package:meerapp/present/component/post.dart';

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
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.w, 0, 0),
            child: Text("Bài viết", style: kText20MediumBlack,),
          ),
          Column(
            children: List.generate(posts.length, (index) => Post(avatarUrl: posts[index]["avatarUrl"], name: posts[index]["name"], address: posts[index]["address"], postImageUrl: posts[index]["postImageUrl"], title: posts[index]["title"], time: posts[index]["time"], content: posts[index]["content"], addressUser:posts[index]["addressUser"] ,))),
        ],
      ),
    );
  }
}
