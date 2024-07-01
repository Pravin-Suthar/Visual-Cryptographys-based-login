
import 'dart:io';
import 'package:frontend/common/design/customColors.dart';
import 'package:frontend/common/design/fontStyle.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:frontend/controller/user_controller.dart';

class ImageOverlayPage extends StatefulWidget {
  @override
  _ImageOverlayPageState createState() => _ImageOverlayPageState();
}

class _ImageOverlayPageState extends State<ImageOverlayPage> {
  final double imageOpacity = 1; // Set your desired opacity value
  final UserController userController = Get.put(UserController());

  bool isBottomImageMoved = false;

  @override
  void initState() {
    super.initState();

    userController.shouldAnimate.value = false;

    userController.overlayedFileBytes.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (userController.selectedFileBytes.value != null)
                    Opacity(
                      opacity: 1,
                      child: SizedBox(
                        height: 350,
                        width: 350,
                        child: Image.memory(
                          userController.selectedFileBytes.value!,
                        ),
                      ),
                    ),
                  if (userController.overlayedFileBytes.value != null)
                    AnimatedPositioned(
                      top: userController.shouldAnimate.value ? 0 : 300,
                      duration: Duration(milliseconds: 800),
                      curve: Curves
                          .easeInOut, // Optional: Add a curve for smoother animation
                      child: Opacity(
                        opacity: 0.5,
                        child: SizedBox(
                          height: 350,
                          width: 350,
                          child: Image.memory(
                            userController.overlayedFileBytes.value!,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20,),
              TextField(
                enabled: true,
                controller: userController.otpController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      Theme.of(context).extension<AppColors>()!.c12 as Color,
                  contentPadding: const EdgeInsets.only(bottom: 15, left: 10),
                  hintText: "Enter the Otp here",
                  hintStyle: CustomTextStyle.T4(context),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor:
                      Theme.of(context).extension<AppColors>()!.c1 as Color,
                  backgroundColor:
                      Theme.of(context).extension<AppColors>()!.c12 as Color,
                ),
                onPressed: () {
                  userController.verifyOtp();
                },
                child: Text(
                  'Verify Otp',
                  style: CustomTextStyle.T4(context),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Reset the shouldAnimate flag to false before selecting a new image
                  userController.shouldAnimate.value = false;

                  final Directory appCacheDir = await getTemporaryDirectory();
                  final String cacheDirectoryPath =
                      '${appCacheDir.path}/file_picker/';

                  final Directory cacheDirectory =
                      Directory(cacheDirectoryPath);

                  if (await cacheDirectory.exists()) {
                    final cachedFiles = await cacheDirectory.list().toList();
                    for (final cachedFile in cachedFiles) {
                      if (cachedFile is File) {
                        await cachedFile.delete();
                      }
                    }
                  }
                  // Select one more file using file picker
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['png'],
                  );

                  if (result != null) {
                    userController.shouldAnimate.value =
                        true; // Set shouldAnimate to true after selecting a new image
                    PlatformFile file = result.files.first;
                    // Get the bytes of the selected file
                    List<int> fileBytes = await File(file.path!).readAsBytes();
                    // Update the overlayedFileBytes in the controller
                    userController.overlayedFileBytes.value =
                        Uint8List.fromList(fileBytes);
                  }
                },
                child: Text('Select the share2 sent to registered email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
