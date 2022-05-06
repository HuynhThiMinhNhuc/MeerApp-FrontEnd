import 'package:flutter/material.dart';
import 'package:meerapp/constant/user.dart';
import 'package:meerapp/present/page/home_page/widget/join_campaign_user_widget.dart';

class ReportCampignWidget extends StatelessWidget {
  const ReportCampignWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ExpansionTile(
            title: const Text(
              'Danh sách tham gia',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Gồm cả người đã và chưa chiến dịch '),
            children: List.generate(
                users.length,
                (index) => JoinCampaignUserItem(
                    fullName: users[index]["fullName"],
                    avatarUrl: users[index]["avatarUlr"])),
          ),
          ExpansionTile(
            title: const Text(
              'Danh sách không tham gia',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Đã đăng kí nhưng không tham gia',
            ),
            children: List.generate(
                users.length,
                (index) => JoinCampaignUserItem(
                    fullName: users[index]["fullName"],
                    avatarUrl: users[index]["avatarUlr"])),
          ),
        ],
      ),
    );
  }
}
