import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/api/route/auth.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/component/dialog_with_circle_above.dart';
import 'package:meerapp/present/page/Login/profile_view.dart';
import 'package:meerapp/present/page/profile/profilepage.dart';

import '../../component/custom_btn.dart';
import '../../component/password_input.dart';
import '../../component/text_input.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      new TextEditingController();
  final TextEditingController emailcontroller = new TextEditingController();

  onSubmit(BuildContext context) async {
    final email = emailcontroller.text.trim();
    if (emailcontroller.text.isEmpty ||
        passwordcontroller.text.isEmpty ||
        emailcontroller.text.isEmpty) {
      _showDialog("Thất bại", "Vui lòng điền đầy đủ thông tin!");
      return;
    }

    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      _showDialog("Thất bại", "Mật khẩu xác nhận chưa chính xác!");
      return;
    }

    final res = await AuthAPI.checkExistUsername(email);
    if (res.errorCode != null) {
      _showDialog("Thất bại", "Đã xảy ra lỗi. Vui lòng thử lại!");
      return;
    }
    if (res.data as bool) {
      _showDialog("Thất bại", "Email đã được sử dụng.");
      return;
    }

    // OK
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileCreate(
            email: email,
            tag: {
              "email": email,
              "password": passwordcontroller.text.trim(),
            },
          ),
        ));
  }

  _showDialog(String title, String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => DialogWithCircleAbove(
        content: message,
        mode: ModeDialog.warning,
        title: title,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 30.h, 0, 30.h),
                child: Row(children: [
                  IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: Icon(Icons.arrow_back)),
                ]),
              ),
              Text(
                'Đăng ký',
                style: kText40BoldMain,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'Nhập thông tin để tạo tài khoản mới!',
                style: kText18RegularGreyNoteText,
              ),
              SizedBox(
                height: 60.h,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                  child: TextInput(
                    icon: Icons.people,
                    background: meerColorBackgroundButton.withOpacity(0.2),
                    boder: meerColorMain.withOpacity(0.1),
                    hint: 'Email',
                    labeltext: '',
                    textEditingController: emailcontroller,
                    textInputType: TextInputType.emailAddress,
                  )),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                child: PassWordInput(
                  hint: 'Mật khẩu',
                  background: meerColorBackgroundButton,
                  boder: meerColorMain,
                  securitytext: false,
                  ispass: true,
                  textcontroller: passwordcontroller,
                  textInputType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                child: PassWordInput(
                  hint: 'Xác nhận mật khẩu',
                  background: meerColorBackgroundButton,
                  boder: meerColorMain,
                  securitytext: true,
                  ispass: true,
                  textcontroller: confirmpasswordcontroller,
                  textInputType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'Bằng cách đăng ký, bạn đã đồng ý với',
                        style: TextStyle(
                            color: meerColorBlackIcon, fontSize: 14.sp),
                      ),
                      TextSpan(
                          text: ' điều khoản sử dụng',
                          style: kText14BoldMainColor),
                      TextSpan(
                        text: ' và',
                        style: TextStyle(
                            color: meerColorBlackIcon, fontSize: 14.sp),
                      ),
                      TextSpan(
                        text: ' quyền riêng tư.',
                        style: kText14BoldMainColor,
                      ),
                    ])),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                child: CustomButton(
                  onPressed: () => onSubmit(context),
                  textInput: 'ĐĂNG KÝ',
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Bạn đã có tài khoản?",
                    style: kText15RegularGreyText,
                  ),
                  TextSpan(text: " Đăng nhập!", style: kText15MediumRed)
                ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
