import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/api/route/user.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/component/EventJoin.dart';

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
    var future = Future.wait([
      UserAPI.getDonedCampaign(),
      UserAPI.getDonedEmergency(),
    ]);
    String getStatus(int status) {
      return status == 0
          ? "đã tạo"
          : status == 1
              ? "đã tham gia"
              : "bỏ tham gia";
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 15.h,
          ),
          status == 2
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: campaignList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EventJoinItem(
                        userName: campaignList[index]['name'].toString(),
                        postImageUrl:
                            campaignList[index]['postImageUrl'].toString(),
                        title: campaignList[index]['title'].toString(),
                        time: campaignList[index]['time'].toString(),
                        status: status);
                  },
                )
              : Column(
                  children: [
                    ExpansionTile(
                      title: const Text(
                        'Chiến dịch tình nguyện',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Gồm các chiến dịch tình nguyện ' + getStatus(status),
                        style: kText13RegularNote,
                      ),
                      children: List.generate(
                          campaignList.length,
                          (index) => EventJoinItem(
                              userName: campaignList[index]['name'].toString(),
                              postImageUrl: campaignList[index]['postImageUrl']
                                  .toString(),
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
                        'Gồm các sự kiện khẩn cấp ' + getStatus(status),
                        style: kText13RegularNote,
                      ),
                      children: List.generate(
                          campaignList.length,
                          (index) => EventJoinItem(
                              userName: campaignList[index]['name'].toString(),
                              postImageUrl: campaignList[index]['postImageUrl']
                                  .toString(),
                              title: campaignList[index]['title'].toString(),
                              time: campaignList[index]['time'].toString(),
                              status: status)),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
