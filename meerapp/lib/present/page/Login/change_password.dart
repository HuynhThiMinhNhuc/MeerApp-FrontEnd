
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';

import '../../component/custom_btn.dart';
import '../../component/password_input.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 0, 50),
            child: Row(children: [
              IconButton(
                  onPressed: () => {},
                  icon: const FaIcon(
                    FontAwesomeIcons.chevronCircleLeft,
                    color: meerColorGreyNoteText,
                    size: 40,
                  )),
            ]),
          ),
          const Text(
            ' Change Password',
            style: TextStyle(
                color: meerColorMain,
                fontSize: 40,
                fontFamily: 'Roboto-Regular.ttf',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
            child: const Text(
              'New password must be different from previous used passwords',
              style: TextStyle(
                  color: meerColorGreyNoteText,
                  fontSize: 20,
                  fontFamily: 'Roboto_Regular'),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Text(
                'New Password',
                style: TextStyle(
                    color: meerColorMain,
                    fontFamily: 'Roboto-Regular.tff',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: PassWordInput(
              textInputType: TextInputType.text,
              securitytext: false,
              background: Colors.white,
              boder: meerColorMain,
              hint: '',
              ispass: true,
              textcontroller: passwordcontroller,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Text(
                'Confirm Password',
                style: TextStyle(
                    color: meerColorMain,
                    fontFamily: 'Roboto-Regular.tff',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: PassWordInput(
              securitytext: true,
              background: Colors.white,
              boder: meerColorMain,
              hint: '',
              ispass: true,
              textcontroller: confirmpasswordcontroller,
              textInputType: TextInputType.text,
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: CustomButton(
                  onPressed: () => {}, textInput: 'CHANGE PASSWORD'))
        ],
      ),
    );
  }
}
