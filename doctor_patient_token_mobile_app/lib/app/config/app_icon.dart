import 'package:flutter/widgets.dart';
import 'app_image.dart';

// Use this class for import any icon or image in the application
abstract class AppIcon {
  AppIcon._();

  static const String _assetPath = "assets/icons/";

  static AppIconBuilder get icAppIcon =>
      AppIconBuilder('${_assetPath}ic_app_icon.svg');

  static AppIconBuilder get iconNoData =>
      AppIconBuilder('${_assetPath}ic_no_data.svg');

  static AppIconBuilder get icCalender =>
      AppIconBuilder('${_assetPath}calendar.svg');

  static AppIconBuilder get leftArrowIcon =>
      AppIconBuilder('${_assetPath}ic_left_arrow.svg');

  static AppIconBuilder get uploadIcon =>
      AppIconBuilder('${_assetPath}ic_upload_icon.svg');
  static AppIconBuilder get navHome =>
      AppIconBuilder('${_assetPath}ic_nav_home.svg');

  static AppIconBuilder get navBookAppointment =>
      AppIconBuilder('${_assetPath}ic_nav_calendar.svg');

  static AppIconBuilder get navSetting =>
      AppIconBuilder('${_assetPath}ic_nav_setting.svg');

  static AppIconBuilder get dropDown =>
      AppIconBuilder('${_assetPath}ic_drop_down.svg');

  static AppIconBuilder get swipe =>
      AppIconBuilder('${_assetPath}ic_bottom_sheet_swipe.svg');

  static AppIconBuilder get confirm =>
      AppIconBuilder('${_assetPath}ic_done.svg');

  static AppIconBuilder get phone =>
      AppIconBuilder('${_assetPath}ic_phone.svg');

  static AppIconBuilder get rightArrowIcon =>
      AppIconBuilder('${_assetPath}ic_right_arrow.svg');

  static AppIconBuilder get closeIcon =>
      AppIconBuilder('${_assetPath}ic_close.svg');

  static AppIconBuilder get dropUp =>
      AppIconBuilder('${_assetPath}ic_drop_up.svg');

  static AppIconBuilder get notification =>
      AppIconBuilder('${_assetPath}ic_notification.svg');

  static AppIconBuilder get filter =>
      AppIconBuilder('${_assetPath}ic_filter.svg');

  static AppIconBuilder get moon =>
      AppIconBuilder('${_assetPath}moon.svg');

  static AppIconBuilder get checking =>
      AppIconBuilder('${_assetPath}ic_checking.svg');

  static AppIconBuilder get unSelectedChecking =>
      AppIconBuilder('${_assetPath}ic_unselected_checking.svg');

  static AppIconBuilder get googleButton =>
      AppIconBuilder('${_assetPath}google_icon.svg');

}

class AppIconBuilder {
  final String assetPath;

  AppIconBuilder(this.assetPath);

  Widget widget({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    Color? color,
    BorderRadius? borderRadius,
    Widget? placeholder,
    String? errorImageUrl,
    int? memCacheHeight,
  }) {
    return ImageBuilder(
      assetPath,
      key: key,
      width: width,
      height: height,
      fit: fit,
      color: color,
      alignment: alignment,
      placeholder: placeholder,
      errorImageUrl: errorImageUrl,
      memCacheHeight: memCacheHeight,
    );
  }
}
