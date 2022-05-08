import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/fontconfig.dart';

import '../../component/custom_btn.dart';
import '../../component/otp_textfield.dart';

class VerificationOtpView extends StatefulWidget {
  final bool ischangepass;
  final String email;
  final TextEditingController onecontrolller = new TextEditingController();
  final TextEditingController twocontrolller = new TextEditingController();
  final TextEditingController threecontrolller = new TextEditingController();
  final TextEditingController fourcontrolller = new TextEditingController();
  final TextEditingController fivecontrolller = new TextEditingController();
  final TextEditingController sixcontrolller = new TextEditingController();
  VerificationOtpView(
      {Key? key, required this.email, required this.ischangepass})
      : super(key: key);
  @override
  _VerificationOtpViewState createState() => _VerificationOtpViewState();
}

class _VerificationOtpViewState extends State<VerificationOtpView> {
  var verifyCodeBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 30.h, 0, 50.h),
                child: Row(children: [
                  IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: Icon(Icons.arrow_back)),
                ]),
              ),
              Text(
                'Xác nhận mã',
                style: kText40BoldMain,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Nhập mã OTP đã được gửi đến',
                style: kText18RegularGreyNoteText,
              ),
              Text(widget.email, style: kText28BoldGreyNoteText),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 60.h, 10.w, 10.h),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      OtpTextField(
                        next: true,
                        textEditingController: widget.onecontrolller,
                      ),
                      OtpTextField(
                        next: true,
                        textEditingController: widget.twocontrolller,
                      ),
                      OtpTextField(
                        next: true,
                        textEditingController: widget.threecontrolller,
                      ),
                      OtpTextField(
                        next: false,
                        textEditingController: widget.fourcontrolller,
                      ),
                      OtpTextField(
                        next: false,
                        textEditingController: widget.fivecontrolller,
                      ),
                      OtpTextField(
                        next: false,
                        textEditingController: widget.sixcontrolller,
                      )
                    ]),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextButton(
                onPressed: () {
               //   verifyCodeBloc.add(VerifycodeInitEvent(widget.email));
                },
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Chưa nhận được OTP?",
                        style: kText16RegularGreyText),
                    TextSpan(
                        text: " GỬI LẠI OTP (112)", style: kText17RegularRed)
                  ]),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 60.h, 30.w, 10.h),
                  // child: BlocListener<VerifycodeBloc, VerifycodeState>(
                  //   listener: (context, state) {
                  //     if (state is VerifycodeSucessState) {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => !widget.ischangepass
                  //                   ? WelcomeView(email: widget.email)
                  //                   : BlocProvider(
                  //                       create: (context) =>
                  //                           ChangepassforgotBloc(),
                  //                       child: ChangePassforgotprofile(
                  //                           email: widget.email),
                  //                     )));
                  //     } else if (state is VerifycodeFailState) {
                  //       showDialog<String>(
                  //         context: context,
                  //         builder: (BuildContext context) =>
                  //             DialogWithCircleAbove(
                  //           content: '',
                  //           mode: ModeDialog.warning,
                  //           title: 'Mã OTP sai',
                  //         ),
                  //       );
                  //     }
                  //   },
                    child: CustomButton(
                        onPressed: () => {
                              // this.verifyCodeBloc.add(VerifycodeVerifyEvent(
                              //     widget.onecontrolller.text +
                              //         widget.twocontrolller.text +
                              //         widget.threecontrolller.text +
                              //         widget.fourcontrolller.text +
                              //         widget.fivecontrolller.text +
                              //         widget.sixcontrolller.text,
                              //     widget.email))
                            },
                        textInput: 'XÁC NHẬN'),
              )
            ]
            
          ),
        ),
      ),
    );
  }
}
