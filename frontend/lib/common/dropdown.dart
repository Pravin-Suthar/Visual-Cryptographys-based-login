import 'package:flutter/material.dart';
import 'package:frontend/common/design/customColors.dart';
import 'package:frontend/common/design/fontStyle.dart';
import 'package:frontend/controller/dropdown_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownCustom extends StatefulWidget {
  const DropdownCustom({super.key});

  @override
  State<DropdownCustom> createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  final labelcontroller = Get.put(DropdownController());

  final labelscrollcontroller = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );
  @override
  Widget build(BuildContext context) {
    List<String> dropdownItems = ['Male', 'Female', 'Other'];

    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                labelcontroller.isDropdownOpen.value =
                    !labelcontroller.isDropdownOpen.value;
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Theme.of(context).extension<AppColors>()!.c4
                          as Color),
                  color: Theme.of(context).extension<AppColors>()!.c4 as Color,
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      labelcontroller.selected.value.isEmpty
                          ? 'Select' //For just in case
                          : labelcontroller.selected.value,
                      style: CustomTextStyle.T4(context),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(labelcontroller.isDropdownOpen.value
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down)),
                  ],
                ),
              ),
            ),
            if (labelcontroller.isDropdownOpen.value)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Theme.of(context).extension<AppColors>()!.c5
                          as Color),
                  color: Theme.of(context).extension<AppColors>()!.c2 as Color,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 3 * 42.0.h,
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        scrollbarTheme: ScrollbarThemeData(
                            thickness: MaterialStateProperty.all(4),
                            thumbVisibility: MaterialStateProperty.all(true),
                            radius: Radius.circular(40),
                            crossAxisMargin: 24.w,
                            //colors of the scrollbar take only Colors not custome colors.
                            thumbColor: MaterialStateProperty.all(
                                Color.fromRGBO(5, 74, 104, 1)))),
                    child: Scrollbar(
                      controller: labelscrollcontroller,
                      child: ListView.builder(
                        controller: labelscrollcontroller,
                        shrinkWrap: true,
                        itemCount: dropdownItems.length,
                        itemBuilder: (context, index) {
                          final item = dropdownItems[index];
                          return InkWell(
                            onTap: () {
                              labelcontroller.onItemSelected(item);
                              labelcontroller.isDropdownOpen.value = false;
                            },
                            child: Container(
                              height: 42.h,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              color: labelcontroller.selected.value == item
                                  ? Theme.of(context).extension<AppColors>()!.c6
                                      as Color
                                  : Theme.of(context).extension<AppColors>()!.c4
                                      as Color,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(item,
                                      style: CustomTextStyle.T4(context)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
