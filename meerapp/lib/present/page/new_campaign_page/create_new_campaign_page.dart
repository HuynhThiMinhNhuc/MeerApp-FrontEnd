import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/constant/user.dart';
import 'package:meerapp/present/component/image_card.dart';

class CreateNewCampaignPage extends StatefulWidget {
  const CreateNewCampaignPage({Key? key}) : super(key: key);

  static const List<String> _userName = <String>[
    'Huynh Nhuc',
    'Nguyen Anh',
    'Phạm võ',
  ];

  @override
  State<CreateNewCampaignPage> createState() => _CreateNewCampaignPageState();
}

class _CreateNewCampaignPageState extends State<CreateNewCampaignPage> {
  late TextEditingController _nameTextController;

  late TextEditingController _dateTextController;

  late TextEditingController _timeTextController;

  late TextEditingController _locationTextController;

  late TextEditingController _descriptionTextController;

  late TextEditingController _requireTextController;
  bool isSwitched = false;
  late File avatarImage;
  late File backgroundImage;
  DateTime? startDate;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _dateTextController = TextEditingController(text: "Chọn ngày tổ chức");
    _locationTextController = TextEditingController();
    _descriptionTextController = TextEditingController();
    _requireTextController = TextEditingController();
    _timeTextController =TextEditingController(text: "Chọn giờ tổ chức");
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _dateTextController.dispose();
    _locationTextController.dispose();
    _descriptionTextController.dispose();
    _requireTextController.dispose();
    _timeTextController.dispose();
    super.dispose();
  }

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
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: meerColorWhite,
                        borderRadius: BorderRadius.all(Radius.circular(10.w))),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(15.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Thời gian, địa điểm ",
                              style: kText15BoldBlack,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.locationDot,
                                  color: meerColorRed,
                                  size: 20.w,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "Địa điểm",
                                  style: kText13BoldBlack,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Text(
                                "Tên địa điểm",
                                style: kText15RegularGreyNotetext,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: TextFormField(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10.w),
                                Text(
                                  "Sử dụng vị trí hiện tại của bạn ",
                                  style: kText15RegularBlack,
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
                                        activeTrackColor:
                                            Colors.lightGreenAccent,
                                        activeColor: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image:
                                              AssetImage("asset/location.png"),
                                          fit: BoxFit.cover)),
                                ),
                                Positioned(
                                    child: Container(
                                  height: 35.h,
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
                                          style: kText13RegularBlack.copyWith(
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
                                          size: 20,
                                        ),
                                        onPressed: () => {
                                          //TODO: navigate to map to get location
                                        },
                                      )
                                    ],
                                  ),
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(92, 0, 0, 0),
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20))),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.calendar,
                                  color: meerColorMain,
                                  size: 20.w,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "Ngày",
                                  style: kText13BoldBlack,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: InputDecorator(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(7.w, 0, 0, 0),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: TextFormField(
                                                readOnly: true,
                                                textAlign: TextAlign.start,
                                                style: kText15RegularBlack,
                                                controller: _dateTextController,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none),
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                  FontAwesomeIcons.caretDown),
                                              onPressed: () => {
                                                showDatePicker(
                                                  cancelText: "Huỷ",
                                                  confirmText: "Lưu",
                                                  locale: Locale("vi","VN"),
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(
                                                      DateTime.now().year - 1,
                                                      DateTime.now().month,
                                                      DateTime.now().day),
                                                  lastDate: DateTime(
                                                      DateTime.now().year + 2),
                                                ).then((value) {
                                                  startDate = value;

                                                  if (startDate != null &&
                                                      startDate != "") {
                                                    final formattedDate =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(startDate!);
                                                    if (formattedDate !=
                                                        _dateTextController
                                                            .text) {
                                                      setState(() {
                                                        _dateTextController
                                                                .text =
                                                            formattedDate;
                                                        print(
                                                            "Date selected: $formattedDate");
                                                      });
                                                    }
                                                  } else {
                                                    setState(() {
                                                      _dateTextController.text =
                                                          '';
                                                    });
                                                  }
                                                })
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.clock,
                                  color: meerColorMain,
                                  size: 20.w,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "Giờ",
                                  style: kText13BoldBlack,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: InputDecorator(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(7.w, 0, 0, 0),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: TextFormField(
                                                readOnly: true,
                                                textAlign: TextAlign.start,
                                                style: kText15RegularBlack,
                                                controller: _timeTextController,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none),
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                  FontAwesomeIcons.caretDown),
                                              onPressed: () => {
                                                 showTimePicker(
                                                     hourLabelText: "Giờ",
                                                      minuteLabelText: "Phút",
                                                      initialTime: TimeOfDay(
                                                        hour: DateTime.now().hour,
                                                        minute: DateTime.now().minute,
                                                      ),
                                                      initialEntryMode: TimePickerEntryMode.input,
                                                      cancelText: "Hủy",
                                                      confirmText: "Lưu",
                                                      onEntryModeChanged: (time) => {
                                                        //Todo: save data time
                                                      },
                                                  context: context,

                                                  )
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                 
                ])),
            SizedBox(
              height: 10.h,
            ),
            Container(
              decoration: BoxDecoration(
                  color: meerColorWhite,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Người tham gia",
                          style: kText15BoldBlack,
                        ),
                        TextButton(
                            onPressed: () {
                              showDialogAddCampaignUser(context);
                            },
                            child: Text(
                              "Thêm",
                              style: kText15BoldMain,
                            ))
                      ],
                    ),
                    Wrap(
                      spacing: 8.0.h, // gap between adjacent chips
                      children: List.generate(
                        users.length,
                        (index) => Padding(
                          padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
                          child: Chip(
                            backgroundColor: meerColorMain,
                            deleteIcon: const Icon(
                              FontAwesomeIcons.circleXmark,
                              color: meerColorWhite,
                            ),
                            label: Text(
                              users[index]["fullName"],
                              style: TextStyle(
                                  fontFamily: 'Roboto_Regular',
                                  fontSize: 13.sp,
                                  color: meerColorWhite),
                            ),
                            onDeleted: () {},
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
                            backgroundImage = file;
                          },
                        ),
                        ImageCard(
                          hintTitle: "+ Ảnh đại diện",
                          onImageChanged: (file) {
                            avatarImage = file;
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

  Future<String?> showDialogAddCampaignUser(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Thêm người tham gia',
          style: kText15BoldBlack,
        ),
        content: Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return CreateNewCampaignPage._userName.where((String option) {
              return option.contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            debugPrint('You just selected $selection');
          },
        ),
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
  }

  AppBar getAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: meerColorBlackIcon, //change your color here
      ),
      centerTitle: true,
      backgroundColor: meerColorBackground,
      title: Text(
        "Tạo chiến dịch",
        style: ktext18BoldBlack,
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (!isValidation()) return;
          },
          child: Text(
            "Đăng",
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
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 10.w,
          ),
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
                    style: kText15RegularBlack,
                    controller: widget.controller,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                    iconSize: 20.w,
                    padding: const EdgeInsets.all(1.0),
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
      onTap: () => {widget.onPress},
    );
  }
}
