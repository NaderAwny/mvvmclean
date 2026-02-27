import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mvvmclean/presentation/resources/assets_manger.dart';
import 'package:mvvmclean/presentation/resources/color_manger.dart';
import 'package:mvvmclean/presentation/resources/strings_manger.dart';
import 'package:mvvmclean/presentation/resources/styles_mangers.dart';
import 'package:mvvmclean/presentation/resources/value_manger.dart';

enum StateRendererType {
  // popup  states(Dialog)
  popupLoadingState,
  popupErrorStatete,
  //full screen states(full screen)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  //General state
  contentScreenState,
}

// ignore: must_be_immutable
class StateRandrer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryAction;

  StateRandrer({
    super.key,
    required this.stateRendererType,
    this.message = AppStrings.loading,
    this.title = "",
    required this.retryAction,
  });
  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  // ignore: unused_element
  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.loading),
        ]);

      case StateRendererType.popupErrorStatete:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context),
        ]);

      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message),
        ]);

      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.tryAgain, context),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message),
        ]);
      case StateRendererType.contentScreenState:
        return Container();
      // ignore: unreachable_switch_default
      default:
        return Container();
    }
  }

  // popup dialog
  Widget _getPopupDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManger.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(color: Colors.black26)],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  // ignore: unused_element
  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationPath) {
    return SizedBox(
      width: AppSize.s100,
      height: AppSize.s100,
      child: Lottie.asset(animationPath),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: getRegularStyle(
            color: ColorManger.black,
            fontSize: AppSize.s18,
          ),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonText, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (stateRendererType == StateRendererType.fullScreenErrorState) {
               retryAction.call();
              } else {
                //popup error state
       Navigator.of(context).pop();
       
              }
            },

            child: Text(buttonText),
          ),
        ),
      ),
    );
  }
}
