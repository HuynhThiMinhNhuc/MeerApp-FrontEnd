import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/present/page/Login/login_view.dart';
import 'package:meerapp/present/page/Login/profile_view.dart';

import '../../../config/fontconfig.dart';
import '../../component/custom_btn.dart';
import '../../component/password_input.dart';
import '../../component/text_input.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      new TextEditingController();
  final TextEditingController emailcontroller = new TextEditingController();

  var forgotpassBloc;
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
                'Đổi mật khẩu',
                style: kText40BoldMain,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'Tạo mật khẩu mới cho tài khoản của bạn!',
                style: kText18RegularGreyNoteText,
              ),
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                child: PassWordInput(
                  hint: 'Mật khẩu cũ',
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
                  hint: 'Mật khẩu mới',
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
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                // child: BlocListener<SignupBloc, SignupState>(
                //   listener: (context, state) {
                //     if (state is SignupSussesState) {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => BlocProvider(
                //                   create: (context) => VerifycodeBloc(),
                //                   child: VerificationOtpView(
                //                     email: this.emailcontroller.text.trim(),
                //                     ischangepass: false,
                //                   ))));
                //     } else if (state is SignupFailEmailFomatState) {
                //       showDialog<String>(
                //         context: context,
                //         builder: (BuildContext context) =>
                //             DialogWithCircleAbove(
                //           content: 'Vui lòng nhập email hợp lệ',
                //           mode: ModeDialog.warning,
                //           title: 'Email không hợp lệ',
                //         ),
                //       );
                //     } else if (state is SignupFailMutilAccountState) {
                //       showDialog<String>(
                //         context: context,
                //         builder: (BuildContext context) =>
                //             DialogWithCircleAbove(
                //           content:
                //               'Vui lòng nhập địa chỉ email chưa từng tạo tài khoản bao giờ',
                //           mode: ModeDialog.warning,
                //           title: 'Email đã được sử dụng',
                //         ),
                //       );
                //     } else if (state is SignupFailPassweakState) {
                //       showDialog<String>(
                //         context: context,
                //         builder: (BuildContext context) =>
                //             DialogWithCircleAbove(
                //           content: 'Mật khẩu phải chứa ít nhất 6 kí tự',
                //           mode: ModeDialog.warning,
                //           title: 'Mật khẩu không hợp lệ',
                //         ),
                //       );
                //     } else if (state is SignupIncorrectPassConfirmState) {
                //       showDialog<String>(
                //         context: context,
                //         builder: (BuildContext context) =>
                //             DialogWithCircleAbove(
                //           content:
                //               'Mật khẩu xác nhận phải trùng với mật khẩu vừa đặt',
                //           mode: ModeDialog.warning,
                //           title: 'Mật khẩu không trùng khớp',
                //         ),
                //       );
                //     } else if (state is SignupEmptyFeldmState) {
                //       showDialog<String>(
                //         context: context,
                //         builder: (BuildContext context) =>
                //             DialogWithCircleAbove(
                //           content: 'Vui lòng điền đầy đủ thông tin',
                //           mode: ModeDialog.warning,
                //           title: 'Không được để trống',
                //         ),
                //       );
                //     } else if (state is SignupNoReasonState) {
                //       showDialog<String>(
                //         context: context,
                //         builder: (BuildContext context) =>
                //             DialogWithCircleAbove(
                //           content:
                //               'Hệ thống đang gặp lỗi, chúng tôi sẽ cố gắng sửa lỗi sớm. Vui lòng thử lại sau',
                //           mode: ModeDialog.warning,
                //           title: 'Lỗi không xác định',
                //         ),
                //       );
                //     }
                //   },
                child: CustomButton(
                  onPressed: () => {
                    // signupbloc.add(SignupWithEmailAndPassEvent(
                    //     emailcontroller.text.trim(),
                    //     passwordcontroller.text.trim(),
                    //     confirmpasswordcontroller.text.trim()))
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(
                            
                          ),
                        )),
                  },
                  textInput: 'ĐỔI MẬT KHẨU',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
