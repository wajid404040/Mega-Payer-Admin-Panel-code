import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';

class OpenCustomBottomSheet {
  final Widget child;
  final Color backgroundColor;
  final bool isNeedMargin;
  final VoidCallback? voidCallback;

  const OpenCustomBottomSheet({required this.child, this.isNeedMargin = true, this.voidCallback, this.backgroundColor = MyColor.colorWhite});

  void customBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColor.transparentColor,
        context: context,
        builder: (BuildContext context) => SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: const Duration(milliseconds: 100),
                curve: Curves.decelerate,
                child: Container(
                  width: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .12),
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
                  decoration: BoxDecoration(color: backgroundColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(4 * 4))),
                  child: child,
                ),
              ),
            )).then((value) {
      voidCallback;
    });
  }
}
