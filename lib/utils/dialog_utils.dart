import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../page_routes.dart';
import '../theme/color.dart';

Future showPermissionDialog(BuildContext context,
    {required String title, required String content}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('Huỷ'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: const Text('Cài đặt'),
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
              ),
            ],
          ));
}

Future showDefaultDialog(BuildContext context,
    {required String title,
    required String content,
    required Function()? function}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Center(
                child: Text(
              title,
              style: const TextStyle(color: Colors.red),
            )),
            content: Text(content),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: const Text(
                  'Không',
                  style: TextStyle(
                      fontFamily: 'Roboto', fontWeight: FontWeight.w700),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: const Text('Có',
                    style: TextStyle(
                        fontFamily: 'Roboto', fontWeight: FontWeight.w700)),
                onPressed: function,
              ),
            ],
          ));
}

Future requestPermission(Permission permission, BuildContext context,
    {VoidCallback? onGranted,
    required String title,
    required String content}) async {
  final status = await permission.status;
  switch (status) {
    case PermissionStatus.granted:
      onGranted?.call();
      break;
    case PermissionStatus.restricted:
      break;
    case PermissionStatus.limited:
      break;
    case PermissionStatus.denied:
      {
        permission.request().then((value) {
          if (value == PermissionStatus.granted) {
            onGranted?.call();
          }
        });
      }
      break;
    case PermissionStatus.permanentlyDenied:
      showPermissionDialog(context, title: title, content: content);
      break;
  }
}

showModalBottomSheetImage(
    {required BuildContext context, Function(dynamic)? imageCallBack}) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 135,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera),
                    title: const Text('Máy ảnh'),
                    onTap: () {
                      Navigator.pop(ctx);
                      requestPermission(
                        Permission.camera,
                        context,
                        content: 'Ứng dụng cần quyền truy cập vào máy ảnh',
                        title: 'Máy ảnh',
                        onGranted: () async {
                          final pickedImage = await ImagePicker()
                              .getImage(source: ImageSource.camera);
                          if (pickedImage != null) {
                            imageCallBack?.call(pickedImage.path);
                          } else {
                            imageCallBack?.call(null);
                          }
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text('Thư viện'),
                    onTap: () {
                      Navigator.pop(ctx);
                      requestPermission(
                        Permission.photos,
                        context,
                        content: 'Ứng dụng cần quyền truy cập vào thư viện ảnh',
                        title: 'Thư viện',
                        onGranted: () async {
                          final pickedImage = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          if (pickedImage != null) {
                            imageCallBack?.call(pickedImage.path);
                          } else {
                            imageCallBack?.call(null);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

showAlert(BuildContext context) {
  Widget submitButton = ElevatedButton(
      child: Text('Lịch sử mua'.toUpperCase()),
      style: ElevatedButton.styleFrom(primary: AppColors.textWhite),
      onPressed: () {
        Navigator.of(context).pop();
      });

  AlertDialog dialog = AlertDialog(
      title: const Text('Đặt mua sản phẩm thành công!'),
      actions: [submitButton]);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}

showAlertSignUp(
    {required BuildContext context,
    required String title,
    required String textAction}) {
  Widget submitButton = GestureDetector(
      child: Container(
        child: Center(
          child: Text(
            textAction.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0),
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        width: 134.0,
        height: 36.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(width: 1.0, color: AppColors.primaryColor)),
      ),
      onTap: () {
        // Navigator.pushNamedAndRemoveUntil(context, PageRoutes.signInNew,
        //     ModalRoute.withName(PageRoutes.enterPhoneNumber));
        // FramePhase.buildFinish;
      });

  AlertDialog dialog = AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.visible,
      ),
      actions: [submitButton]);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}

showAlertSuccessBooking(BuildContext context, GestureTapCallback onTap) {
  Widget submitButton = ElevatedButton(
    child: Text('Lịch sử đặt lịch'.toUpperCase()),
    style: ElevatedButton.styleFrom(
        primary: AppColors.textWhite,
        side: BorderSide(color: AppColors.primaryColor),
        elevation: 0),
    onPressed: onTap,
  );

  AlertDialog dialog = AlertDialog(
      title: const Text('Đặt lịch thành công!'), actions: [submitButton]);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}

showAlertUpdateInfoSuccess(BuildContext context, String content) {
  AlertDialog dialog = AlertDialog(
      title: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    child: Text(
      content,
      style: const TextStyle(
          fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Roboto'),
    ),
  ));
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}
