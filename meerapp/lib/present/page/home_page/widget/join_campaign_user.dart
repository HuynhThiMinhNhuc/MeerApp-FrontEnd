import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinCamPaignUser extends StatelessWidget {
  const JoinCamPaignUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                radius: 18.h,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60")),
            title: Text("Nguyen Gia Huy"),
            selectedColor: Color(0x10F4F4F4),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
