import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.onPressed, required this.textInput});
  final GestureTapCallback onPressed;
  final String textInput;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        textInput,
        style: kText18BoldWhite,
      ),
      style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          primary: meerColorMain,
          fixedSize: Size(MediaQuery.of(context).size.width - 100.w, 60.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
    );
  }
}
