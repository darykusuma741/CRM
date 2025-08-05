import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crm/common/components/custom_connection_status/custom_connection_status.dart';
import 'package:crm/common/components/custom_loading/custom_loading.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.body,
    this.appBar,
    this.light = false,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });
  final bool light;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: light ? Brightness.light : Brightness.dark,
      ),
      child: CustomLoading(
        child: Scaffold(
          appBar: appBar,
          backgroundColor: backgroundColor ?? ColorsName.graySoft,
          body: Column(
            children: [
              if (body != null) Expanded(child: body!),
              CustomConnectionStatus(),
            ],
          ),
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.bottom, this.backgroundColor, this.divider = true, this.toolbarHeight});
  final String title;
  final PreferredSizeWidget? bottom;
  final bool divider;
  final Color? backgroundColor;
  final double? toolbarHeight;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight ?? 56.h,
      backgroundColor: backgroundColor ?? ColorsName.white,
      surfaceTintColor: backgroundColor ?? ColorsName.white,
      title: Text(title, style: BaseText.grayCharcoal.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500)),
      titleSpacing: 0.0,
      titleTextStyle: BaseText.grayCharcoal.copyWith(fontSize: 15.sp),
      leading: IconButton(
        icon: SvgPicture.asset(ImageAssets.iconSvgArrowLeft, width: 16.w, colorFilter: ColorFilter.mode(ColorsName.grayCharcoal, BlendMode.srcIn)),
        onPressed: () => Navigator.pop(context),
      ),
      bottom: bottom ??
          PreferredSize(
            preferredSize: Size.fromHeight(divider ? 0.5.h : 0.0), // Ketebalan border
            child: Container(
              color: ColorsName.grayPale, // Warna border
              height: divider ? 0.5.h : 0.0, // Ketebalan border
            ),
          ),
    );
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight((toolbarHeight ?? 56.h) + bottomHeight);
  }
}
