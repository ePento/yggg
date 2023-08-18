import 'package:houzi/hooks_v2.dart';
import 'package:houzi_package/houzi_main.dart' as houzi_package;
import 'Hooks.dart';
Future<void> main() async {

  //depricated, no longer used.
  Map<String,dynamic> hooksMap = {};
  HooksV2 v2Hooks = HooksV2();
  hooksMap["headers"] = v2Hooks.getHeaderMap();
  hooksMap["propertyDetailPageIcons"] = v2Hooks.getPropertyDetailPageIconsMap();
  hooksMap["elegantHomeTermsIcons"] = v2Hooks.getElegantHomeTermsIconMap();
  hooksMap["drawerItems"] = v2Hooks.getDrawerItems();
  hooksMap["fonts"] = v2Hooks.getFontHook();
  hooksMap["propertyItem"] = v2Hooks.getPropertyItemHook();
  hooksMap["termItem"] = v2Hooks.getTermItemHook();
  hooksMap["agentItem"] = v2Hooks.getAgentItemHook();
  hooksMap["agencyItem"] = v2Hooks.getAgencyItemHook();
  hooksMap["widgetItems"] = v2Hooks.getWidgetHook();
  hooksMap["languageNameAndCode"] = v2Hooks.getLanguageCodeAndName();
  hooksMap["defaultLanguageCode"] = v2Hooks.getDefaultLanguageHook();
  hooksMap["defaultHomePage"] = v2Hooks.getDefaultHomePageHook();
  hooksMap["defaultCountryCode"] = v2Hooks.getDefaultCountryCodeHook();
  hooksMap["settingsOption"] = v2Hooks.getSettingsItemHook();
  hooksMap["profileItem"] = v2Hooks.getProfileItemHook();
  hooksMap["homeRightBarButtonWidget"] = v2Hooks.getHomeRightBarButtonWidgetHook();
  hooksMap["markerTitle"] = v2Hooks.getMarkerTitleHook();
  hooksMap["markerIcon"] = v2Hooks.getMarkerIconHook();
  hooksMap["customMapMarker"] = v2Hooks.getCustomMarkerHook();
  hooksMap["priceFormatter"] = v2Hooks.getPriceFormatterHook();
  hooksMap["compactPriceFormatter"] = v2Hooks.getCompactPriceFormatterHook();
  hooksMap["textFormFieldCustomizationHook"] = v2Hooks.getTextFormFieldCustomizationHook();
  hooksMap["textFormFieldWidgetHook"] = v2Hooks.getTextFormFieldWidgetHook();
  hooksMap["customSegmentedControlHook"] = v2Hooks.getCustomSegmentedControlHook();
  hooksMap["drawerHeaderHook"] = v2Hooks.getDrawerHeaderHook();
  hooksMap["hidePriceHook"] = v2Hooks.getHidePriceHook();
  hooksMap["hideEmptyTerm"] = v2Hooks.hideEmptyTerm();
  hooksMap["customMapMarker"] = v2Hooks.getCustomMarkerHook();
  hooksMap["homeSliverAppBarBodyHook"] = v2Hooks.getHomeSliverAppBarBodyHook();
  hooksMap["homeWidgetsHook"] = v2Hooks.getHomeWidgetsHook();
  return houzi_package.main("assets/configurations/configurations.json", hooksMap);
}



