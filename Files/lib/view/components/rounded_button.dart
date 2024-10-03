import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/my_color.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  final bool isOutlined;
  final Color borderColor;
  const RoundedButton({
    Key? key,
    this.width = 1,
    this.cornerRadius = 2,
    required this.text,
    required this.press,
    this.isOutlined = false,
    this.horizontalPadding = 35,
    this.verticalPadding = 18,
    this.color = MyColor.primaryColor,
    this.textColor = Colors.white,
    this.borderColor = MyColor.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isOutlined
        ? Material(
            child: InkWell(
              onTap: press,
              splashColor: MyColor.bgColor2,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                  width: size.width * width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(cornerRadius), border: Border.all(color: borderColor), color: color),
                  child: Center(
                      child: Text(
                    text.tr,
                    style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500),
                  ))),
            ),
          )
        : SizedBox(
            width: size.width * width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadius),
              child: ElevatedButton(
                onPressed: press,
                style: ElevatedButton.styleFrom(backgroundColor: color, shadowColor: MyColor.transparentColor, padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding), textStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
                child: Text(
                  text.tr,
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          );
  }
}
