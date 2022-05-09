import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meerapp/api/route/auth.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/main.dart';
import 'package:meerapp/present/component/dialog_with_circle_above.dart';
import 'package:meerapp/present/component/my_alert_dialog_2.dart';
import 'package:meerapp/present/page/Login/welcome_view.dart';

import '../../component/custom_btn.dart';
import '../../component/password_input.dart';
import '../../component/text_input.dart';

class ProfileCreate extends StatefulWidget {
  final String email;
  dynamic tag;

  ProfileCreate({Key? key, required this.email, this.tag}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileCreate> {
  final TextEditingController namecontroller = new TextEditingController();
  final TextEditingController birthcontroller = new TextEditingController();
  final TextEditingController phonecontroller = new TextEditingController();
  var ismade = false;

  @override
  void initState() {
    super.initState();
  }

  onSubmit(BuildContext context) {
    if (namecontroller.text.isEmpty ||
        birthcontroller.text.isEmpty ||
        phonecontroller.text.isEmpty) {
      _showDialog("Thiếu thông tin", "Mời bạn vui lòng điền đầy đủ thông tin");
      return;
    }
    var account = {
      "username": widget.tag["email"],
      "password": widget.tag["password"],
    };
    var userInfo = {
      "fullname": namecontroller.text.trim(),
      "address": "",
      "email": widget.tag["email"],
      "phone": phonecontroller.text.trim(),
      "description": "",
      "gender": ismade ? 1 : 0,
      "birthday": DateFormat("dd/MM/yyyy")
          .parse(birthcontroller.text.trim())
          .toUtc()
          .toIso8601String(),
    };

    AuthAPI.signup({"account": account, "userInfo": userInfo}).then((res) {
      if (res.errorCode != null) {
        _showDialog("Lỗi", "Đã xảy ra lỗi. Vui lòng thử lại");
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => DialogWithCircleAbove(
            content: "Hãy kiểm tra email để hoàn tất quá trình đăng ký",
            mode: ModeDialog.anounce,
            title: "Thành công",
          ),
        ).then((value) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Center(
                child: MeerApp(),
              ),
            ),
            (route) => false,
          );
        });
      }
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
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 30.h, 0, 0),
              child: Row(children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back)),
              ]),
            ),
            Text(
              'Hồ sơ',
              style: kText32BoldMain,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Điền thông tin cá nhân của bạn!',
              style: kText18RegularGreyNoteText,
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 7),
                child: Text('Họ và tên', style: kText16BoldMain),
              ),
            ]),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextInput(
                  icon: FontAwesomeIcons.pen,
                  background: Colors.white,
                  boder: meerColorMain,
                  hint: '',
                  labeltext: '',
                  textEditingController: namecontroller,
                  textInputType: TextInputType.text,
                )),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  'Ngày sinh',
                  style: kText16BoldMain,
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: PassWordInput(
                  hint: 'dd/mm/yyy',
                  background: Colors.white,
                  boder: meerColorMain,
                  securitytext: false,
                  ispass: false,
                  textcontroller: birthcontroller,
                  textInputType: TextInputType.text),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  'Số điện thoại',
                  style: kText16BoldMain,
                ),
              ),
            ]),
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextInput(
                  icon: Icons.phone,
                  background: Colors.white,
                  boder: meerColorMain,
                  hint: '',
                  labeltext: '',
                  textEditingController: phonecontroller,
                  textInputType: TextInputType.phone,
                )),
            SizedBox(
              height: 20.h,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  'Giới tính',
                  style: kText16BoldMain,
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 50.h,
                      color: meerColorBackgroundButton.withOpacity(0.2),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      child: TextButton.icon(
                          onPressed: () => {
                                setState(() => {this.ismade = true})
                              },
                          icon: Icon(
                            Icons.male,
                            color: !ismade ? meerColorMain : Colors.white,
                            size: 30.h,
                          ),
                          label: Text(
                            'Nữ',
                            style: kText15BoldMain.copyWith(
                              color: !ismade ? meerColorMain : Colors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: ismade
                                ? MaterialStateProperty.all<Color>(
                                    meerColorMain)
                                : MaterialStateProperty.all<Color>(
                                    meerColorMain.withOpacity(0.2)),
                          )),
                    ),
                    Container(
                      color: meerColorBackgroundButton.withOpacity(0.2),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      height: 50.h,
                      child: TextButton.icon(
                          onPressed: () => {
                                setState(() => {ismade = false})
                              },
                          icon: Icon(
                            Icons.female,
                            color: !ismade ? Colors.white : meerColorMain,
                            size: 30.h,
                          ),
                          label: Text(
                            'Nam',
                            style: kText15BoldMain.copyWith(
                              color: !ismade ? Colors.white : meerColorMain,
                            ),
                          ),
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: !ismade
                                ? MaterialStateProperty.all<Color>(
                                    meerColorMain)
                                : MaterialStateProperty.all<Color>(
                                    meerColorMain.withOpacity(0.2)),
                          )),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: CustomButton(
                  onPressed: () => onSubmit(context), textInput: 'LƯU'),
            )
          ])),
    );
  }
}
