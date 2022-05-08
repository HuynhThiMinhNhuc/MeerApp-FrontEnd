import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/page/Login/send_link_resetpassword.dart';

import '../../component/custom_btn.dart';
import '../../component/text_input.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailcontroller = new TextEditingController();
  var forgotpassBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 30.h, 0, 20.h),
              child: Row(children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back)),
              ]),
            ),
            Text(
              'QUÊN MẬT KHẨU',
              style: kText32BoldMain,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.w, 0, 20.h, 10.w),
              child: Text(
                'Nhập email bạn đã đăng ký!',
                style: kText18RegularGreyNoteText,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30.w, 0, 0, 10.h),
                child: Text(
                  'Email',
                  style: kText15BoldGreyHintText,
                ),
              ),
            ]),
            Padding(
                padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
                child: TextInput(
                  icon: Icons.mail,
                  background: Colors.white,
                  boder: meerColorMain,
                  hint: '',
                  labeltext: '',
                  textEditingController: emailcontroller,
                  textInputType: TextInputType.text,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
                child: CustomButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SenLinkResetPassView(),
                          ));
                    },
                    textInput: 'GỬI MAIL'))
          ],
        ),
      ),
    );
  }
}
