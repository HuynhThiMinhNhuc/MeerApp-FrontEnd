import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';

class ChoiceLocationTime extends StatefulWidget {
  const ChoiceLocationTime({Key? key}) : super(key: key);

  @override
  State<ChoiceLocationTime> createState() => _ChoiceLocationTimeState();
}

class _ChoiceLocationTimeState extends State<ChoiceLocationTime> {
  DateTime? startDate;
  late TextEditingController _dateTextController;
  late TextEditingController _locationController;
  late bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _dateTextController = TextEditingController(text: "Chọn ngày tổ chức");
    _locationController = TextEditingController(
        text: "Khu phố 6 thành phố Thủ Đức tp. Hồ Chí Minh");
  }

  @override
  void dispose() {
    _dateTextController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: meerColorWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Container(
                width: 100.w,
                height: 10.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: meerColorBackground,
                ),
              )),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Thời gian, địa điểm ",
                style: ktext18BoldBlack,
              ),
              SizedBox(
                height: 10.h,
              ),
                 Row(
                children: [
                  Icon(
                    FontAwesomeIcons.locationDot,
                    color: meerColor25GreyNoteText,
                    size: 25.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Địa điểm",
                    style: kText15RegularGreyNotetext,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10.w),
                  Text(
                    "Sử dụng vị trí hiện tại của bạn ",
                    style: kText15BoldBlack,
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
                            controller: _locationController,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
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
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Text(
                  "Tên địa điểm",
                  style: kText15BoldBlack,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: TextFormField(),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.calendar,
                    color: meerColor25GreyNoteText,
                    size: 25.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Ngày",
                    style: kText15RegularGreyNotetext,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(FontAwesomeIcons.caretDown),
                                onPressed: () => {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(
                                        DateTime.now().year - 1,
                                        DateTime.now().month,
                                        DateTime.now().day),
                                    lastDate: DateTime(DateTime.now().year + 2),
                                  ).then((value) {
                                    startDate = value;

                                    if (startDate != null && startDate != "") {
                                      final formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(startDate!);
                                      if (formattedDate !=
                                          _dateTextController.text) {
                                        setState(() {
                                          _dateTextController.text =
                                              formattedDate;
                                          print(
                                              "Date selected: $formattedDate");
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        _dateTextController.text = '';
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
                height: 10.h,
              ),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.clock,
                    color: meerColor25GreyNoteText,
                    size: 25.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Giờ",
                    style: kText15RegularGreyNotetext,
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              TimePickerDialog(
                hourLabelText: "Giờ",
                minuteLabelText: "Phút",
                initialTime: TimeOfDay(
                  hour: DateTime.now().hour,
                  minute: DateTime.now().minute,
                ),
                initialEntryMode: TimePickerEntryMode.input,
                cancelText: "",
                confirmText: "",
                onEntryModeChanged: (time) => {
                  //Todo: save data time
                },
              ),
              SizedBox(
                height: 10.h,
              ),
           
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    primary: meerColorMain,
                    minimumSize: const Size.fromHeight(40),
                  ),
                  child: Text(
                    "Lưu ",
                    style: kText13BoldWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
