import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/constant/post.dart';
import 'package:meerapp/constant/user.dart';
import 'package:meerapp/present/component/EventJoin.dart';
import 'package:meerapp/present/page/home_page/widget/join_campaign_user_widget.dart';

class DetailJoinWidget extends StatelessWidget {
  final List campaignList;
  final List emergencyList;
  final int status;

  const DetailJoinWidget({
    Key? key,
    required this.campaignList,
    required this.emergencyList,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 15.h,
          ),
          ExpansionTile(
            title: const Text(
              'Chiến dịch tình nguyện',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Gồm các chiến dịch tình nguyện đã tham gia',
              style: kText13RegularNote,
            ),
            children: List.generate(
                campaignList.length,
                (index) => EventJoinItem(
                    userName: campaignList[index]['name'].toString(),
                    postImageUrl:
                        campaignList[index]['postImageUrl'].toString(),
                    title: campaignList[index]['title'].toString(),
                    time: campaignList[index]['time'].toString(),
                    status: status)),
          ),
          ExpansionTile(
            title: const Text(
              'Sự kiện khẩn cấp',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Gồm các sự kiện khẩn cấp đã tham gia',
              style: kText13RegularNote,
            ),
            children: List.generate(
                campaignList.length,
                (index) => EventJoinItem(
                    userName: campaignList[index]['name'].toString(),
                    postImageUrl:
                        campaignList[index]['postImageUrl'].toString(),
                    title: campaignList[index]['title'].toString(),
                    time: campaignList[index]['time'].toString(),
                    status: status)),
          ),
        ],
      ),
    );
  }
}
