import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../config/colorconfig.dart';

class SkeletonPost extends StatelessWidget {
  const SkeletonPost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SkeletonLoader(
        builder: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                        child: Container(
                          width: 40.h,
                          height: 40.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: meerColorWhite,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: Container(
                              height: 8.h,
                              width: 40.w,
                               color: meerColorWhite,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Container(
                              height: 8.h,
                              width: 80.w,
                               color: meerColorWhite,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: 25.w,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  height: 400.h,
                  color: meerColorWhite,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 5.w, 5.h),
                child: Container(
                  height: 10.h,
                  width: 80.w,
                   color: meerColorWhite,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 0.h, 5.w, 5.h),
                child: Container(
                  height: 10.h,
                  width: 150.w,
                   color: meerColorWhite,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 10.h),
                child: Container(
                  height: 8.h,
                  width: 60.w,
                   color: meerColorWhite,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 10.h),
                child: Container(
                  height: 8.h,
                  width: 60.w,
                   color: meerColorWhite,
                ),
              ),
            ]),
        items: 3,
        period:const  Duration(seconds: 2),
        highlightColor:const  Color(0x505AA469),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
