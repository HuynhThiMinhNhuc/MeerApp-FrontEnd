import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/constant/post.dart';
import 'package:meerapp/controllers/controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/present/component/post.dart';

import 'package:meerapp/present/models/statusPost.dart';
import 'package:meerapp/present/page/new_campaign_page/create_new_campaign_page.dart';

import '../../../models/post.dart';

class HomePage extends StatefulWidget {
  final PostController _postController = sl.get<PostController>();

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool isLoading = false;
  late final List<CampaignPost> listPost;

  @override
  void initState() {
    super.initState();
    listPost = <CampaignPost>[];
  }

  void _fetchCampainPosts(int startIndex, int number) {

    widget._postController.GetCampaigns(startIndex, number).then((value) {
      setState(() {
        listPost.addAll(value);
      });
    }).onError((error, stackTrace) {log(error.toString());});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchCampainPosts(0, 10);
  }

  @override
  Widget build(BuildContext context) {
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
          Builder(builder: (_) {
            if (listPost.isEmpty) {
              return Text('Không có bài viết');
            }
            return Column(
              children: [
                ...listPost
                    .map((post) => Post(
                          postData: post, mode: StatusPost.campaign,
                        ))
                    .toList(),
                if (isLoading) const Text('loading')
              ],
            );
          })

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
