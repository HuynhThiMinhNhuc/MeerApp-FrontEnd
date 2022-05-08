import 'package:flutter/material.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';

class AddJoinerPage extends StatelessWidget {
  const AddJoinerPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Column(children: [
        
      ]),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: meerColorBackground,
      centerTitle: true,
      elevation: 0,
      iconTheme: const  IconThemeData(color: meerColorBlackIcon),
      title: Text("Báo cáo", style: ktext18BoldBlack,),
    );
  }
}