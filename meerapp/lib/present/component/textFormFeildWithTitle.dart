
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';

class textFormFieldWithTitle extends StatelessWidget {
  final String title;
  final String text;
  final Icon? iconData;
  final TextInputType type;
  final TextEditingController controller;
  final Function()? onClickIcon;
  const textFormFieldWithTitle({
    Key? key,
    required this.title,
    required this.text,
    required this.iconData,
    required this.type,
    required this.controller,
    this.onClickIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: kText15BoldBlack,
          ),
          TextFormField(
            controller: controller,
            cursorColor: meerColorMain,
            style: kText15RegularBlack,
            keyboardType: type,
            decoration: new InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: meerColorMain),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: meerColorMain,
                  ),
                ),
                suffixIcon: iconData != null
                    ? IconButton(
                        onPressed: () => onClickIcon?.call(),
                        icon: iconData!,
                        iconSize: 20.w,
                      )
                    : null,
                label: null),
          ),
          SizedBox(height: 7)
        ],
      ),
    );
  }
}
