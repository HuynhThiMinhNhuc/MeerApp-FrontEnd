import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/fontconfig.dart';

class Post extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String addressUser;
  final String? postImageUrl;
  final String title;
  final String content;
  final String time;
  final String address;

  const Post(
      {Key? key,
      required this.avatarUrl,
      required this.name,
      required this.address,
      required this.postImageUrl,
      required this.title,
      required this.time,
      required this.addressUser,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(avatarUrl), fit: BoxFit.cover),
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
                          child: Text(name, style: kText15BoldBlack),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(addressUser, style: kText12RegularBlack),
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
                                  child: Text('Hủy', style: kText13BoldMain,),
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
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 400.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      NetworkImage(postImageUrl != null ? postImageUrl! : ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 5.w, 5.h),
              child: Text(
                title,
                style: kText15BoldBlack,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 10.h),
              child: RichText(
                text: TextSpan(
                  text: content,
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: "\n\nĐịa điểm: " ,
                      style: kText13BoldBlack,
                    ),
                    TextSpan(
                      text:  address,
                      style: kText13RegularBlack,
                    ),
                    TextSpan(
                      text: "\n\nThời gian: ",
                      style: kText13BoldBlack,
                    ),
                    TextSpan(
                      text:  time,
                      style: kText13RegularBlack,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 0, 10.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Spacer(),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.heart,
                          color: Colors.red,
                          size: 18.w,
                        ),
                        splashRadius: 20.w,
                      ),
                      Text(
                        "18",
                        style: kText13BoldBlack,
                      )
                    ],
                  ),
                  SizedBox(width: 10.w),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.skullCrossbones,
                          size: 18.w,
                        ),
                        splashRadius: 20.w,
                      ),
                      Text(
                        "22",
                        style: kText13BoldBlack,
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
    );
  }
}
