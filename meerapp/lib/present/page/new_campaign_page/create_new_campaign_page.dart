import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';

class CreateNewCampaignPage extends StatelessWidget {
  const CreateNewCampaignPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: meerColorBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: meerColorBlackIcon, //change your color here
        ),
        centerTitle: true,
        backgroundColor: meerColorBackground,
        title: Text(
          "Tạo chiến dịch",
          style: ktext18BoldBlack,
        ),
        actions: [
          TextButton(
            onPressed: () { },
            child: Text(
              "Đăng",
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
      ),
      body: Padding(
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
                child: Column(
                  children: [
                    ChoiceField(
                      //controller: _locationTextController,
                      icon: Icons.keyboard_arrow_right_outlined,
                      title: 'Chọn địa điểm',
                      onPress: ()  {},
                    ),
                    ChoiceField(
                     // controller: _dateTextController,
                      icon: Icons.keyboard_arrow_right_outlined,
                      title: 'Chọn thời gian',
                      onPress: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1,
                              DateTime.now().month, DateTime.now().day),
                          lastDate: DateTime(DateTime.now().year + 2),
                        ).then((value) {
                          // startDate = value;

                          // if (startDate != null) {
                          //   final formattedDate =
                          //       DateFormat('dd/MM/yyyy').format(startDate!);
                          //   if (formattedDate != _dateTextController.text)
                          //     setState(() {
                          //       _dateTextController.text = formattedDate;
                          //       print("Date selected: $formattedDate");
                          //     });
                          // } else {
                          //   setState(() {
                          //     _dateTextController.text = '';
                          //   });
                          // }
                        });
                      },
                    )
                  ],
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
                        //controller: _nameTextController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Thêm tiêu đề tại đây"),
                      ),
                      TextFormField(
                          keyboardType: TextInputType.name,
                          //controller: _descriptionTextController,
                          minLines: 8,
                          maxLines: 15,
                          style: TextStyle(
                              fontFamily: 'Roboto-Regular.ttf',
                              fontSize: 15.sp,
                              color: Colors.grey[600]),
                          decoration: InputDecoration(
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
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: meerColorWhite,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 20.w,
                        //  alignment: ,
                        child: Text(
                          "Yêu cầu",
                          style: kText17BoldBlack,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.multiline,
                          //controller: _requireTextController,
                          minLines: 8,
                          maxLines: 10,
                          style: TextStyle(
                              fontFamily: 'Roboto-Regular.ttf',
                              fontSize: 15.sp,
                              color: Colors.grey[600]),
                          decoration: InputDecoration(
                              hintText: "Viết yêu cầu ở đây...",
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none)),
                    ],
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
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
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
                    style: kText15RegularMain,
                    controller: widget.controller,
                    decoration: new InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                    iconSize: 20.w,
                    padding: EdgeInsets.all(1.0),
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
    );
  }
}
