import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/constant/current_user.dart';

class IntroduceCampaintWidget extends StatelessWidget {
  final String nameCreator;
  final String datecreate;
  final int numberjoiner;
  final String content;
  final String time;
  final String address;
  final String email;
  final String? phone;
  const IntroduceCampaintWidget({ Key? key,
  required this.nameCreator, 
  required this.datecreate,
  required this.content,
  required this.numberjoiner,
  required this.address,
  required this.time,
  required this.email,
  this.phone,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80.w,
                  child: Text(
                    "Thông tin chung",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: ktext18BoldBlack,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                const Icon(FontAwesomeIcons.userPen, size: 20, color: meerColorGreyNoteText,),
                SizedBox(
                  width: 5.w,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                         text: " " + nameCreator,
                         style: ktext15RegularBlue,),
                      TextSpan(
                          text: " đã tạo sự kiện này",
                          style: kText15RegularBlack),
                    ]))
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              children: [
                const Icon(FontAwesomeIcons.userGroup, size: 20, color: meerColorGreyNoteText,),
                SizedBox(
                  width: 7.h,
                ),
                Text(
                  " " + numberjoiner.toString() +  " người đã tham gia sự kiện này",
                  style: kText15RegularBlack,
                )
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              children: [
                const Icon(FontAwesomeIcons.calendarDay, size: 20, color: meerColorGreyNoteText,),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  " Ngày tổ chức: " + datecreate,
                  style: kText15RegularBlack,
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Câu chuyện",
              style: ktext18BoldBlack,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text( content,
            style: kText15RegularBlack,),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Thời gian, địa điểm",
              style: ktext18BoldBlack,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text.rich(
              TextSpan(text: 'Thời gian: ', style: kText15BoldBlack, children: [
                TextSpan(
                    text: datecreate,
                    style: kText15RegularBlack)
              ]),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text.rich(
              TextSpan(text: 'Địa điểm: ', style: kText15BoldBlack, children: [
                TextSpan(
                    text: address,
                    style: kText15RegularBlack)
              ]),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Thông tin liên hệ",
              style: ktext18BoldBlack,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text.rich(
              TextSpan(text: 'Email: ', style: kText15BoldBlack, children: [
                TextSpan(
                    text: email,
                    style: kText15RegularBlack)
              ]),
            ),
            SizedBox(
              height: 5.h,
            ),
            if (phone != null) Text.rich(
              TextSpan(
                  text: 'Số điện thoại: ',
                  style: kText15BoldBlack,
                  children: [
                    TextSpan(
                        text: phone,
                        style: kText15RegularBlack)
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}