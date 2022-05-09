import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:async/async.dart';
import 'package:meerapp/api/route/auth.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/present/component/my_alert_dialog_2.dart';
import 'package:meerapp/present/page/Login/register_view.dart';
import 'package:meerapp/singleton/user.dart';

import '../../../config/fontconfig.dart';
import '../../component/password_input.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final IconData eyeIcon = Icons.remove_red_eye_outlined;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  onSubmit() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showDialog("Thất bại", "Bạn vẫn chưa điền thông tin");
    }

    setState(() {
      isLoading = true;
    });
    final username = emailController.text.trim();
    final password = passwordController.text.trim();

    AuthAPI.login(username, password).then((response) {
      if (response.errorCode != null) {
        _showDialog("Thất bại", "Tên đăng nhập hoặc mật khẩu sai");
      } else {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(const SnackBar(content: Text("Xin chào")));
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  _showDialog(String title, String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => MyAlertDialog2(
        content: message,
        isTwoActions: false,
        title: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: AssetImage('asset/Login.png'),
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Đăng nhập vào tài khoản của bạn',
                  style: kText18RegularGreyNoteText,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.people,
                        color: meerColorMain,
                        size: 23.h,
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: meerColorRed.withOpacity(1), width: 1)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: meerColorRed.withOpacity(1), width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: meerColorMain.withOpacity(1), width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: meerColorMain.withOpacity(1), width: 1)),
                      hintText: 'Email',
                      hintStyle: kText15BoldGreyHintText,
                      fillColor: meerColorBackgroundButton
                          .withOpacity(0.2)
                          .withOpacity(0.2),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                  child: PassWordInput(
                    textInputType: TextInputType.text,
                    hint: 'Mật khẩu',
                    background: meerColorBackgroundButton,
                    boder: meerColorMain,
                    securitytext: true,
                    ispass: true,
                    textcontroller: passwordController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () => {},
                          icon: Icon(
                            Icons.check_circle,
                            color: meerColorMain,
                            size: 20.h,
                          ),
                          label: const Text(
                            'Nhớ tài khoản',
                            style: TextStyle(color: meerColorBlackIcon),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ));
                        },
                        child: Text(
                          'Quên mật khẩu?',
                          style: kText14BoldMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(30.w, 10.h, 30.w, 10.h),
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: onSubmit,
                            child: Text(
                              'Đăng nhập',
                              style: kText18BoldWhite,
                            ),
                            style: ElevatedButton.styleFrom(
                                alignment: Alignment.center,
                                primary: meerColorMain,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width, 60.h),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          )),
                SizedBox(
                  height: 10.h,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterView(),
                      ),
                    );
                  },
                  child: RichText(
                      text: TextSpan(
                          text: "Bạn chưa có tài khoản?",
                          style: kText15RegularGreyText,
                          children: <TextSpan>[
                        TextSpan(
                          text: ' Đăng ký!',
                          style: kText15MediumRed,
                        )
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
