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
import 'package:meerapp/present/component/image_card.dart';
import 'package:meerapp/present/page/new_campaign_page/widget/map.dart';
import 'package:meerapp/singleton/user.dart';
import 'package:debounce_throttle/debounce_throttle.dart';

class CreateNewCampaignPage extends StatefulWidget {
  final PostController _postController = sl.get<PostController>();
  final bool isCreate; 
  CreateNewCampaignPage({Key? key, required this.isCreate}) : super(key: key);

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

  DateTime hourTimeStart = DateTime(1);
  bool isSwitched = false;
  late File? avatarImage;
  late File? backgroundImage;
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
    _requireTextController = TextEditingController();
    _timeTextController = TextEditingController(text: "Chọn giờ tổ chức");
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
    void _showAlertDialog(String text) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Lỗi'),
          content: Text(text),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
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
    var currentUser = await UserSingleton.instance.userInfoStream.stream.last;

    var post = CampaignPost(
      id: 0,
      address: _locationTextController.text,
      lat: location!.latitude,
      lng: location!.longitude,
      title: _nameTextController.text,
      content: _descriptionTextController.text,
      creator: UserOverview.fromJson(currentUser),
      timeCreate: DateTime.now(),
      imageUrl: avatarImage?.path,
      bannerUrl: backgroundImage?.path,
      timeStart: DateTime(
        timeDay.year,
        timeDay.month,
        timeDay.day,
        timeHour!.hour,
        timeHour!.minute,
      ),
    );
    final success = await widget._postController.InsertPost(post);
    if (success) {
      // TODO: show dialog success
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
                                        onPressed: () async {
                                          location = await Navigator.of(context)
                                              .push<LatLng?>(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  MyMap(initLocation: location),
                                            ),
                                          );
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
                            onPressed: () async {
                              await showDialogAddCampaignUser(context);
                              setState(() {});
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
                          onImageDeleted: () {
                            backgroundImage = null;
                          },
                        ),
                        ImageCard(
                          hintTitle: "+ Ảnh đại diện",
                          onImageChanged: (file) {
                            avatarImage = file;
                          },
                          onImageDeleted: () {
                            avatarImage = null;
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
                          final formattedDate =
                              DateFormat('dd/MM/yyyy').format(startDate!);
                          setState(() {
                            _dateTextController.text =
                                "Ngày tổ chức: " + formattedDate;
                            print("Date selected: $formattedDate");
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
                          _timeTextController.text =
                              'Giờ tổ chức ${timeHour!.hour}:${timeHour!.minute}';
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

  Future<String?> showDialogAddCampaignUser(BuildContext context) {
    return showDialog<String>(
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
        widget.isCreate? "Tạo chiến dịch" : "Chỉnh sửa",
        style: ktext18BoldBlack,
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (!isValidation()) return;
            _addNewCampagin();
          },
          child: Text(
            widget.isCreate? "Đăng" : "Lưu",
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

class AddParticipantAlert extends StatelessWidget {
  AddParticipantAlert({
    Key? key,
    required this.listChooseUser,
  }) : super(key: key);

  final List<UserOverview> listChooseUser;
  final List<UserOverview> _listUserBytext = [];
  int count = 0;
  late Debouncer<String> debouncer =
      Debouncer<String>(Duration(microseconds: 3000), initialValue: '',
          onChanged: (textSearch) async {
    var queryParams = {
      'searchby': 'fullname',
      'searchvalue': textSearch,
      'orderby': 'fullname',
      'orderdirection': 'asc',
      'start': 0,
      'count': 5,
    };
    var response = await myAPIWrapper.get(
      ServerUrl + '/user/select',
      queryParameters: queryParams,
    );

    _listUserBytext.clear();
    _listUserBytext.addAll((response.data as List<dynamic>)
        .map((json) => UserOverview.fromJson(json)));
    log('load complete: ' + (++count).toString());
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Thêm người tham gia',
        style: kText15BoldBlack,
      ),
      content: Autocomplete<UserOverview>(
        displayStringForOption: (option) => option.name,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text.trim() == '') {
            return [];
          }
          debouncer.setValue(textEditingValue.text);
          return _listUserBytext;
        },
        onSelected: (UserOverview selection) {
          debugPrint('You just selected ${selection.name}');
          listChooseUser.add(selection);
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
