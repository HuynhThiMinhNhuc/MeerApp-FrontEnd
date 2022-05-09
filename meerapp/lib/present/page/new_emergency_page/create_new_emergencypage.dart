import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/component/image_card.dart';

class CreateNewEmergencyPage extends StatefulWidget {
  final bool isCreate;
  const CreateNewEmergencyPage({Key? key, required this.isCreate}) : super(key: key);

  @override
  State<CreateNewEmergencyPage> createState() => _CreateNewEmergencyPageState();
}

late TextEditingController _nameTextController;
late TextEditingController _locationTextController;
late TextEditingController _descriptionTextController;

class _CreateNewEmergencyPageState extends State<CreateNewEmergencyPage> {
  bool isSwitched = false;
  
  bool isValidation() {
    if (_nameTextController.text.trim().isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Lỗi'),
          content: const Text('Vui lòng nhập tên sự kiện'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Lưu'),
            ),
          ],
        ),
      );
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _locationTextController = TextEditingController();
    _descriptionTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _locationTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: meerColorBackground,
      appBar: getAppBar(),
      body: getBody(context),
    );
  }

  Padding getBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: meerColorWhite,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.h,),
                   Padding(
                     padding: EdgeInsets.only(left: 10.w),
                     child: Text(
                          "Địa điểm",
                          style: kText17BoldBlack,
                        ),
                   ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10.w),
                      Text(
                        "Sử dụng vị trí hiện tại của bạn ",
                        style: kText15BoldGreyHintText,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                  print(isSwitched);
                                });
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 130.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                                image: AssetImage("asset/location.png"),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                          child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.start,
                                style: kText15RegularBlack.copyWith(
                                    color: meerColorWhite),
                                controller: _locationTextController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.angleRight,
                                color: meerColorBlack,
                              ),
                              onPressed: () => {
                                //TODO: navigate to map to get location
                              },
                            )
                          ],
                        ),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(92, 0, 0, 0),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20))),
                      ))
                    ],
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: meerColorWhite,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(2.w, 10.h, 0, 10.h),
                      child: Text(
                        "  Hình ảnh",
                        style: kText17BoldBlack,
                      ),
                    ),
                    Row(
                      children: [
                        ImageCard(
                          hintTitle: "+ Ảnh bìa",
                          onImageChanged: (file) {
                            // backgroundImage = file;
                          },
                        ),
                        ImageCard(
                          hintTitle: "+ Ảnh đại diện",
                          onImageChanged: (file) {
                            // avatarImage = file;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                color: meerColorWhite,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    TextFormField(
                      style: kText17BoldBlack,
                      controller: _nameTextController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Thêm tiêu đề tại đây"),
                    ),
                    TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _descriptionTextController,
                        minLines: 15,
                        maxLines: 15,
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular.ttf',
                            fontSize: 15.sp,
                            color: Colors.grey[600]),
                        decoration: const InputDecoration(
                            hintText: "Viết nội dung ở đây...",
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: meerColorBlackIcon, //change your color here
      ),
      centerTitle: true,
      backgroundColor: meerColorBackground,
      title: Text(
        widget.isCreate? "Tạo tin khẩn cấp" : "Chỉnh sửa",
        style: ktext18BoldBlack,
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (!isValidation()) return;
          },
          child: Text(
            widget.isCreate?"Đăng":"Lưu",
            style: kText18BoldMain,
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChoiceField extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function()? onPress;
  final TextEditingController? controller;
  const ChoiceField(
      {Key? key,
      required this.title,
      required this.icon,
      this.onPress,
      this.controller})
      : super(key: key);

  @override
  State<ChoiceField> createState() => _ChoiceFieldState();
}

class _ChoiceFieldState extends State<ChoiceField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            widget.title,
            style: kText15BoldBlack,
          ),
          SizedBox(
            width: 10.w,
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.end,
                    style: kText15RegularMain,
                    controller: widget.controller,
                    decoration: new InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                    iconSize: 20.w,
                    padding: EdgeInsets.all(1.0),
                    onPressed: widget.onPress,
                    icon: Icon(
                      widget.icon,
                      color: meerColorMain,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
