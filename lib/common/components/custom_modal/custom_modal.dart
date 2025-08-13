import 'package:flutter/material.dart';
import 'package:crm/common/components/custom_modal/animation_icon_dialog.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';

class CustomModal {
  BuildContext context;
  String title;
  String subTitle;

  CustomModal(
    this.context, {
    required this.title,
    required this.subTitle,
  });

  Future success() async {
    await _createDialog(ImageAssets.iconSvgCheckWhite, ColorsName.greenMint);
  }

  Future warning() async {
    await _createDialog(ImageAssets.iconWarningWhite, ColorsName.yellowSun);
  }

  Future danger() async {
    await _createDialog(ImageAssets.iconSvgErrorWhite, ColorsName.redCrimson);
  }

  Future _createDialog(String imageIcon, Color? color) async {
    final sizeCheck = 70.0;
    final padding = 16.0;

    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Center(
          child: AnimatedIconDialog(
            title: title,
            subTitle: subTitle,
            imageIcon: imageIcon,
            color: color,
            sizeCheck: sizeCheck,
            padding: padding,
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: curvedAnimation,
            child: child,
          ),
        );
      },
    );
  }
}
