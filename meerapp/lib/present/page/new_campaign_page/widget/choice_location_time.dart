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

  @override
  void initState() {
    super.initState();
    _dateTextController = TextEditingController(text: "Chọn ngày tổ chức");
  }

  @override
  void dispose() {
    _dateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextFormField(
                                  readOnly: true,
                                  textAlign: TextAlign.end,
                                  style: kText15RegularMain,
                                  controller: _dateTextController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
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
                                      lastDate:
                                          DateTime(DateTime.now().year + 2),
                                    ).then((value) {
                                      startDate = value;

                                      if (startDate != null) {
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
                            )),
                      ]),
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
                ],
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)));
  }
}
