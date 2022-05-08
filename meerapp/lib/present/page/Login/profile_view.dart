import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/page/Login/welcome_view.dart';

import '../../component/custom_btn.dart';
import '../../component/password_input.dart';
import '../../component/text_input.dart';

class ProfileCreate extends StatefulWidget {
  final String email;
  var userProfile;

  ProfileCreate({Key? key, required this.email}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileCreate> {
  final TextEditingController namecontroller = new TextEditingController();
  final TextEditingController birthcontroller = new TextEditingController();
  final TextEditingController phonecontroller = new TextEditingController();
  var ismade = false;
  var profileBloc;

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
              // child: BlocListener<ProfileBloc, ProfileState>(
              //   listener: (context, state) {
              //     if (state is ProfileSucessState) {
              //       Navigator.pushAndRemoveUntil(
              //         context,
              //         MaterialPageRoute(
              //           builder: (BuildContext context) => BlocProvider(
              //             create: (context) => SigninBloc(),
              //             child: Login(),
              //           ),
              //         ),
              //         (route) => false,
              //       );
              //     } else if (state is ProfileFailState) {
              //       showDialog<String>(
              //         context: context,
              //         builder: (BuildContext context) =>
              //             DialogWithCircleAbove(
              //           content:
              //               'Xin lỗi vì sự bất tiện này. Vui lòng thử lại sau',
              //           mode: ModeDialog.warning,
              //           title: 'Lỗi kết nối',
              //         ),
              //       );
              //     } else if (state is ProfileEmptyFeldState) {
              //       showDialog<String>(
              //         context: context,
              //         builder: (BuildContext context) =>
              //             DialogWithCircleAbove(
              //           content: 'Vui lòng nhập đầy đủ thông tin!',
              //           mode: ModeDialog.warning,
              //           title: 'Thông tin bị bỏ trống',
              //         ),
              //       );
              //     } else if (state is ProfileWrongFormatPhoneState) {
              //       showDialog<String>(
              //         context: context,
              //         builder: (BuildContext context) =>
              //             DialogWithCircleAbove(
              //           content:
              //               'Số điện thoại cần bắt đầu từ 0 và có 10 chữ số. Ví dụ: 0348774510',
              //           mode: ModeDialog.warning,
              //           title: 'Sai định dạng số điện thoại',
              //         ),
              //       );
              //     }
              //   },
              child: CustomButton(
                  onPressed: () => {
                        // profileBloc.add(ProfileSaveEvent(new UserProfile(
                        //     name: namecontroller.text.trim(),
                        //     avatarUri: null,
                        //     description: "",
                        //     birthDayString: birthcontroller.text.trim(),
                        //     gender:
                        //         this.ismade ? Genders.Male : Genders.Female,
                        //     email: widget.email,
                        //     phone: phonecontroller.text.trim())))
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeView(
                                email: '',
                              ),
                            ))
                      },
                  textInput: 'LƯU'),
            )
          ])),
    );
  }
}
