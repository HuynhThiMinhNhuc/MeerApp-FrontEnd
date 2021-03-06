
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meerapp/config/colorconfig.dart';

import '../../component/custom_btn.dart';
import 'login_view.dart';

class SenLinkResetPassView extends StatefulWidget {
  SenLinkResetPassView();

  @override
  _SenLinkResetPassViewState createState() => _SenLinkResetPassViewState();
}

class _SenLinkResetPassViewState extends State<SenLinkResetPassView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: meerColorGreyText, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () => {},
                  icon: FaIcon(
                    FontAwesomeIcons.checkCircle,
                    color: meerColorMain,
                    size: 30,
                  ),
                  label: Text(
                    'Đã gửi link thành công',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto-Regular.ttf',
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                '  Kiểm tra email và đổi mật khẩu',
                style: TextStyle(
                    color: meerColorMain,
                    fontSize: 28,
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                    'Meer đã gửi link thay đổi mật khẩu vào email của bạn. Vui lòng kiểm tra email và làm theo hướng dẫn để thay đổi mật khẩu!',
                    maxLines: 4,
                    style: TextStyle(
                      color: meerColorGreyText,
                      fontFamily: 'Roboto-Regular.tff',
                      fontSize: 16,
                    )),
              ),
              Center(
                child: Image(
                  image: AssetImage('asset/welcome.png'),
                  width: 350,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(
                    onPressed: () => {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  LoginPage(),
                                      ),
                              (Route<dynamic> route) => false)
                        },
                    textInput: 'ĐĂNG NHẬP'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
