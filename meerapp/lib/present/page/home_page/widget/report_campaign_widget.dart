import 'package:flutter/material.dart';
import 'package:meerapp/models/user.dart';
import 'package:meerapp/present/page/home_page/widget/join_campaign_user_widget.dart';

class ReportCampignWidget extends StatelessWidget {
  final List<UserOverview> usersJoin;
  final List<UserOverview> usersNotJoin;
  const ReportCampignWidget({
    Key? key,
    required this.usersJoin,
    required this.usersNotJoin,
  }) : super(key: key);

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
            subtitle: const Text('Gồm cả người đã và chưa đăng ký '),
            children: List.generate(usersJoin.length,
                (index) => JoinCampaignUserItem(user: usersJoin[index])),
          ),
          ExpansionTile(
            title: const Text(
              'Danh sách không tham gia',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Đã đăng kí nhưng không tham gia',
            ),
            children: List.generate(usersNotJoin.length,
                (index) => JoinCampaignUserItem(user: usersNotJoin[index])),
          ),
        ],
      ),
    );
  }
}
