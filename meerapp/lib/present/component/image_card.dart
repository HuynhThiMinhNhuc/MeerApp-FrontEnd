import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meerapp/config/colorconfig.dart';
import 'package:meerapp/config/fontconfig.dart';
import 'package:meerapp/config/helper.dart';
import 'package:meerapp/present/page/profile/Wrapper/MyImage.dart';
import 'package:path/path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

class ImageCard extends StatefulWidget {
  final double width;
  final double height;
  final String? hintTitle;
  final IconData? icon;
  final String? initData;
  final Function(String)? onImageChanged;
  final Function()? onImageDeleted;

  ImageCard({
    Key? key,
    this.hintTitle,
    this.width = 120,
    this.height = 150,
    this.onImageChanged,
    this.onImageDeleted,
    this.icon,
    this.initData,
  }) : super(key: key);

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  late String? imageFileDir = widget.initData;
  File get imageFile => File(imageFileDir!);
  bool get isUrl => imageFileDir != null && isHttpImage(imageFileDir!);

  Future<void> _galleryImage() async {
    final _picker = ImagePicker();
    var picture = await _picker.pickImage(source: ImageSource.gallery);
    if (picture != null) {
      final directory = await getApplicationDocumentsDirectory();

      //Get image path in storage app
      final image = File('${directory.path}/${basename(picture.path)}');

      //Create new image from source image, add temporary to storage app
      // final file = File(picture.path); //.copy(image.path);

      setState(() {
        //Update UI with image
        imageFileDir = image.path;
      });
      widget.onImageChanged?.call(imageFileDir!);
    }
  }

  Future<void> _deleteImage() async {
    if (imageFileDir != null) {
      print('request delete if image not null');
      setState(() {
        imageFileDir = null;
      });
      widget.onImageDeleted?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = widget.width;
    final double height = widget.height;

    return Container(
      child: InkWell(
        child: imageFileDir != null
            ? Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: isUrl
                      ? Image.network(
                          tranferToDbPath(imageFileDir!),
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          imageFile,
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: Color.fromARGB(206, 173, 173, 173),
                      ),
                      onPressed: _deleteImage,
                    ))
              ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.hintTitle != null)
                    Text(widget.hintTitle!,
                        textAlign: TextAlign.center, style: kText13RegularNote),
                  if (widget.icon != null)
                    Icon(widget.icon, color: meerColorMain, size: 25),
                ],
              ),
        onTap: _galleryImage,
        onLongPress: _deleteImage,
      ),
      height: 150,
      width: 120,
      decoration: BoxDecoration(
        color: meerColorBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.fromLTRB(10.h, 10.w, 5.h, 10.h),
    );
  }
}
