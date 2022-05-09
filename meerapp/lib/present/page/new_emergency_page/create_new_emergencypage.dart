import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/constant.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/controllers/controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/models/post.dart';
import 'package:meerapp/models/user.dart';
import 'package:meerapp/present/component/image_card.dart';
import 'package:meerapp/present/component/my_alert_dialog_3.dart';
import 'package:meerapp/present/component/open_map.dart';

class CreateNewEmergencyPage extends StatefulWidget {
  get isAddData => initData == null;
  final EmergencyPost? initData;
  final PostController _postController = sl.get<PostController>();
  CreateNewEmergencyPage({Key? key, this.initData}) : super(key: key);

  @override
  State<CreateNewEmergencyPage> createState() => _CreateNewEmergencyPageState();
}

late TextEditingController _nameTextController;
late TextEditingController _locationTextController;
late TextEditingController _descriptionTextController;

class _CreateNewEmergencyPageState extends State<CreateNewEmergencyPage> {
  bool isSwitched = false;
  LatLng? location;
  String? avatarImagePath;
  String? backgroundImagePath;

  bool isValidation() {
    void _showAlertDialog(String text) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => MyAlertDialog3(
          title: 'Lỗi',
          content: text,
        ),
      );
    }

    if (_nameTextController.text.trim().isEmpty) {
      _showAlertDialog('Vui lòng nhập tên sự kiện');
      return false;
    }
    if (_locationTextController.text.trim().isEmpty) {
      _showAlertDialog('Vui lòng nhập địa chỉ nơi diễn ra sự kiện');
      return false;
    }
    if (location == null) {
      _showAlertDialog('Vui lòng đánh dấu địa điểm trên bản đồ');
      return false;
    }

    return true;
  }

  void _addNewCampagin() async {
    var response =
        await myAPIWrapper.getWithAuth(ServerUrl + '/user/detailbytoken');
    var json = response.data as Map<String, dynamic>;
    var myUser = UserOverview.fromJson(json);

    var post = EmergencyPost(
      id: 0,
      address: _locationTextController.text,
      lat: location!.latitude,
      lng: location!.longitude,
      title: _nameTextController.text,
      content: _descriptionTextController.text,
      creator: myUser,
      timeCreate: DateTime.now(),
      imageUrl: avatarImagePath,
      bannerUrl: backgroundImagePath,
    );

    var insertResponse = await widget._postController.InsertPost(post);
    if (insertResponse.errorCode == null) {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => MyAlertDialog3(
          title: 'Thông báo',
          content: 'Tạo bài viết mới thành công',
        ),
      );
      Navigator.of(context).pop();
    } else {
      showDialog(
          context: context,
          builder: (_) => MyAlertDialog3(
              title: 'Lỗi',
              content: 'Không thể tạo bài viết, vui lòng thử lại sau'));
    }
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.initData != null) {
      var data = widget.initData!;
      _nameTextController.text = data.title;
      _locationTextController.text = data.address;
      _descriptionTextController.text = data.content;
      location = LatLng(data.lat, data.lng);
      avatarImagePath = data.imageUrl;
      backgroundImagePath = data.bannerUrl;
    }
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
                      SizedBox(
                        height: 5.h,
                      ),
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
                      OpenMap(
                        locationTextController: _locationTextController,
                        onChooseLocationFinish: (newLocation) {
                          location = newLocation;
                        },
                        initLocation: location,
                      )
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

                          initData: backgroundImagePath,
                          hintTitle: "+ Ảnh 1",

                          onImageChanged: (file) {
                            backgroundImagePath = file;
                          },
                          onImageDeleted: () {
                            backgroundImagePath = null;
                          },
                        ),
                        ImageCard(
                          initData: avatarImagePath,
                          onImageChanged: (file) {
                            avatarImagePath = file;
                          },
                          onImageDeleted: () {
                            avatarImagePath = null;
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
        widget.isAddData ? "Tạo tin khẩn cấp" : "Chỉnh sửa",
        style: ktext18BoldBlack,
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (!isValidation()) return;
          },
          child: Text(
            widget.isAddData ? "Đăng" : "Lưu",
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
