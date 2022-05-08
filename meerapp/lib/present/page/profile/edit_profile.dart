import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';

import '../../../config/fontconfig.dart';
import '../../../constant/current_user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var editprofileBloc;
  var dropvalue = "Nữ";
  var _datetextcontroler;
  var backupUser;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final _imagetemporary = File(image.path);
    ;
  }

  @override
  void initState() {
    super.initState();
    dropvalue = currentUser['gender'] == '0' ? "Nữ" : "Nam";

    this._datetextcontroler =
        new TextEditingController(text: currentUser['birthday'].toString());
    backupUser = currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50), child: getappbar()),
        body: getbody());
  }

  Widget getappbar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppBar(
          iconTheme: const IconThemeData(color: meerColorGreyText),
          backgroundColor: meerColorBackground,
          centerTitle: true,
          shadowColor: meerColor25GreyNoteText,
          toolbarHeight: 40,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Lưu",
                style: kText15BoldMain,
              ),
            ),
          ],
          leading: TextButton(
            child: Text(
              "Hủy",
              style: kText15RegularBlack,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Chỉnh sửa",
            style: kText17BoldBlack,
          ),

          // BlocListener<EditprofileBloc, EditprofileState>(
          //   listener: (context, state) async {
          //     if (state is EditprofilePhoneWrongFormatFail) {
          //       showDialog(
          //           context: context,
          //           builder: (BuildContext buildercontext) =>
          //               DialogWithCircleAbove(
          //                   title: "Số điện thoại không hợp lệ",
          //                   content:
          //                       "Số điện thoại phải có 10 chữ số, bắt đầu bằng 0",
          //                   mode: ModeDialog.warning)
          //           // => MyAlertDialog(
          //           //       content:
          //           //           "Số điện thoại phải có 10 chữ số, bắt đầu bằng 0",
          //           //       pathImage:
          //           //           'asset/imagesample/ImageAlerDIalog/lostconnect.png',
          //           //       title: "Số điện thoại không hợp lệ",
          //           //     )
          //           );
          //     } else if (state is EditprofileSucess) {
          //       await showDialog(
          //           context: context,
          //           builder: (BuildContext buildercontext) {
          //             return DialogWithCircleAbove(
          //                 title: "Cập nhật hồ sơ thành công",
          //                 content:
          //                     "Vui lòng nhấn Đồng ý để quay về màn hình Hồ sơ của bạn",
          //                 mode: ModeDialog.anounce);
          //             //  MyAlertDialog(
          //             //   content:
          //             //       "Vui lòng nhấn Đồng ý để quay về màn hình Hồ sơ của bạn",
          //             //   pathImage:
          //             //       'asset/imagesample/ImageAlerDIalog/updateprofile.png',
          //             //   title: "Cập nhật hồ sơ thành công",
          //             // );
          //           });
          //       widget.onEditPro.call();
          //       Navigator.pop(context);

          //  TextButton(
          //     onPressed: close,
          //     child: Text(
          //       "Xong",
          //       style: kText20BoldMain,
          //     ),
          //   ),
        ),
      ],
    );
  }

  Widget getbody() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: 106.h,
                  height: 106.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: meerColorGradientActive),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.h),
                    child: Column(
                      children: <Widget>[
                        Stack(alignment: Alignment.center, children: <Widget>[
                          Container(
                            width: 100.h,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 3.w),
                              image: DecorationImage(
                                  image: AssetImage(
                                      currentUser['avatarUrl'].toString()),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                              bottom: 5.h,
                              right: 5.h,
                              child: Container(
                                alignment: Alignment.center,
                                width: 30.h,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  splashRadius: 20,
                                  color: meerColorMain,
                                  icon: Icon(Icons.camera_enhance_outlined),
                                  onPressed: pickImage,
                                ),
                              ))
                        ])
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  color: meerColor25GreyNoteText,
                ),
                Row(
                  children: [
                    Container(
                      width: 95.w,
                      child: Text(
                        "Họ tên",
                        style: kText14RegularBlack,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        style: kText15MediumBlack,
                        initialValue: currentUser['fullname'].toString(),
                        onChanged: (value) => {currentUser['fullname'] = value},
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            )),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 95.w,
                      child: Text(
                        "Ngày sinh",
                        style: kText14RegularBlack,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        style: kText15MediumBlack,
                        controller: _datetextcontroler,
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            ),
                            suffixIcon: Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor: meerColorMain,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.calendar_today,
                                    size: 20.w, color: meerColorMain),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(
                                        DateTime.now().year - 1,
                                        DateTime.now().month,
                                        DateTime.now().day),
                                    lastDate: DateTime(DateTime.now().year + 2),
                                  ).then((value) {
                                    if (value != null) {
                                      currentUser['birthDay'] =
                                          DateFormat('dd/MM/yyyy')
                                              .format(value);
                                      if (currentUser['birthday'] !=
                                          _datetextcontroler.text)
                                        setState(() {
                                          _datetextcontroler.text =
                                              currentUser['birthday']
                                                  .toString();
                                          print(
                                              "Date selected: $widget.currentUser.birthDayString");
                                        });
                                    }
                                  });
                                },
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 95.w,
                      child: Text(
                        "Giới tính",
                        style: kText14RegularBlack,
                      ),
                    ),
                    Flexible(
                      child: DropdownButton(
                        style: kText15MediumBlack,
                        value: dropvalue,
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropvalue = newValue!;
                            currentUser['gender'] =
                                newValue == 'Nữ' ? '0' : "1";
                          });
                        },
                        underline: Container(
                          height: 1,
                          color: meerColor25GreyNoteText,
                        ),
                        items: <String>['Nam', 'Nữ', 'Khác']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 95.w,
                      child: Text(
                        "Email",
                        style: kText14RegularBlack,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        enabled: false,
                        style: kText15MediumBlack,
                        initialValue: currentUser['email'].toString(),
                        onChanged: (value) => {currentUser['email'] = value},
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 95.w,
                      child: Text(
                        "Số điện thoại",
                        style: kText14RegularBlack,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        style: kText15MediumBlack,
                        initialValue: currentUser['phoneNumber'].toString(),
                        onChanged: (value) =>
                            {currentUser['phoneNumber'] = value},
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            )),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 95,
                      child: Text(
                        "Mô tả",
                        style: kText14RegularBlack,
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        style: kText15MediumBlack,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide:  BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:  BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:  BorderSide(
                                  color: meerColor25GreyNoteText, width: 1.0),
                            )),
                        initialValue: currentUser['description'].toString(),
                        onChanged: (value) =>
                            {currentUser['description'] = value},
                      ),
                    ),
                  ],
                ),
               
                Padding(
                  padding: EdgeInsets.only(top: 7.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Đổi mật khẩu", style: kText15BoldMain),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatusSwitch extends StatefulWidget {
  final Function(bool value)? onChanged;
  final bool firstState;
  StatusSwitch({required this.firstState, this.onChanged, Key? key})
      : super(key: key);
  @override
  _StatusSwitchState createState() =>
      new _StatusSwitchState(status: firstState);
}

class _StatusSwitchState extends State<StatusSwitch> {
  bool status = false;
  _StatusSwitchState({this.status = false});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.only(top: 10.h),
      title: Text(
        'Chế độ sẵn sàng',
        style: kText15BoldMain,
      ),
      value: status,
      onChanged: (value) async {
        widget.onChanged?.call(value);

        setState(() {
          status = !status;
        });
      },
    );
  }
}
