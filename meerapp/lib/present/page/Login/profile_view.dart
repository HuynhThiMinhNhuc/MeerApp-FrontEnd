import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';

import '../../component/custom_btn.dart';
import '../../component/password_input.dart';
import '../../component/text_input.dart';

class Profile extends StatefulWidget {
  final String email;
  var userProfile;

  Profile({Key? key, required this.email}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              padding: EdgeInsets.fromLTRB(20, 50, 0, 20),
              child: Row(children: [
                IconButton(onPressed: () => {}, icon: Icon(Icons.arrow_back)),
              ]),
            ),
            const Text(
              'Hồ sơ',
              style: TextStyle(
                  color: meerColorMain,
                  fontSize: 38,
                  fontFamily: 'Roboto-Regular.ttf',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.h,
            ),
            const Text(
              'Bổ sung thông tin của bạn',
              style: TextStyle(
                  color: meerColorGreyNoteText,
                  fontSize: 20,
                  fontFamily: 'Roboto_Regular'),
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                    child: Text(
                      'Họ và tên',
                      style: TextStyle(
                          color: meerColorMain,
                          fontFamily: 'Roboto-Regular.tff',
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
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
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                    child: Text(
                      'Ngày sinh',
                      style: TextStyle(
                          color: meerColorMain,
                          fontFamily: 'Roboto-Regular.tff',
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
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
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                    child: Text(
                      'Số điện thoại',
                      style: TextStyle(
                          color: meerColorMain,
                          fontFamily: 'Roboto-Regular.tff',
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
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
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                    child: Text(
                      'Giới tính',
                      style: TextStyle(
                          color: meerColorMain,
                          fontFamily: 'Roboto-Regular.tff',
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      color: meerColorBackgroundButton.withOpacity(0.2),
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      child: TextButton.icon(
                          onPressed: () => {
                                setState(() => {this.ismade = true})
                              },
                          icon: Icon(
                            Icons.male,
                            color: !ismade ? meerColorMain : Colors.white,
                            size: 40,
                          ),
                          label: Text(
                            'Phụ nữ',
                            style: TextStyle(
                                color: !ismade ? meerColorMain : Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 15),
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
                      child: TextButton.icon(
                          onPressed: () => {
                                setState(() => {ismade = false})
                              },
                          icon: Icon(
                            Icons.female,
                            color: !ismade ? Colors.white : meerColorMain,
                            size: 40,
                          ),
                          label: Text(
                            'Đàn ông',
                            style: TextStyle(
                                color: !ismade ? Colors.white : meerColorMain,
                                fontFamily: 'Roboto',
                                fontSize: 15),
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
                      },
                  textInput: 'LƯU'),
            )
          ])),
    );
  }
}
