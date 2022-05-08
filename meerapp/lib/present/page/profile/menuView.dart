import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/present/component/menu_item.dart';
import 'package:meerapp/present/page/Login/change_password.dart';

import '../Login/login_view.dart';
import 'edit_profile.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: meerColorGreyText),
          backgroundColor: Color(0xFFfafafa),
          centerTitle: true,
          shadowColor: meerColor25GreyNoteText,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: meerColorBlackIcon,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Cài đặt",
            style: kText17BoldBlack,
          ),
        ),
        body: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 10.w),
            child: StatusSwitch(firstState: true),
          ),
          MenuItem(
              title: 'Chỉnh sửa hồ sơ',
              iconMenu: Icons.edit_outlined,
              clickMenu: () => {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => EditProfile()),
                    // )
                  }),
          MenuItem(
            title: 'Đổi mật khẩu',
            iconMenu: Icons.password_outlined,
            clickMenu: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePassword()),
              )
            },
          ),
          SizedBox(
            height: 40.h,
          ),
          InkWell(
              child: Container(
                height: 35.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: const BoxDecoration(
                  color: meerColorRed,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ), //BorderRadius.all
                ),
                child: Center(
                  child: Text(
                    'Đăng xuất',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontFamily: 'Roboto_Regular',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () => {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(
                          'Đăng xuất',
                          style: kText16BoldBlack,
                        ),
                        content: Text(
                          'Bạn thật sự muốn đăng xuất khỏi tài khoản này?',
                          style: kText14RegularBlack,
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Hủy'),
                            child: Text(
                              'Hủy',
                              style: kText15BoldBlack.copyWith(
                                  color: meerColorGreyNoteText),
                            ),
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              ),
                            },
                            child: Text('Đăng xuất', style: kText15BoldMain),
                          ),
                        ],
                      ),
                    )
                  }),
        ]));
  }
}

class StatusSwitch extends StatefulWidget {
  final Function(bool value)? onChanged;
  final bool firstState;
  StatusSwitch({required this.firstState, this.onChanged, Key? key})
      : super(key: key);
  @override
  _StatusSwitchState createState() =>
      new _StatusSwitchState(status: firstState);
}

class _StatusSwitchState extends State<StatusSwitch> {
  bool status = false;
  _StatusSwitchState({this.status = false});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.only(top: 10.h),
      title: Text(
        'Chế độ sẵn sàng',
        style: kText16RegularBlack,
      ),
      value: status,
      onChanged: (value) async {
        widget.onChanged?.call(value);

        setState(() {
          status = !status;
        });
      },
    );
  }
}
