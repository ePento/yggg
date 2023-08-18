import 'package:flutter/material.dart';

import '../../files/app_preferences/app_preferences.dart';
import '../generic_text_widget.dart';

Future genericBottomSheetWidget({
  required BuildContext context,
  ShapeBorder shape = const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  required Widget Function(BuildContext) builder,
}){
  return showModalBottomSheet(
      shape: shape,
      context: context,
      builder: builder,
  );
}

Widget genericBottomSheetTitleWidget({
  required BuildContext context,
  required String title,
  TextAlign textAlign = TextAlign.center,
  TextStyle? style,
  EdgeInsetsGeometry padding = const EdgeInsets.all(0.0),
  Decoration? decoration,
}){
  return Container(
    padding: padding,
    decoration: decoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GenericTextWidget(
                title,
                textAlign: textAlign,
                strutStyle: StrutStyle(height: AppThemePreferences.bottomSheetMenuTitle01TextHeight),
                style: style ?? AppThemePreferences().appTheme.bottomSheetMenuTitle01TextStyle,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget genericBottomSheetSubTitleWidget({
  required BuildContext context,
  required String subTitle,
  TextAlign textAlign = TextAlign.center,
  TextStyle? style,
  EdgeInsetsGeometry padding = const EdgeInsets.all(0.0),
  Decoration? decoration,
}){
  return Container(
    padding: padding,
    decoration: decoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GenericTextWidget(
                  subTitle,
                  textAlign: textAlign,
                  style: style ?? AppThemePreferences().appTheme.bottomSheetMenuSubTitleTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget genericBottomSheetOptionWidget({
  required String label,
  required Function() onPressed,
  TextStyle? style,
}){
  return SizedBox(
    height: 60,
    width: double.infinity,
    child: Container(
      child: TextButton(
        onPressed: onPressed,
        child: GenericTextWidget(label, style: style ?? AppThemePreferences().appTheme.heading02TextStyle),
      ),
      decoration: AppThemePreferences.dividerDecoration(),
    ),
  );
}