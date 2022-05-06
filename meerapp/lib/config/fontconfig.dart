import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colorconfig.dart';

var fontFamily = "Roboto";

var fontConfig = TextStyle(
    fontFamily: fontFamily,
    color: meerColorBlack,
    fontWeight: FontWeight.normal,
    fontSize: 13.sp);

var kText10RegularBlack = fontConfig.copyWith(fontSize: 10.sp);

var kText11RegularHintText = fontConfig.copyWith(fontSize: 11.sp, color: meerColorGreyHintText);
var kText11RegularWhite = fontConfig.copyWith(fontSize: 11.sp, color: meerColorWhite);

var kText12RegularBlack = fontConfig.copyWith(
  fontSize: 12.sp,
  decoration: TextDecoration.none,
  overflow: TextOverflow.ellipsis,
);

var kText13BoldBlack = fontConfig.copyWith(fontWeight: FontWeight.bold);
var kText13BoldWhite = kText13BoldBlack.copyWith(color: meerColorWhite);
var  kText13RegularNote = kText13BoldBlack.copyWith(fontWeight: FontWeight.normal, color: meerColorGreyNoteText);
var kText13RegularBlack = kText13RegularNote.copyWith(color: meerColorBlack);
var  kText13RegularMain = kText13BoldBlack.copyWith(fontWeight: FontWeight.normal, color: meerColorMain);
var kText13BoldMain = kText13RegularMain.copyWith(fontWeight: FontWeight.bold);

var kText15RegularGreyNotetext =
    fontConfig.copyWith(fontSize: 15.sp, color: meerColorGreyNoteText);
var kText15BoldMain = fontConfig.copyWith(fontSize: 15.sp, color: meerColorMain, fontWeight: FontWeight.w600);
var kText15RegularMain = kText15BoldMain.copyWith(fontWeight: FontWeight.w300 );
var kText15MediumBlack = fontConfig.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500);
var kText15RegularBlack = kText15RegularMain.copyWith(color: meerColorBlack);
var kText15RegularRed = kText15BoldMain.copyWith(fontWeight: FontWeight.w300, color: meerColorRed );
var kText15BoldBlack = kText15BoldMain.copyWith(color: meerColorBlack);
var ktext15RegularBlue = kText15RegularBlack.copyWith(color: Colors.blue);
var kText15BoldGreyHintText = fontConfig.copyWith(
  fontSize: 15.sp,
  color: meerColorGreyHintText,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
);


var kText16RegularWhite = fontConfig.copyWith(fontSize: 16.sp, color: meerColorWhite);
var kText16BoldBlack = kText16RegularWhite.copyWith(fontWeight: FontWeight.bold, color: meerColorBlack);
var kText16RegularBlack = kText16BoldBlack.copyWith(fontWeight: FontWeight.normal, fontSize: 16.sp);

var kText17SemiboldBlack = fontConfig.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w600);
var kText17SemiboldMain = fontConfig.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w500, color: meerColorMain);

var ktext17RegularBlack = fontConfig.copyWith(fontSize: 17.sp);
var ktext17RegularGreyText = fontConfig.copyWith(fontSize: 17.sp, color: meerColorGreyNoteText);

var kText17RegularRed = ktext17RegularBlack.copyWith(color: meerColorRed);
var kText17BoldBlack = kText17SemiboldBlack.copyWith(fontWeight: FontWeight.bold);

var kText18RegularMain = fontConfig.copyWith(fontSize: 18.sp, color: meerColorMain);
var ktext18BoldBlack = kText18BoldWhite.copyWith(color: meerColorBlack);
var kText18RegularWhite = kText18RegularMain.copyWith(color: meerColorWhite);
var kText18BoldWhite = kText18RegularWhite.copyWith(fontWeight: FontWeight.bold );

var kText20MediumBlack = fontConfig.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600);

var kText22BoldMain = fontConfig.copyWith(
    fontSize: 22.sp,
    fontFamily: "Lobster",
    color: meerColorMain,
    fontWeight: FontWeight.bold);


var kText24MeniumBlack = fontConfig.copyWith(
  fontSize: 24.sp,
  fontWeight: FontWeight.w500
);
var kText24BoldMain = kText22BoldMain.copyWith(fontSize: 24.sp);

var kText24BoldBlack = kText24MeniumBlack.copyWith(fontWeight: FontWeight.bold);
var kText40BoldMain = fontConfig.copyWith(
  fontSize: 40.sp,
  color: meerColorMain,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.bold,
);