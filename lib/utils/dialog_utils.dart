import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
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

Future showDefaultDialog(BuildContext context, {required String title, required String content, String? textNoButton, String? textYesButton, required Function()? onPressNo, required Function()? onPressYes}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: Text(title.toUpperCase(), style: const TextStyle(color: Colors.red))),
        content: Text(content, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black87, height: 1.5)),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        actions: <Widget>[
          SizedBox(
            height: 34,
            width: 88,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              child: Text( textNoButton ?? 'Không', style: const  TextStyle(fontSize: 13, fontFamily: 'Roboto', fontWeight: FontWeight.w500)),
              onPressed: onPressNo,
            ),
          ),
          SizedBox(
            height: 34,
            width: 88,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0
              ),
              child: Text( textYesButton ?? 'Có', style: const TextStyle(fontSize: 13, fontFamily: 'Roboto', fontWeight: FontWeight.w700)),
              onPressed: onPressYes,
            ),
          ),
        ],
      )
  );
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

showModalBottomSheetImage({
  required BuildContext context,
  required bool isMulti,
  Function(String)? imageCallBack,
  Function(List<String>)? listImageCallback,
}) {
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
              height: 80,
              child: Column(
                children: [
                  // ListTile(
                  //   leading: const Icon(Icons.camera),
                  //   title: const Text('Máy ảnh'),
                  //   onTap: () {
                  //     Navigator.pop(ctx);
                  //     requestPermission(
                  //       Permission.camera,
                  //       context,
                  //       content: 'Ứng dụng cần quyền truy cập vào máy ảnh',
                  //       title: 'Máy ảnh',
                  //       onGranted: () async {
                  //         final pickedImage = await ImagePicker()
                  //             .getImage(source: ImageSource.camera);
                  //         if (pickedImage != null) {
                  //           imageCallBack?.call(pickedImage.path);
                  //         } else {
                  //           imageCallBack?.call(null);
                  //         }
                  //       },
                  //     );
                  //   },
                  // ),
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
                          if(!isMulti){
                            final pickedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickedImage != null) {
                              imageCallBack?.call(pickedImage.path);
                            } else {
                              context.showMessage("Bạn chưa chọn ảnh nào", type: MessageType.error);
                            }
                          } else{
                            final ImagePicker imagePicker = ImagePicker();
                            List<String>? imagePathFileList = [];
                            final List<XFile>? selectedImages = await
                            imagePicker.pickMultiImage();
                            if(selectedImages == null){
                              context.showMessage("Vui lòng chọn ít nhất 1 ảnh", type: MessageType.error);
                            } else if (selectedImages.isEmpty) {
                              context.showMessage("Chọn ảnh gặp lỗi, vui lòng thử lại", type: MessageType.error);
                            }else{
                              imagePathFileList.addAll(selectedImages.map((e) => e.path).toList());
                            }
                            listImageCallback?.call(imagePathFileList);
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

