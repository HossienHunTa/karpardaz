import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:karpardaz/app/global_widgets/widget.dart';
import 'package:karpardaz/routes/pages.dart';

import 'repository.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobileBodyisPortrait: HomeMobileBodyisPortrait(),
      tabletBodyisPortrait: HomeTabletBodyisPortrait(),
    );
  }
}

// Mobile Size
class HomeMobileBodyisPortrait extends GetView<HomeController> {
  const HomeMobileBodyisPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: MyappBar(fromHeight: screenSize.height * 0.13),
        body: HomeMobileBody(),
      ),
    );
  }
}

class HomeMobileBody extends GetView<HomeController> {
  HomeMobileBody({super.key});

  final List<Widget> _itemList = [
    MyItem(
      icon: const FaIcon(
        FontAwesomeIcons.creditCard,
        color: Colors.white,
        size: 36,
      ),
      text: 'creditCards',
      desc: 'desc_creditCards',
      onTap: () => Get.toNamed(Routes.creditCards),
    ),
    MyItem(
      icon: const FaIcon(
        FontAwesomeIcons.car,
        color: Colors.white,
        size: 36,
      ),
      text: 'drivers',
      desc: 'desc_drivers',
      onTap: () => Get.toNamed(Routes.driver),
    ),
    MyItem(
      icon: const FaIcon(
        FontAwesomeIcons.shop,
        color: Colors.white,
        size: 36,
      ),
      text: 'shops',
      desc: 'desc_shops',
    ),
    MyItem(
      icon: const FaIcon(
        FontAwesomeIcons.moneyCheck,
        color: Colors.white,
        size: 36,
      ),
      text: 'bankchecks',
      desc: 'desc_bankchecks',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        primary: true,
        padding: const EdgeInsets.symmetric(vertical: 5),
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: _itemList.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: const Duration(milliseconds: 2500),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                duration: const Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                child: _itemList[index],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Tablet Size
class HomeTabletBodyisPortrait extends GetView {
  const HomeTabletBodyisPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: MyappBar(),
        body: Center(
          child: Text('Home_tabletBodyisPortrait'),
        ),
      ),
    );
  }
}
