import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:karpardaz/core/values/values.dart';

// Widget
import 'widget.dart';

class MyappBar extends StatelessWidget implements PreferredSizeWidget {
  const MyappBar({
    super.key,
    this.fromHeight = 30,
  });

  final double fromHeight;

  @override
  Size get preferredSize => Size.fromHeight(fromHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fromHeight,
      decoration: BoxDecoration(
          // color: Colors.orange,
          gradient: const LinearGradient(
            colors: [Color(0xffFE8910), Color(0xffFFBB29)],
            tileMode: TileMode.decal,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 0.5),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: AnimationLimiter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 2500),
                childAnimationBuilder: (widget) => FadeInAnimation(
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: const Duration(milliseconds: 2500),
                      child: widget,
                    ),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyTitle(
                        text: Languages.translateDate(),
                      ),
                      MyTitle(
                        text: 'karpardaz'.tr,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Languages().changeLanguage(),
                    icon: const FaIcon(
                      FontAwesomeIcons.language,
                      color: Colors.white,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
