import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meerapp/api/MyWrapper.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/constant.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/controllers/controller.dart';
import 'package:meerapp/injection.dart';
import 'package:meerapp/models/post.dart';
import 'package:meerapp/models/user.dart';
import 'package:meerapp/present/component/add_participant_dialog.dart';
import 'package:meerapp/present/component/image_card.dart';
import 'package:meerapp/present/component/map.dart';
import 'package:meerapp/present/component/open_map.dart';
import 'package:meerapp/singleton/user.dart';
import 'package:debounce_throttle/debounce_throttle.dart';

import '../../component/my_alert_dialog_3.dart';

class CreateNewCampaignPage extends StatefulWidget {
  final PostController _postController = sl.get<PostController>();
  final CampaignPost? initData;
  get isAddData => initData == null;
  CreateNewCampaignPage({Key? key, this.initData}) : super(key: key);

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

  bool isSwitched = false;
  String? avatarImagePath;
  String? backgroundImagePath;
  DateTime? startDate;
  LatLng? location;
  DateTime timeDay = DateTime.now();
  TimeOfDay? timeHour;
  List<UserOverview> listChooseUser = [];

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _dateTextController = TextEditingController(text: "Chọn ngày tổ chức");
    _locationTextController = TextEditingController();
    _descriptionTextController = TextEditingController();
    _timeTextController = TextEditingController(text: "Chọn giờ tổ chức");
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _dateTextController.dispose();
    _locationTextController.dispose();
    _descriptionTextController.dispose();
    _timeTextController.dispose();
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
      startDate = data.timeStart;
      timeHour =
          TimeOfDay(hour: data.timeStart.hour, minute: data.timeStart.minute);
      _setHourTextController(timeHour!);
      if (startDate != null) _setDateTextController(startDate!);
    }
  }

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

  Future<CampaignPost> _getCampaignObject() async {
    UserOverview? myUser;
    if (widget.initData == null) {
      var response =
          await myAPIWrapper.getWithAuth(ServerUrl + '/user/detailbytoken');
      var json = response.data as Map<String, dynamic>;
      myUser = UserOverview.fromJson(json);
    }
    return CampaignPost(
      id: widget.initData != null ? widget.initData!.id : 0,
      address: _locationTextController.text,
      lat: location!.latitude,
      lng: location!.longitude,
      title: _nameTextController.text,
      content: _descriptionTextController.text,
      creator: widget.initData != null ? widget.initData!.creator : myUser!,
      timeCreate: widget.initData != null
          ? widget.initData!.timeCreate
          : DateTime.now(),
      imageUrl: avatarImagePath,
      bannerUrl: backgroundImagePath,
      timeStart: widget.initData != null
          ? widget.initData!.timeStart
          : DateTime(
              timeDay.year,
              timeDay.month,
              timeDay.day,
              timeHour!.hour,
              timeHour!.minute,
            ),
    );
  }

  void _addNewCampaign() async {
    var post = await _getCampaignObject();

    final insertResponse = await widget._postController.InsertPost(post);
    if (insertResponse.errorCode == null) {
      var campaignId = insertResponse.data['id'];
      final inviteSuccess = await widget._postController.InviteUserToCampaign(
          campaignId, listChooseUser.map((e) => e.id).toList());
      if (inviteSuccess) {
        await showDialog<String>(
          context: context,
          builder: (BuildContext context) => MyAlertDialog3(
            title: 'Thông báo',
            content: 'Tạo bài viết mới thành công',
          ),
        );
        Navigator.of(context).pop('ok');
      } else {
        log('cannot invite user to campaign $campaignId');
      }
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => MyAlertDialog3(
          title: 'Lỗi',
          content: 'Không thể tạo bài viết, vui lòng thử lại sau',
        ),
      );
    }
  }

  void _updateCampaign() async {
    var post = await _getCampaignObject();

    var isSuccess = await widget._postController.UpdatePost(post.id, post);
    if (isSuccess) {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => MyAlertDialog3(
          title: 'Thông báo',
          content: 'Cập nhật bài viết mới thành công',
        ),
      );
      Navigator.of(context).pop('ok');
    } else {
      showDialog(
          context: context,
          builder: (_) => MyAlertDialog3(
              title: 'Lỗi',
              content: 'Không thể cập nhật bài viết, vui lòng thử lại sau'));
    }
  }

  void _setDateTextController(DateTime value) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(value);
    _dateTextController.text = "Ngày tổ chức: " + formattedDate;
  }

  void _setHourTextController(TimeOfDay value) {
    _timeTextController.text = 'Giờ tổ chức: ${value.hour}:${value.minute}';
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
                              child: TextFormField(
                                controller: _locationTextController,
                              ),
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
                            OpenMap(
                              locationTextController: _locationTextController,
                              onChooseLocationFinish: (newLocation) {
                                location = newLocation;
                              },
                              initLocation: location,
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
                            _buildTimeDay(context),
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
                            _buildTimeHour(context),
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
            if (widget.initData == null)
              ParticipantView(
                listChooseUser: listChooseUser,
                onAddUser: (object) {
                  setState(() {
                    listChooseUser.add(object);
                  });
                },
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
                          hintTitle: "+ Ảnh bìa",
                          onImageChanged: (file) {
                            backgroundImagePath = file;
                          },
                          onImageDeleted: () {
                            backgroundImagePath = null;
                          },
                        ),
                        ImageCard(
                          initData: avatarImagePath,
                          hintTitle: "+ Ảnh đại diện",
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
                        keyboardType: TextInputType.multiline,
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

  Widget _buildTimeDay(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(7.w, 0, 0, 0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextFormField(
                        readOnly: true,
                        textAlign: TextAlign.start,
                        style: kText15RegularBlack,
                        controller: _dateTextController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.caretDown),
                      onPressed: () async {
                        var startDate = await showDatePicker(
                          cancelText: "Huỷ",
                          confirmText: "Lưu",
                          locale: Locale("vi", "VN"),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1,
                              DateTime.now().month, DateTime.now().day),
                          lastDate: DateTime(DateTime.now().year + 2),
                        );

                        if (startDate != null) {
                          timeDay = startDate;
                          setState(() {
                            _setDateTextController(startDate);
                          });
                        } else {
                          timeDay = DateTime.now();
                          setState(() {
                            _dateTextController.text = '';
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildTimeHour(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(7.w, 0, 0, 0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextFormField(
                        readOnly: true,
                        textAlign: TextAlign.start,
                        style: kText15RegularBlack,
                        controller: _timeTextController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.caretDown),
                      onPressed: () async {
                        timeHour = await showTimePicker(
                          hourLabelText: "Giờ",
                          minuteLabelText: "Phút",
                          initialTime: TimeOfDay(
                            hour: timeHour?.hour ?? DateTime.now().hour,
                            minute: timeHour?.minute ?? DateTime.now().minute,
                          ),
                          initialEntryMode: TimePickerEntryMode.input,
                          cancelText: "Hủy",
                          confirmText: "Lưu",
                          onEntryModeChanged: (time) => {
                            //Todo: save data time
                          },
                          context: context,
                        );
                        if (timeHour != null) {
                          _setHourTextController(timeHour!);
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future<dynamic> showDialogAddCampaignUser(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) =>
          AddParticipantAlert(listChooseUser: listChooseUser),
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
        widget.isAddData ? "Tạo chiến dịch" : "Chỉnh sửa",
        style: ktext18BoldBlack,
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (!isValidation()) return;
            if (widget.isAddData) {
              _addNewCampaign();
            } else {
              _updateCampaign();
            }
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

class ParticipantView extends StatelessWidget {
  final List<UserOverview> listChooseUser;
  final Function(UserOverview)? onAddUser;
  ParticipantView({Key? key, required this.listChooseUser, this.onAddUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: meerColorWhite, borderRadius: BorderRadius.circular(10)),
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
                    onPressed: () async {
                      UserOverview? object = await showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            AddParticipantAlert(listChooseUser: listChooseUser),
                      );
                      ;
                      if (object != null) {
                        onAddUser?.call(object);
                      }
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
                listChooseUser.length,
                (index) => Padding(
                  padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
                  child: Chip(
                    backgroundColor: meerColorMain,
                    deleteIcon: const Icon(
                      FontAwesomeIcons.circleXmark,
                      color: meerColorWhite,
                    ),
                    label: Text(
                      listChooseUser[index].name,
                      style: TextStyle(
                          fontFamily: 'Roboto_Regular',
                          fontSize: 13.sp,
                          color: meerColorWhite),
                    ),
                    onDeleted: () {
                      listChooseUser.removeAt(index);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
