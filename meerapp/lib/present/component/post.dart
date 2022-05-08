import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/config/helper.dart';
import 'package:meerapp/present/models/statusPost.dart';
import 'package:meerapp/present/models/status_compaign.dart';
import 'package:meerapp/present/models/status_emerency.dart';
import 'package:meerapp/present/page/home_page/detail_campaign_page.dart';
import 'package:meerapp/present/page/urgent_page/detail_emerency_page.dart';


import '../../models/post.dart';


class Post extends StatelessWidget {
  final IPost postData;
  // final String? avatarUrl;
  // final String name;
  // final String? addressUser;
  // final String? postImageUrl;
  // final String title;
  // final String content;
  // final String time;
  // final String address;
  final StatusPost mode;

  const Post(
      {Key? key,
      // required this.avatarUrl,
      // required this.name,
      // required this.address,
      // required this.postImageUrl,
      // required this.title,
      // required this.time,
      // required this.addressUser,
      // required this.content,
      required this.mode,
      required this.postData,
      })

      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 40.h,
                      height: 40.h,
                      decoration: const  BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("asset/avt1.jpg", ),fit: BoxFit.cover)
                            // NetworkImage(avatarUrl), fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(postData.creator.name, style: kText15BoldBlack),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        if (postData.creator.address != null) Text(postData.creator.address!, style: kText12RegularBlack),
                      ],
                    )
                  ],
                ),
                PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                  'Nhập chi tiết điều bạn muốn báo cáo'),
                              content: TextFormField(),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Hủy'),
                                  child: Text(
                                    'Hủy',
                                    style: kText13BoldMain,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Đăng'),
                                  child: Text('Đăng', style: kText13BoldMain),
                                ),
                              ],
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            'Báo cáo',
                            style: kText13RegularBlack,
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text(
                            'Chỉnh sửa',
                            style: kText13RegularBlack,
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(

                              title: const Text(
                                  'Xóa bài viết'),
                              content:const  Text("Bạn chắc chắn muốn xóa bài viết này?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Hủy'),
                                  child: Text(
                                    'Hủy',
                                    style: kText13BoldMain,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Xóa'),
                                  child: Text('Xóa', style: kText13BoldMain),
                                ),
                              ],
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            'Xóa',
                            style: kText13RegularBlack,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 400.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/demo.jpg"),
                  //NetworkImage(postImageUrl != null ? postImageUrl! : ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 5.w, 5.h),
                  child: Text(
                    postData.title,
                    style: kText15BoldBlack,
                  ),
                ),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  mode == StatusPost.campaign? const DetailCampaignPage(mode: StatusCompaign.admin, post: null,) : const DetailEmerencyPage(mode: StatusEmerency.admin)),
                    )),
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 10.h),
              child: RichText(
                text: TextSpan(
                  text: postData.content,
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: "\n\nĐịa điểm: ",
                      style: kText13BoldBlack,
                    ),
                    TextSpan(
                      text: postData.address,
                      style: kText13RegularBlack,
                    ),
                     TextSpan(
                      text: "\n\nThời gian: " ,
                      style: kText13BoldBlack,
                    ) ,
                    TextSpan(
                      text: DateTimeToString(postData.timeCreate),
                      style: kText13RegularBlack,
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
