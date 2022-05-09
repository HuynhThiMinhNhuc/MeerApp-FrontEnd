import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/models/user.dart';

class JoinCamPaignUser extends StatelessWidget {
  final List<UserOverview> users;
  const JoinCamPaignUser({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Text("${users.length} thành viên ", style: ktext18BoldBlack,),
          ),
          Column(
            children: List.generate(users.length, (index) => 
            JoinCampaignUserItem(user: users[index])
          ),)
        ],
      ),
    );
  }
}

class JoinCampaignUserItem extends StatelessWidget {
  final UserOverview user;
  const JoinCampaignUserItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: ListTile(
        leading:   Container(
        width: 61.h,
        height: 61.h,
        decoration: const  BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: meerColorGradientActive)),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            width: 60.h,
            height: 60.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              image: DecorationImage(
                  image: user.avatarUri != null ? NetworkImage(user.avatarUri!) as ImageProvider : const AssetImage("asset/avatardefault.png"),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ),
        title: Text(user.name, style: kText15RegularBlack,),
        selectedColor: Color.fromARGB(16, 2, 1, 1),
        onTap: () {},
      ),
    );
  }
}
