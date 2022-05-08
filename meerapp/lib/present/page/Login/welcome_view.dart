import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/present/page/Login/profile_view.dart';
import 'package:meerapp/present/page/home_page/home_page.dart';
import 'package:meerapp/present/page/profile/profilepage.dart';
import 'package:meerapp/present/rootapp.dart';

import '../../component/custom_btn.dart';

class WelcomeView extends StatefulWidget {
  final String email;

  WelcomeView({Key? key, required this.email}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: meerColorGreyText, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.checkCircle,
                  color: meerColorMain,
                  size: 30,
                ),
                SizedBox(
                  width: 7.w,
                ),
                Text(
                  'Đăng ký thành công',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto-Regular.ttf',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Chào mừng đến với MEER!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: meerColorMain,
                  fontSize: 28,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                  'Tình nguyện không phải công việc cá nhân đó là sự gắn kết của xã hội!',
                  maxLines: 4,
                  style: TextStyle(
                    color: meerColorGreyNoteText,
                    fontFamily: 'Roboto-Regular.tff',
                    fontSize: 16,
                  )),
            ),
            Center(
              child: Image(
                image: AssetImage('asset/welcome.png'),
                width: 350,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                  onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RootApp(),
                          ),
                          (route) => false,
                        )
                      },
                  textInput: 'BẮT ĐẦU'),
            )
          ],
        ),
      ),
    );
  }
}
