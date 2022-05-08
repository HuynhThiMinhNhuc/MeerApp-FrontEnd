import 'dart:developer';

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

class UrgentPage extends StatefulWidget {
  final PostController _postController = sl.get<PostController>();

  UrgentPage({Key? key}) : super(key: key);

  @override
  State<UrgentPage> createState() => _UrgentPageState();
}

class _UrgentPageState extends State<UrgentPage> {
  bool isLoading = false;
  late final List<EmergencyPost> posts;

  @override
  void initState() {
    super.initState();
    posts = <EmergencyPost>[];
  }

  void _fetchEmergencyPosts(int startIndex, int number) {
    setState(() {
      isLoading = true;
    });
    widget._postController.GetEmergencies(startIndex, number).then((value) {
      setState(() {
        posts.addAll(value);
      });
    }).onError((error, stackTrace) {
      log(error.toString());
    }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchEmergencyPosts(0, 10);
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
          _buildListPosts(),
        ],
      ),
    );
  }

  Widget _buildListPosts() {
    if (posts.isNotEmpty || isLoading) {
      return Column(
        children: [
          ...posts
              .map((post) => Post(
                    postData: post,
                  ))
              .toList(),
          if (isLoading) const Text('loading')
        ],
      );
    } else {
      return Text('Không có bài viết');
    }
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
