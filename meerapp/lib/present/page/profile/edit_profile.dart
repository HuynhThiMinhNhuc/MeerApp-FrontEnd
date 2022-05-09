import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/api/route/user.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/present/page/profile/Wrapper/MyImage.dart';
import 'package:meerapp/singleton/user.dart';

import '../../../config/fontconfig.dart';
import '../../../constant/current_user.dart';

class EditProfileData {
  String fullname;
  String birthday;
  int gender;
  String email;
  String phone;
  String description;
  String? avatarImageURI;
  EditProfileData({
    this.fullname = "",
    this.birthday = "",
    this.gender = 0,
    this.email = "",
    this.phone = "",
    this.description = "",
    this.avatarImageURI,
  });
}

class EditProfile extends StatefulWidget {
  List<String> genderList = ["Nữ", "Nam"];

  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String fullname = "";
  DateTime birthday = DateTime.now();
  int gender = 0;
  String email = "";
  String phone = "";
  String description = "";
  ImageProvider? sampleImage1;
  File? selectedImage1;

  var editprofileBloc;

  void onSubmit() async {
    final data = {
      "fullname": fullname,
      "birthday": birthday.toUtc().toIso8601String(),
      "gender": gender,
      "email": email,
      "phone": phone,
      "description": description,
    };
    if (selectedImage1 != null) {
      data["avatarImage"] = await MultipartFile.fromFile(selectedImage1!.path);
    }
    final r = await UserAPI.updateUserInfo(FormData.fromMap(data));
    if (r.errorCode == null) {
      // OK
      UserSingleton.instance.refreshUserInfo();
      Navigator.pop(context);
    } else {
      // Failed
      showDialog(
        context: context,
        builder: (c) => Text(
          r.errorMessage!,
        ),
      );
    }
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      final f = File(image.path);
      sampleImage1 = FileImage(f);
      selectedImage1 = f;
    });
  }

  @override
  void initState() {
    super.initState();

    sampleImage1 = const AssetImage("asset/avt1.jpg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: getappbar(),
      ),
      body: FutureBuilder<MyResponse>(
        future: UserAPI.getCurrentUserInfo(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column();
          }

          // Set old data as init value
          final oldData = snapshot.data!.data;
          fullname = oldData["fullname"];
          birthday = DateTime.parse(oldData["birthday"]);
          gender = oldData["gender"];
          email = oldData["email"];
          phone = oldData["phone"];
          description = oldData["description"];
          if (oldData["avatarImageURI"] != null) {
            sampleImage1 = MyImage(oldData["avatarImageURI"]);
          }

          return getbody();
        },
      ),
    );
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
              onPressed: onSubmit,
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
        ),
      ],
    );
  }

  Widget buildBirthdayText(DateTime birthday) {
    return TextFormField(
      style: kText15MediumBlack,
      controller: TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(birthday)),
      decoration: InputDecoration(
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: meerColor25GreyNoteText, width: 1.0),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: meerColor25GreyNoteText, width: 1.0),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: meerColor25GreyNoteText, width: 1.0),
          ),
          suffixIcon: Theme(
            data: Theme.of(context).copyWith(
              primaryColor: meerColorMain,
            ),
            child: IconButton(
              icon:
                  Icon(Icons.calendar_today, size: 20.w, color: meerColorMain),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 1,
                      DateTime.now().month, DateTime.now().day),
                  lastDate: DateTime(DateTime.now().year + 2),
                ).then((value) {
                  if (value != null && value != birthday) {
                    setState(() {
                      birthday = value;
                    });
                  }
                });
              },
            ),
          )),
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
                                  image: sampleImage1!, fit: BoxFit.cover),
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
                        initialValue: fullname.toString(),
                        onChanged: (value) => setState(
                          () {
                            fullname = value;
                          },
                        ),
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
                      child: buildBirthdayText(birthday),
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
                        value: widget.genderList[gender],
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        onChanged: (String? newValue) {
                          setState(() {
                            gender = newValue == 'Nữ' ? 0 : 1;
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
                        initialValue: email.toString(),
                        onChanged: (value) => setState(() {
                          email = value;
                        }),
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
                        initialValue: phone,
                        onChanged: (value) => setState(() {
                          phone = value;
                        }),
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
                        initialValue: description,
                        onChanged: (value) => setState(() {
                          description = value;
                        }),
                      ),
                    ),
                  ],
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
