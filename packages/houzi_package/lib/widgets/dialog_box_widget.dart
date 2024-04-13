import 'package:flutter/material.dart';
import 'package:houzi_package/widgets/custom_widgets/alert_dialog_widget.dart';
import 'generic_text_widget.dart';

Future ShowDialogBoxWidget(
  BuildContext context, {
  required String title,
  TextStyle? style,
  Widget? content,
  List<Widget>? actions,
  EdgeInsetsGeometry actionsPadding = const EdgeInsets.all(0.0),
  double elevation = 5.0,
  TextAlign textAlign = TextAlign.start,
  bool barrierDismissible = true,
}){
  return showDialog(
      useRootNavigator: false,
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialogWidget(
          title: GenericTextWidget(
            title,
            textAlign: textAlign,
            style: style,
          ),
          content: content,
          actionsPadding: actionsPadding,
          elevation: elevation,
          actions: actions,
        );
      });
}