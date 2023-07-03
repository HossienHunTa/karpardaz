import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:karpardaz/app/data/model/repository.dart';
import 'package:karpardaz/app/global_widgets/widget.dart';
import 'package:karpardaz/core/utils/utils.dart';
import 'package:karpardaz/core/values/values.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'repository.dart';

class DriverView extends GetView<DriverController> {
  const DriverView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobileBodyisPortrait: DriverMobileBodyisPortrait(),
      tabletBodyisPortrait: DriverTabletBodyisPortrait(),
    );
  }
}

// Mobile Size
class DriverMobileBodyisPortrait extends GetView<DriverController> {
  const DriverMobileBodyisPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.amber[600],
          title: MyTitle(text: 'driver_title'.tr),
          centerTitle: true,
          leading: IconButton(
              icon: FaIcon(
                Languages.isPersian
                    ? FontAwesomeIcons.arrowRight
                    : FontAwesomeIcons.arrowLeft,
                color: Colors.white,
              ),
              onPressed: () => Get.back()),
          actions: [
            IconButton(
              onPressed: () {
                if (controller.onBackup()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('success'.tr)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('onBackup'
                          .trParams({'error': controller.e.toString()}))));
                }
              },
              icon: const FaIcon(
                FontAwesomeIcons.cloudArrowUp,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () async {
                if (await controller.onRestore()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('success'.tr)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('onRestore'
                          .trParams({'error': controller.e.toString()}))));
                }
              },
              icon: const FaIcon(
                FontAwesomeIcons.sync,
                color: Colors.white,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context,
              backgroundColor: Colors.amber[50],
              elevation: 1,
              useSafeArea: true,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              builder: (BuildContext context) => const MyModal()),
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
        ),
        body: Obx(() {
          if (controller.itemList.isEmpty) {
            return Center(
              child: Text('noData'.tr),
            );
          }
          return AnimationLimiter(
            child: LazyLoadScrollView(
              isLoading: controller.isLoadingVertical,
              onEndOfPage: () => controller.loadMore(),
              scrollOffset: 10,
              child: ListView.builder(
                primary: true,
                shrinkWrap: false,
                padding: const EdgeInsets.symmetric(vertical: 5),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: controller.itemList.length,
                itemBuilder: (context, index) {
                  final DriverModel item = controller.itemList[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 100),
                    child: SlideAnimation(
                      duration: const Duration(milliseconds: 2500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: FadeInAnimation(
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: DriverItem(
                          name: item.driverName,
                          date: item.date,
                          amount: item.amount,
                          onDelete: () => controller.btnDelete(item.id),
                          onUpdate: () => showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.amber[50],
                              elevation: 1,
                              useSafeArea: true,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(35)),
                              ),
                              builder: (BuildContext context) {
                                controller.textUpdateDriverNameController.text =
                                    item.driverName;
                                controller.textUpdateAmountController.text =
                                    item.amount!;
                                controller.textUpdateDateController.text =
                                    item.date;
                                return MyModalUpdate(
                                    id: item.id,
                                    date: jalaliStringToInt(item.date));
                              }),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}

class MyModal extends GetView<DriverController> {
  const MyModal({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.height;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: screenSize * 0.45,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myTextField(
                hintText: 'nameField_hintText'.tr,
                controller: controller.textDriverNameController,
                icon: const FaIcon(FontAwesomeIcons.user),
                keyboardType: TextInputType.name,
                isError: controller.nameFieldError,
              ),
              myTextField(
                hintText: 'amountField_hintText'.tr,
                controller: controller.textAmountController,
                icon: const FaIcon(FontAwesomeIcons.moneyBill),
                keyboardType: TextInputType.number,
                isError: controller.amountFieldError,
                inputFormatters: [ThousandsSeparatorInputFormatter()],
              ),
              DatePicker(
                controller: controller.textDateController,
                initialDate: Jalali.now(),
              ),
              ElevatedButton(
                onPressed: () => controller.btnSubmit(),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    // If the button is pressed, return green, otherwise blue
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.amber;
                    }
                    return Colors.amberAccent;
                  }),
                ),
                child: MyText(
                  text: 'btn_submit'.tr,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyModalUpdate extends GetView<DriverController> {
  const MyModalUpdate({
    super.key,
    required this.id,
    required this.date,
  });

  final int id;
  final Jalali date;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.height;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: screenSize * 0.45,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myTextField(
                hintText: 'nameField_hintText'.tr,
                controller: controller.textUpdateDriverNameController,
                icon: const FaIcon(FontAwesomeIcons.user),
                keyboardType: TextInputType.name,
                isError: controller.nameFieldError,
              ),
              myTextField(
                hintText: 'amountField_hintText'.tr,
                controller: controller.textUpdateAmountController,
                icon: const FaIcon(FontAwesomeIcons.moneyBill),
                keyboardType: TextInputType.number,
                isError: controller.amountFieldError,
                inputFormatters: [ThousandsSeparatorInputFormatter()],
              ),
              DatePicker(
                controller: controller.textUpdateDateController,
                initialDate: date,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    // If the button is pressed, return green, otherwise blue
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.amber;
                    }
                    return Colors.amberAccent;
                  }),
                ),
                onPressed: () => controller.btnUpdate(id),
                child: MyText(
                  text: 'btn_update'.tr,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Tablet Size
class DriverTabletBodyisPortrait extends GetView<DriverController> {
  const DriverTabletBodyisPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Home_tabletBodyisPortrait'),
        ),
      ),
    );
  }
}
