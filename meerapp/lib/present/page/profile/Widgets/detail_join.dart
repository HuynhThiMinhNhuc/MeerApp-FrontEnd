import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/api/MyWrapper.dart';
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

  String getStatus(int status) {
    return status == 0
        ? "đã tạo"
        : status == 1
            ? "đã tham gia"
            : "bỏ tham gia";
  }

  Future<List<MyResponse>> getDataList(int status) {
    if (status == 0) {
      return Future.wait([
        UserAPI.getCreatedCampaign(),
        UserAPI.getCreatedEmergency(),
      ]);
    } else if (status == 1) {
      return Future.wait([
        UserAPI.getDonedCampaign(),
        UserAPI.getDonedEmergency(),
      ]);
    } else {
      return Future.wait([
        UserAPI.getNotDoneCampaign(),
      ]);
    }
  }

  Widget _buildItem(dynamic itemData) {
    return EventJoinItem(
        userName: itemData['creator']["fullname"].toString(),
        title: itemData['title'].toString(),
        time: itemData['createdAt'].toString(),
        status: status);
  }

  Widget _buildBody(
      BuildContext context, int statusCode, List<List<dynamic>> dataLists) {
    if (status == 2) {
      if (dataLists.length != 1) return const Center();
      final campaignList = dataLists[0];
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: campaignList.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildItem(campaignList[index]),
      );
    } else {
      if (dataLists.length != 2) return const Center();
      final campaignList = dataLists[0];
      final emergencyList = dataLists[1];
      return Column(
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
            children: List.generate(campaignList.length,
                (index) => _buildItem(campaignList[index])),
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
            children: List.generate(emergencyList.length,
                (index) => _buildItem(emergencyList[index])),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 15.h,
          ),
          FutureBuilder<List<MyResponse>>(
              future: getDataList(status),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final responses = snapshot.data;
                final dataLists =
                    snapshot.data!.map((e) => e.data as List<dynamic>).toList();
                return _buildBody(
                  context,
                  status,
                  dataLists,
                );
              })
        ],
      ),
    );
  }
}
