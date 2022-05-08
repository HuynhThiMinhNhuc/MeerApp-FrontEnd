import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/constant.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/controllers/controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/present/component/loading_page.dart';
import 'package:meerapp/present/component/post.dart';

import '../../../models/post.dart';
import '../new_campaign_page/create_new_campaign_page.dart';

class HomePage extends StatefulWidget {
  final PostController _postController = sl.get<PostController>();

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  late final List<CampaignPost> posts;
  Timer? debounceLoadPostsTimer;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    posts = <CampaignPost>[];
    _scrollController.addListener(() async {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        // log("reach the bottom");

        if (!isLoading &&
            (debounceLoadPostsTimer == null ||
                !debounceLoadPostsTimer!.isActive)) {
          _fetchCampainPosts(posts.length, pageSize);
        }
      }
      if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        log("reach the top");
      }
    });
  }

  void _fetchCampainPosts(int startIndex, int number) async {
    log('Fetch data');
    setState(() {
      isLoading = true;
    });
    widget._postController.GetCampaigns(startIndex, number).then((value) {
      setState(() {
        posts.addAll(value);
      });
    }).onError((error, stackTrace) {
      log(error.toString());
    }).then((value) async {
      setState(() {
        isLoading = false;
      });
      log('fetch complete');
      debounceLoadPostsTimer = Timer.periodic(Duration(seconds: 2), (timer) {
        timer.cancel();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchCampainPosts(0, pageSize);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
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
          _buildListPosts()
        ],
      ),
    );
  }

  Widget _buildListPosts() {
    if (posts.isNotEmpty || isLoading) {
      final count = isLoading ? posts.length + 1 : posts.length;
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: count,
          itemBuilder: (_, index) {
            if (index < posts.length) {
              return Post(postData: posts[index]);
            } else {
              return Container(
                height: 100,
                child: const LoadingPage(
                  size: 50,
                ),
              );
            }
          });
    } else {
      return Text('Không có bài viết');
    }
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
