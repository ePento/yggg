import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:houzi_package/files/app_preferences/app_preferences.dart';
import 'package:houzi_package/widgets/no_result_error_widget.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:houzi_package/files/generic_methods/utility_methods.dart';


class FullScreenImageView extends StatefulWidget{
  final List<String> imageUrls;
  final String tag;
  final bool floorPlan;

  @override
  State<StatefulWidget> createState() => _FullScreenImageViewState();

  FullScreenImageView({
    required this.imageUrls,
    required this.tag,
    required this.floorPlan,
  });

}

class _FullScreenImageViewState extends State<FullScreenImageView> {

  PageController pageController = PageController();
  String dummyImage = "https://images.wallpaperscraft.com/image/surface_dark_background_texture_50754_1920x1080.jpg";

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppThemePreferences.homeScreenStatusBarColorDark,
        statusBarIconBrightness: AppThemePreferences.statusBarIconBrightnessLight,
      ),
      // value: AppThemePreferences().appTheme.systemUiOverlayStyle,
      child: Scaffold(
        backgroundColor: AppThemePreferences.backgroundColorDark,
        body: widget.imageUrls[0] != null ? Stack(
          children: [
            InteractiveViewer(
              child: Center(
                child: widget.floorPlan == true ?
                imageListPageView(list: widget.imageUrls)
                : Hero(
                  tag: widget.tag,
                  child: imageListPageView(list: widget.imageUrls),
                ),
              ),
            ),
            widget.floorPlan == true ? Container() : imageIndicatorsWidget(list: widget.imageUrls),
            backNavigationIconButton(),
          ],
        ) : noResultFoundPage(),

      ),
    );
  }

  Widget imageListPageView({
  required List<String> list,
}){
    return PageView(
      controller: pageController,
      children: List.generate(
          list.length, (index) => FadeInImage.assetNetwork(
          placeholder: cupertinoActivityIndicatorSmall,
          image: list[index],
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
      ),

    );
  }

  Widget imageIndicatorsWidget({
    required List<String> list,
  }){
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Center(
        child: list.length > 1 ? SmoothPageIndicator(
          controller: pageController,
          count: list.length,
          effect: SlideEffect(
            dotHeight: 12.0,
            dotWidth: 12.0,
            spacing: 12,
            activeDotColor: AppThemePreferences().appTheme.primaryColor!,
          ),
        ) : Container(),
      ),
    );
  }

  Widget backNavigationIconButton(){
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 10,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: CircleAvatar(
          backgroundColor: AppThemePreferences().appTheme.propertyDetailsPageTopBarIconsBackgroundColor,
          child: IconButton(
            icon: Icon(AppThemePreferences.arrowBackIcon),
            color: AppThemePreferences().appTheme.propertyDetailsPageTopBarIconsColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  Widget noResultFoundPage() {
    return NoResultErrorWidget(
      backgroundColor: AppThemePreferences.backgroundColorDark,
      headerErrorText: UtilityMethods.getLocalizedString("no_image_found"),
      showBackNavigationIcon: true,
    );
  }
}