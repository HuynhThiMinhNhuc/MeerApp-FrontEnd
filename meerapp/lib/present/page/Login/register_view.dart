import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';

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

  var signupbloc;

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
                'Tạo tài khoản mới',
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
                  },
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
                      style: kText16RegularGreyText.copyWith(fontSize: 15.sp)),
                  TextSpan(text: " Đăng nhập!", style: kText17RegularRed)
                ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
