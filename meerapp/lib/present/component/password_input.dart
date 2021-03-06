import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:intl/intl.dart';

class PassWordInput extends StatefulWidget {
  final bool securitytext;
  final Color background;
  final Color boder;
  final String hint;
  final bool ispass;
  final TextEditingController textcontroller;
  final TextInputType textInputType;

  PassWordInput(
      {required this.securitytext,
      required this.background,
      required this.boder,
      required this.hint,
      required this.ispass,
      required this.textcontroller,
      required this.textInputType});

  @override
  _PassWordInputState createState() => _PassWordInputState();
}

class _PassWordInputState extends State<PassWordInput> {
  bool securi = true;

  @override
  void initState() {
    securi = widget.securitytext;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.textcontroller,
      style: kText15RegularBlack,
      decoration: InputDecoration(
          prefixIcon: Icon(
            widget.ispass ? Icons.lock : Icons.cake_rounded,
            color: meerColorMain,
            size: 23.h,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: widget.boder.withOpacity(1), width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: widget.boder.withOpacity(1), width: 1)),
          hintText: widget.hint,
          hintStyle: kText15BoldGreyHintText,
          fillColor: widget.background.withOpacity(0.2),
          filled: true,
          suffixIcon: IconButton(
            icon: widget.ispass
                ? securi
                    ? FaIcon(FontAwesomeIcons.eyeSlash,
                        size: 18.h, color: meerColorMain)
                    : Icon(
                        Icons.remove_red_eye_outlined,
                        size: 23.h,
                        color: meerColorMain,
                      )
                : FaIcon(
                    FontAwesomeIcons.calendar,
                    color: meerColorMain,
                    size: 20.h,
                  ),
            color: meerColorBlackIcon,
            onPressed: () {
              widget.ispass
                  ? setState(() {
                      securi = !securi;
                    })
                  : showDatePicker(
                      context: context,
                      initialDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day),
                      firstDate: DateTime(DateTime.now().year - 100,
                          DateTime.now().month, DateTime.now().day),
                      lastDate: DateTime(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day),
                    ).then((value) {
                      if (value != null) {
                        if (widget.textcontroller.text !=
                            DateFormat('dd/MM/yyyy').format(value))
                          setState(() {
                            widget.textcontroller.text =
                                DateFormat('dd/MM/yyyy').format(value);
                            print(
                                "Date selected: $widget.currentUser.birthDayString");
                          });
                      }
                    });
            },
            splashRadius: 25,
          )),
      obscureText: widget.ispass ? securi : false,
    );
  }
}
