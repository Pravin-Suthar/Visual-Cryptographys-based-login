import 'dart:ffi';
import 'dart:io';
import 'package:frontend/common/design/customColors.dart';
import 'package:frontend/common/design/fontStyle.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:frontend/controller/examiner_controller.dart';

class ImageOverlayPage extends StatefulWidget {
  @override
  _ImageOverlayPageState createState() => _ImageOverlayPageState();
}

class _ImageOverlayPageState extends State<ImageOverlayPage> {
  final double imageOpacity = 1; // Set your desired opacity value
  final ExaminerController examinerController = Get.put(ExaminerController());

  bool isBottomImageMoved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Overlay Page'),
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (examinerController.selectedFileBytes.value != null)
                    Opacity(
                      opacity: 1,
                      child: SizedBox(
                        height: 350,
                        width: 350,
                        child: Image.memory(
                          examinerController.selectedFileBytes.value!,
                        ),
                      ),
                    ),
                  if (examinerController.overlayedFileBytes.value != null)
                    AnimatedPositioned(
                      top: 0,
                      duration: Duration(milliseconds: 500),
                      child: Opacity(
                        opacity: 0.5,
                        child: SizedBox(
                          height: 350,
                          width: 350,
                          child: Image.memory(
                            examinerController.overlayedFileBytes.value!,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              TextField(
                enabled: true,
                controller: examinerController.otpController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      Theme.of(context).extension<AppColors>()!.c12 as Color,
                  contentPadding: const EdgeInsets.only(bottom: 15, left: 10),
                  hintText: "Otp",
                  hintStyle: CustomTextStyle.T4(context),
                ),
              ),
              
               ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:
                        Theme.of(context).extension<AppColors>()!.c1 as Color,
                    backgroundColor:
                        Theme.of(context).extension<AppColors>()!.c12 as Color,
                  ),
                 onPressed: () {
                      examinerController.verifyOtp();
                    },
                  child: Text(
                    'Verify',
                    style: CustomTextStyle.T4(context),
                  ),
                
              ),
              ElevatedButton(
                onPressed: () async {
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
                    PlatformFile file = result.files.first;
                    // Get the bytes of the selected file

                    List<int> fileBytes = await File(file.path!).readAsBytes();

                    // Update the overlayedFileBytes in the controller
                    examinerController.overlayedFileBytes.value =
                        Uint8List.fromList(fileBytes);

                    //  print(                    examinerController.overlayedFileBytes.value );
                  }
                },
                child: Text('Select One More'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
