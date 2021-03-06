import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/config/helper.dart';
import 'package:meerapp/controllers/controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/present/component/my_alert_dialog_2.dart';
import 'package:meerapp/present/models/status_compaign.dart';
import 'package:meerapp/present/models/status_emerency.dart';
import 'package:meerapp/present/page/home_page/detail_campaign_page.dart';
import 'package:meerapp/present/page/new_emergency_page/create_new_emergencypage.dart';
import 'package:meerapp/present/page/profile/Wrapper/MyImage.dart';
import 'package:meerapp/present/page/urgent_page/detail_emerency_page.dart';
import 'package:meerapp/singleton/user.dart';

import '../../models/post.dart';
import '../page/new_campaign_page/create_new_campaign_page.dart';

class Post extends StatelessWidget {
  final IPost postData;
  final Function? onDeletePost;
  final Function? onUpdatePost;
  bool get isMainPost =>
      UserSingleton.instance.auth != null &&
      UserSingleton.instance.auth!.userId == postData.creator.id;

  const Post({
    Key? key,
    required this.postData,
    this.onDeletePost,
    this.onUpdatePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
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
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: MyImageProvider(
                                    postData.imageUrl,
                                    const AssetImage(
                                        "asset/avatardefault.png")),
                                fit: BoxFit.cover)
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
                            child: Text(postData.creator.name,
                                style: kText15BoldBlack),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          if (postData.creator.address != null)
                            Text(postData.creator.address!,
                                style: kText12RegularBlack),
                        ],
                      )
                    ],
                  ),
                  PopupMenuButton(
                    onSelected: (selection) {
                      switch (selection) {
                        case 1:
                          getFunctionReport(context);
                          break;
                        case 2:
                          getFuctionEdit(context);
                          break;
                        case 3:
                          getFuctionDeletePost(context);
                          break;
                        default:
                      }
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: ListTile(
                          title: Text(
                            'Báo cáo',
                            style: kText13RegularBlack,
                          ),
                        ),
                        value: 1,
                      ),
                      if (isMainPost)
                        PopupMenuItem(
                          value: 2,
                          child: ListTile(
                            title: Text(
                              'Chỉnh sửa',
                              style: kText13RegularBlack,
                            ),
                          ),
                        ),
                      if (isMainPost)
                        PopupMenuItem(
                          value: 3,
                          child: ListTile(
                            title: Text(
                              'Xóa',
                              style: kText13RegularBlack,
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
              postData.bannerUrl != null
                  ? Container(
                      height: 400.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MyImageProvider(postData.bannerUrl,
                              const AssetImage("asset/failedimage.png")),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 7.h, 5.w, 7.h),
                child: Text(
                  postData.title,
                  style: kText15BoldBlack,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 3.h, 5.w, 7.h),
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
                        text: "\n\nThời gian " +
                            (postData is CampaignPost
                                ? 'tổ chức: '
                                : 'kêu gọi: '),
                        style: kText13BoldBlack,
                      ),
                      TextSpan(
                        text: DateTimeToString((postData is CampaignPost)
                            ? (postData as CampaignPost).timeStart
                            : postData.timeCreate),
                        style: kText13RegularBlack,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => postData is CampaignPost
                ? DetailCampaignPage(
                    mode: StatusCompaign.admin,
                    postId: postData.id,
                  )
                : DetailEmerencyPage(
                    mode: StatusEmerency.admin,
                    postId: postData.id,
                  )),
      ),
    );
  }

  Set<Future> getFuctionEdit(BuildContext context) {
    return {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => postData is CampaignPost
              ? CreateNewCampaignPage(initData: postData as CampaignPost)
              : CreateNewEmergencyPage(initData: postData as EmergencyPost),
        ),
      ).then((value) {
        if (value == 'ok') {
          onUpdatePost?.call();
        }
      })
    };
  }

  Future<String?> getFuctionDeletePost(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Xóa bài viết'),
        content: const Text("Bạn chắc chắn muốn xóa bài viết này?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Hủy',
              style: kText13BoldMain,
            ),
          ),
          TextButton(
            onPressed: () async {
              var controller = sl.get<PostController>();
              var isSuccess = await controller.DeletePost(
                  postData is CampaignPost ? 'campaign' : 'emergency',
                  [postData.id]);
              if (isSuccess) {
                showDialog(
                  context: context,
                  builder: (_) => const MyAlertDialog2(
                      title: 'Thông báo', content: 'Xoá bài viết thành công'),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (_) => const MyAlertDialog2(
                      title: 'Lỗi', content: 'Không thể xoá bài viết'),
                );
              }
              // Navigator.pop(context);
            },
            child: Text('Xóa', style: kText13BoldMain),
          ),
        ],
      ),
    );
  }

  Future<String?> getFunctionReport(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Nhập chi tiết điều bạn muốn báo cáo'),
        content: TextFormField(),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Hủy'),
            child: Text(
              'Hủy',
              style: kText13BoldMain,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Đăng'),
            child: Text('Đăng', style: kText13BoldMain),
          ),
        ],
      ),
    );
  }
}
