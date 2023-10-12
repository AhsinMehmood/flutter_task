import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final Color backgrouColor;
  final Icon? leadingIcon;
  final Text title;
  final Widget? iconOne;
  final Widget? iconTwo;

  const CustomAppBar({
    super.key,
    required this.backgrouColor,
    required this.iconOne,
    required this.iconTwo,
    required this.title,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //  width: Get.width,
      padding: const EdgeInsets.only(left: 20, right: 15, bottom: 20, top: 20),
      //  height: 90,
      color: backgrouColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leadingIcon != null) leadingIcon!,
              title,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (iconOne != null) iconOne!,
                  if (iconTwo != null) iconTwo!,
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
