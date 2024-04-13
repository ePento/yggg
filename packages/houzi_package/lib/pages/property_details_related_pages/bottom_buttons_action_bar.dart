import 'package:flutter/material.dart';
import 'package:houzi_package/common/constants.dart';
import 'package:houzi_package/files/app_preferences/app_preferences.dart';
import 'package:houzi_package/files/hooks_files/hooks_configurations.dart';
import 'package:houzi_package/files/generic_methods/utility_methods.dart';
import 'package:houzi_package/models/article.dart';
import 'package:houzi_package/pages/send_email_to_realtor.dart';
import 'package:houzi_package/widgets/button_widget.dart';
import 'package:houzi_package/widgets/no_internet_botton_widget.dart';
import 'package:url_launcher/url_launcher.dart';

typedef PropertyProfileBottomButtonActionBarListener = void Function(bool isBottomButtonActionBarDisplayed);

class PropertyProfileBottomButtonActionBar extends StatefulWidget {
  final bool isInternetConnected;
  final Function()? noInternetOnPressed;
  final Map<String, dynamic> realtorInfoMap;
  final Article? article;
  final String agentDisplayOption;
  final String? articleLink;
  final PropertyProfileBottomButtonActionBarListener? profileBottomButtonActionBarListener;

  const PropertyProfileBottomButtonActionBar({
    Key? key,
    this.isInternetConnected = true,
    this.noInternetOnPressed,
    required this.realtorInfoMap,
    required this.article,
    required this.agentDisplayOption,
    this.articleLink,
    this.profileBottomButtonActionBarListener,
  }) : super(key: key);

  @override
  State<PropertyProfileBottomButtonActionBar> createState() => _PropertyProfileBottomButtonActionBarState();
}

class _PropertyProfileBottomButtonActionBarState extends State<PropertyProfileBottomButtonActionBar> {

  int? tempRealtorId;
  String tempRealtorThumbnail = '';
  String tempRealtorEmail = '';
  String tempRealtorName = '';
  String tempRealtorPhone = "";
  String tempRealtorMobile = "";
  String tempRealtorWhatsApp = "";
  String tempRealtorLink = "";
  String agentDisplayOption = "";
  String tempLineApp = "";
  String tempTelegram = "";

  @override
  Widget build(BuildContext context) {
    tempRealtorId = widget.realtorInfoMap[tempRealtorIdKey];
    tempRealtorThumbnail = widget.realtorInfoMap[tempRealtorThumbnailKey] ?? "";
    tempRealtorEmail = widget.realtorInfoMap[tempRealtorEmailKey] ?? "";
    tempRealtorName = widget.realtorInfoMap[tempRealtorNameKey] ?? "";
    tempRealtorPhone = widget.realtorInfoMap[tempRealtorPhoneKey] ?? "";
    tempRealtorMobile = widget.realtorInfoMap[tempRealtorMobileKey] ?? "";
    tempRealtorWhatsApp = widget.realtorInfoMap[tempRealtorWhatsAppKey] ?? "";
    tempRealtorLink = widget.realtorInfoMap[tempRealtorLinkKey] ?? "";
    agentDisplayOption = widget.agentDisplayOption ?? "";
    tempTelegram = widget.realtorInfoMap[tempRealtorTelegramKey] ?? "";
    tempLineApp = widget.realtorInfoMap[tempRealtorLineAppKey] ?? "";

    if(showBottomButtonActionBar()) {
      widget.profileBottomButtonActionBarListener!(true);
      return Positioned(
        bottom: 0.0,
        child: Container(
          decoration: BoxDecoration(
            color: AppThemePreferences().appTheme.backgroundColor!.withOpacity(0.8),
            border: Border(
              top: AppThemePreferences().appTheme.propertyDetailsPageBottomMenuBorderSide!,
            ),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 70,
              child: !widget.isInternetConnected
                  ? NoInternetBottomActionBarWidget(
                      onPressed: () => widget.noInternetOnPressed!)
                  : (showSmallActionButtons())
                      ? SmallActionButtons(
                          article: widget.article,
                          showEmailButton: showEmailActionButton(),
                          showCallButton: showCallActionButton(),
                          showWhatsAppButton: showWhatsappActionButton(),
                          showLineButton: showLineAppActionButton(),
                          showTelegramButton: showTelegramActionButton(),
                          showCallButtonPadding: showCallButtonPadding(),
                          showWhatsAppButtonPadding: showWhatsAppButtonPadding(),
                          showLineButtonPadding: showLineButtonPadding(),
                          showTelegramButtonPadding: showTelegramButtonPadding(),
                          onEmailButtonPressed: onEmailButtonPressed,
                          onCallButtonPressed: onCallButtonPressed,
                          onWhatsAppButtonPressed: onWhatsAppButtonPressed,
                          onLineButtonPressed: onLineAppButtonPressed,
                          onTelegramButtonPressed: onTelegramAppButtonPressed)
                      : LargeActionButtons(
                          article: widget.article,
                          showEmailButton: showEmailActionButton(),
                          showCallButton: showCallActionButton(),
                          showWhatsAppButton: showWhatsappActionButton(),
                          showLineButton: showLineAppActionButton(),
                          showTelegramButton: showTelegramActionButton(),
                          showCallButtonPadding: showCallButtonPadding(),
                          showWhatsAppButtonPadding: showWhatsAppButtonPadding(),
                          showLineButtonPadding: showLineButtonPadding(),
                          showTelegramButtonPadding: showTelegramButtonPadding(),
                          onEmailButtonPressed: onEmailButtonPressed,
                          onCallButtonPressed: onCallButtonPressed,
                          onWhatsAppButtonPressed: onWhatsAppButtonPressed,
                          onLineButtonPressed: onLineAppButtonPressed,
                          onTelegramButtonPressed: onTelegramAppButtonPressed),
            ),
          ),
        ),
      );
    } else {
      widget.profileBottomButtonActionBarListener!(false);
      return Container();
    }
  }

  bool showSmallActionButtons() {
    int trueCount = 0;

    if (showEmailActionButton()) trueCount++;
    if (showCallActionButton()) trueCount++;
    if (showWhatsappActionButton()) trueCount++;
    if (showLineAppActionButton()) trueCount++;
    if (showTelegramActionButton()) trueCount++;

    return trueCount >= 4;
  }

  bool showBottomButtonActionBar() {
    if (showEmailActionButton() ||
        showCallActionButton() ||
        showWhatsappActionButton() ||
        showLineAppActionButton() ||
        showTelegramActionButton()) {
      return true;
    }
    return false;
  }

  bool showEmailActionButton() {
    if (SHOW_EMAIL_BUTTON && UtilityMethods.isValidString(tempRealtorEmail)) {
      return true;
    }

    return false;
  }

  bool showCallActionButton() {
    if (SHOW_CALL_BUTTON &&
        (UtilityMethods.isValidString(tempRealtorPhone) ||
            UtilityMethods.isValidString(tempRealtorMobile))) {
      return true;
    }

    return false;
  }

  bool showWhatsappActionButton() {
    if (SHOW_WHATSAPP_BUTTON &&
        UtilityMethods.isValidString(tempRealtorWhatsApp)) {
      return true;
    }

    return false;
  }

  bool showLineAppActionButton() {
    if (SHOW_LINE_APP_BUTTON && UtilityMethods.isValidString(tempLineApp)) {
      return true;
    }
    return false;
  }

  bool showTelegramActionButton() {
    if (SHOW_TELEGRAM_BUTTON && UtilityMethods.isValidString(tempTelegram)) {
      return true;
    }
    return false;
  }

  bool showCallButtonPadding() {
    int trueCount = 0;
    if (showEmailActionButton()) trueCount++;
    if (showCallActionButton()) trueCount++;
    return trueCount == 2;
  }

  bool showWhatsAppButtonPadding() {
    if (showWhatsappActionButton()) {
      int trueCount = 0;
      if (showEmailActionButton()) trueCount++;
      if (showCallActionButton()) trueCount++;
      if (showWhatsappActionButton()) trueCount++;
      return trueCount >= 2;
    }
    return false;
  }

  bool showLineButtonPadding() {
    if (showLineAppActionButton()) {
      int trueCount = 0;
      if (showEmailActionButton()) trueCount++;
      if (showCallActionButton()) trueCount++;
      if (showWhatsappActionButton()) trueCount++;
      if (showLineAppActionButton()) trueCount++;
      return trueCount >= 2;
    }
    return false;
  }

  bool showTelegramButtonPadding() {
    if (showTelegramActionButton()) {
      int trueCount = 0;
      if (showEmailActionButton()) trueCount++;
      if (showCallActionButton()) trueCount++;
      if (showWhatsappActionButton()) trueCount++;
      if (showLineAppActionButton()) trueCount++;
      if (showTelegramActionButton()) trueCount++;
      return trueCount >= 2;
    }
    return false;
  }

  onEmailButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SendEmailToRealtor(
              informationMap: {
                SEND_EMAIL_APP_BAR_TITLE:
                UtilityMethods.getLocalizedString("enquire_information"),
                SEND_EMAIL_REALTOR_ID: tempRealtorId,
                SEND_EMAIL_REALTOR_NAME: tempRealtorName,
                SEND_EMAIL_REALTOR_EMAIL: tempRealtorEmail,
                SEND_EMAIL_REALTOR_TYPE: agentDisplayOption,
                SEND_EMAIL_MESSAGE: UtilityMethods.getLocalizedString(
                    "hello_i_am_interested_in",
                    inputWords: [
                      UtilityMethods.stripHtmlIfNeeded(widget.article!.title!),
                      widget.articleLink != null && widget.articleLink!.isNotEmpty
                          ? widget.articleLink
                          : widget.article!.link,
                      tempRealtorLink
                    ]),
                SEND_EMAIL_THUMBNAIL: tempRealtorThumbnail,
                SEND_EMAIL_SITE_NAME: APP_NAME,
                SEND_EMAIL_LISTING_ID: widget.article!.id,
                SEND_EMAIL_LISTING_NAME: widget.article!.title,
                SEND_EMAIL_UNIQUE_ID: widget.article!.propertyInfo!.uniqueId!,
                SEND_EMAIL_SOURCE: PROPERTY,
                SEND_EMAIL_LISTING_LINK: widget.articleLink!=null && widget.articleLink!.isNotEmpty ? widget.articleLink:widget.article!.link,
              },
            ),
      ),
    );
  }

  onCallButtonPressed() {
    String num = "";
    if(UtilityMethods.isValidString(tempRealtorPhone)){
      num = tempRealtorPhone;
    }else{
      num = tempRealtorMobile;
    }

    launchUrl(Uri.parse("tel://$num"));
  }

  onWhatsAppButtonPressed() async {
    String msg = getContactMessageString();
    tempRealtorWhatsApp = tempRealtorWhatsApp.replaceAll(RegExp(r'[()\s+-]'), '');
    var whatsappUrl = "whatsapp://send?phone=$tempRealtorWhatsApp&text=$msg";
    await canLaunchUrl(Uri.parse(whatsappUrl))
        ? launchUrl(Uri.parse(whatsappUrl))
        : launchUrl(Uri.parse("https://wa.me/$tempRealtorWhatsApp"));
  }

  onLineAppButtonPressed() async {
    String msg = getContactMessageString();

    // tempLineApp = "hassan6197";
    await launchUrl(Uri.parse("https://line.me/R/ti/p/%7E$tempLineApp"));

    // var lineAppUrl = "https://line.me/R/oaMessage/%40$tempLineApp/?Hi%20there%21";
    // // var lineAppUrl = "https://line.me/R/oaMessage/%40$tempLineApp/?${Uri.encodeQueryComponent(msg)}";
    // await canLaunchUrl(Uri.parse(lineAppUrl))
    //     ? launchUrl(Uri.parse(lineAppUrl))
    //     : launchUrl(Uri.parse("https://line.me/R/ti/p/~$tempLineApp"));


  }

  Future<void> onTelegramAppButtonPressed() async {
    String msg = getContactMessageString();
    // tempTelegram = tempTelegram.replaceAll(RegExp(r'[^\w-]'), '');
    await launchUrl(Uri.parse("https://t.me/$tempTelegram"));
  }

  String getContactMessageString() {
    String msg = UtilityMethods.getLocalizedString(
      "whatsapp_hello_i_am_interested_in",
      inputWords: [
        UtilityMethods.stripHtmlIfNeeded(widget.article!.title!),
        widget.articleLink != null && widget.articleLink!.isNotEmpty
            ? widget.articleLink
            : widget.article!.link,
      ],
    );
    return msg;
  }
}

class SmallActionButtons extends StatelessWidget {
  final Article? article;
  final bool showEmailButton;
  final bool showCallButton;
  final bool showWhatsAppButton;
  final bool showLineButton;
  final bool showTelegramButton;
  final bool showCallButtonPadding;
  final bool showWhatsAppButtonPadding;
  final bool showLineButtonPadding;
  final bool showTelegramButtonPadding;
  final void Function() onEmailButtonPressed;
  final void Function() onCallButtonPressed;
  final void Function() onWhatsAppButtonPressed;
  final void Function() onLineButtonPressed;
  final void Function() onTelegramButtonPressed;
  
  const SmallActionButtons({
    super.key,
    required this.article,
    required this.showEmailButton,
    required this.showCallButton,
    required this.showWhatsAppButton,
    required this.showLineButton,
    required this.showTelegramButton,
    required this.showCallButtonPadding,
    required this.showWhatsAppButtonPadding,
    required this.showLineButtonPadding,
    required this.showTelegramButtonPadding,
    required this.onEmailButtonPressed,
    required this.onCallButtonPressed,
    required this.onWhatsAppButtonPressed,
    required this.onLineButtonPressed,
    required this.onTelegramButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          if (showEmailButton)
            Expanded(
              flex: 1,
              child: emailElevatedButtonWidget(context, article),
            ),
          if (showCallButtonPadding) const SizedBox(width: 5),
          if (showCallButton)
            Expanded(
              flex: 1,
              child: callElevatedButtonWidget(context, article),
            ),
          if (showWhatsAppButtonPadding) const SizedBox(width: 5),
          if (showWhatsAppButton)
            Expanded(
              flex: 1,
              child: whatsappElevatedButtonWidget(context, article),
            ),
          if (showLineButtonPadding) const SizedBox(width: 5),
          if (showLineButton)
            Expanded(
              flex: 1,
              child: lineAppButtonWidget(context, article),
            ),
          if (showTelegramButtonPadding) const SizedBox(width: 5),
          if (showTelegramButton)
            Expanded(flex: 1, child: telegramButtonWidget(context, article)),
        ],
      ),
    );
  }

  Widget emailElevatedButtonWidget(BuildContext context, Article? article){
    return HooksConfigurations.widgetItem(context, article, "small_email_button") ?? SmallButtonWidget(
      onPressed: () => onEmailButtonPressed(),
      color: AppThemePreferences.emailButtonBackgroundColor,
      icon: Icon(
        AppThemePreferences.emailIcon,
        color: AppThemePreferences.filledButtonIconColor,
      ),
    );
  }

  Widget callElevatedButtonWidget(BuildContext context, Article? article) {
    return HooksConfigurations.widgetItem(context, article, "small_call_button") ?? SmallButtonWidget(
      onPressed: () => onCallButtonPressed(),
      color: AppThemePreferences.callButtonBackgroundColor,
      icon: Icon(
        AppThemePreferences.phoneIcon,
        color: AppThemePreferences.filledButtonIconColor,
      ),
    );
  }

  Widget whatsappElevatedButtonWidget(BuildContext context, Article? article) {
    return HooksConfigurations.widgetItem(context, article, "small_whatsapp_button") ?? SmallButtonWidget(
      onPressed: () async => onWhatsAppButtonPressed(),
      color: AppThemePreferences.whatsAppBackgroundColor,
      icon: AppThemePreferences().appTheme.whatsAppIcon,
    );
  }

  Widget lineAppButtonWidget(BuildContext context, Article? article) {
    return HooksConfigurations.widgetItem(context, article, "small_line_button") ?? SmallButtonWidget(
      onPressed: () async => onLineButtonPressed(),
      color: AppThemePreferences.lineAppBackgroundColor,
      icon: AppThemePreferences().appTheme.lineAppIcon,
    );
  }

  Widget telegramButtonWidget(BuildContext context, Article? article) {
    return HooksConfigurations.widgetItem(context, article, "small_telegram_button") ?? SmallButtonWidget(
      onPressed: () async => onTelegramButtonPressed(),
      color: AppThemePreferences.telegramBackgroundColor,
      icon: AppThemePreferences().appTheme.telegramIcon,
    );
  }
}

class LargeActionButtons extends StatelessWidget {
  final Article? article;
  final bool showEmailButton;
  final bool showCallButton;
  final bool showWhatsAppButton;
  final bool showLineButton;
  final bool showTelegramButton;
  final bool showCallButtonPadding;
  final bool showWhatsAppButtonPadding;
  final bool showLineButtonPadding;
  final bool showTelegramButtonPadding;
  final void Function() onEmailButtonPressed;
  final void Function() onCallButtonPressed;
  final void Function() onWhatsAppButtonPressed;
  final void Function() onLineButtonPressed;
  final void Function() onTelegramButtonPressed;

  const LargeActionButtons({
    super.key,
    required this.article,
    required this.showEmailButton,
    required this.showCallButton,
    required this.showWhatsAppButton,
    required this.showLineButton,
    required this.showTelegramButton,
    required this.showCallButtonPadding,
    required this.showWhatsAppButtonPadding,
    required this.showLineButtonPadding,
    required this.showTelegramButtonPadding,
    required this.onEmailButtonPressed,
    required this.onCallButtonPressed,
    required this.onWhatsAppButtonPressed,
    required this.onLineButtonPressed,
    required this.onTelegramButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          if (showEmailButton)
            Expanded(
              flex: 1,
              child: emailElevatedButtonWidget(context, article),
            ),
          if (showCallButtonPadding) const SizedBox(width: 5),
          if (showCallButton)
            Expanded(
              flex: 1,
              child: callElevatedButtonWidget(context, article),
            ),
          if (showWhatsAppButtonPadding) const SizedBox(width: 5),
          if (showWhatsAppButton)
            Expanded(
              flex: 1,
              child: whatsappElevatedButtonWidget(context, article),
            ),
          if (showLineButtonPadding) const SizedBox(width: 5),
          if (showLineButton)
            Expanded(
              flex: 1,
              child: lineAppButtonWidget(context, article),
            ),
          if (showTelegramButtonPadding) const SizedBox(width: 5),
          if (showTelegramButton)
            Expanded(flex: 1, child: telegramButtonWidget(context, article)),
        ],
      ),
    );
  }

  Widget emailElevatedButtonWidget(BuildContext context, Article? article){
    return HooksConfigurations.widgetItem(context, article, "email_button") ?? ButtonWidget(
      maxLines: 1,
      padding: EdgeInsets.symmetric(horizontal: 20),
      iconPadding: EdgeInsets.symmetric(horizontal: 8),
      text: UtilityMethods.getLocalizedString("email_capital"),
      fontSize: AppThemePreferences.bottomActionBarFontSize,
      icon: Icon(
        AppThemePreferences.emailIcon,
        color: AppThemePreferences.filledButtonIconColor,
      ),
      onPressed: () => onEmailButtonPressed(),
      // centeredContent: true,
    );
  }

  Widget callElevatedButtonWidget(BuildContext context, Article? article) {
    return HooksConfigurations.widgetItem(context, article, "call_button") ?? ButtonWidget(
      maxLines: 1,
      text: UtilityMethods.getLocalizedString("call_capital"),
      fontSize: AppThemePreferences.bottomActionBarFontSize,
      icon: Icon(
        AppThemePreferences.phoneIcon,
        color: AppThemePreferences.filledButtonIconColor,
      ),
      onPressed: () => onCallButtonPressed(),
      color: AppThemePreferences.callButtonBackgroundColor,
      // centeredContent: true,
    );
  }

  Widget whatsappElevatedButtonWidget(BuildContext context, Article? article) {
    return HooksConfigurations.widgetItem(context, article, "whatsapp_button") ?? ButtonWidget(
      maxLines: 1,
      padding: EdgeInsets.symmetric(horizontal: 12),
      iconPadding: EdgeInsets.symmetric(horizontal: 4),
      text: UtilityMethods.getLocalizedString("whatsapp"),
      icon: AppThemePreferences().appTheme.whatsAppIcon,
      fontSize: AppThemePreferences.bottomActionBarFontSize,
      color: AppThemePreferences.whatsAppBackgroundColor,
      onPressed: () async => onWhatsAppButtonPressed(),
    );
  }

  Widget lineAppButtonWidget(BuildContext context, Article? article) {
    return HooksConfigurations.widgetItem(context, article, "line_button") ?? ButtonWidget(
      maxLines: 1,
      mainAxisAlignment: MainAxisAlignment.start,
      padding: EdgeInsets.symmetric(horizontal: 20),
      iconPadding: EdgeInsets.symmetric(horizontal: 5),
      text: UtilityMethods.getLocalizedString("Line"),
      icon: AppThemePreferences().appTheme.lineAppIcon,
      fontSize: AppThemePreferences.bottomActionBarFontSize,
      color: AppThemePreferences.lineAppBackgroundColor,
      onPressed: () async => onLineButtonPressed(),
    );
  }

  Widget telegramButtonWidget(BuildContext context, Article? article) {
    return HooksConfigurations.widgetItem(context, article, "telegram_button") ?? ButtonWidget(
      maxLines: 1,
      padding: EdgeInsets.symmetric(horizontal: 10),
      iconPadding: EdgeInsets.symmetric(horizontal: 4),
      text: UtilityMethods.getLocalizedString("Telegram"),
      icon: AppThemePreferences().appTheme.telegramIcon,
      fontSize: AppThemePreferences.bottomActionBarFontSize,
      color: AppThemePreferences.telegramBackgroundColor,
      onPressed: () async => onTelegramButtonPressed(),
    );
  }
}

class SmallButtonWidget extends StatelessWidget {
  final Widget? icon;
  final Color? color;
  final void Function() onPressed;
  final double? buttonHeight;
  final double buttonWidth;
  final ButtonStyle? buttonStyle;

  const SmallButtonWidget({
    super.key,
    required this.onPressed,
    this.icon,
    this.color,
    this.buttonHeight = 50.0,
    this.buttonWidth = double.infinity,
    // this.buttonWidth = 50,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [if (icon != null) icon!],
        ),

        style: buttonStyle ?? ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0.0, backgroundColor: color ?? AppThemePreferences.actionButtonBackgroundColor,
        ),
      ),
    );
  }
}