import 'package:flutter/material.dart';
import 'package:meerapp/constant/post.dart';
import 'package:meerapp/present/component/post.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: List.generate(posts.length, (index) => Post(avatarUrl: posts[index]["avatarUrl"], name: posts[index]["name"], address: posts[index]["address"], postImageUrl: posts[index]["postImageUrl"], title: posts[index]["title"], time: posts[index]["time"], content: posts[index]["content"], addressUser:posts[index]["addressUser"] ,))),
    );
  }
}
