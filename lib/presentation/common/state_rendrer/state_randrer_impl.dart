// ignore_for_file: type_literal_in_constant_pattern
import 'package:flutter/material.dart';
import 'package:mvvmclean/app/constants.dart';
import 'package:mvvmclean/presentation/common/state_rendrer/state_randrer.dart';
import 'package:mvvmclean/presentation/resources/strings_manger.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}
//loading state(popup or full screen)

class LoadingState implements FlowState {
  final StateRendererType stateRendererType;
  String? message;
  LoadingState({
    required this.stateRendererType,
    this.message = AppStrings.loading,
  });
  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//error state(popup or full screen)
class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;
  ErrorState(this.stateRendererType, this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//content state
class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;
}

//empty state(full screen)
class EmptyState extends FlowState {
  final String message;
  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  // ignore: body_might_complete_normally_nullable
  Widget? getScreenWidget(
    BuildContext context,
    Widget contentWidget,
    Function retryActionFunction,
  ) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            //popup loading state
            showPopup(context, getStateRendererType(), getMessage());

            //content screen state
            return contentWidget;
          } else {
            return StateRandrer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryAction: retryActionFunction,
            );
          }
        }
      //error state
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorStatete) {
            //popup loading state
            showPopup(context, getStateRendererType(), getMessage());

            //content screen state
            return contentWidget;
          } else {
            return StateRandrer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryAction: retryActionFunction,
            );
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentWidget;
        }
      case EmptyState:
        {
          return StateRandrer(
            retryAction: () {},
            stateRendererType: getStateRendererType(),
            message: getMessage(),
          );
        }
      default:
        {
          dismissDialog(context);
          return contentWidget;
        }
    }
  }

  // ignore: strict_top_level_inference
  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
  // ignore: strict_top_level_inference
  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  // ignore: strict_top_level_inference
  showPopup(
    BuildContext context,
    StateRendererType stateRandererType,
    String messge,
  ) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (context) => StateRandrer(
          message: messge,
          retryAction: () {},
          stateRendererType: stateRandererType,
        ),
      ),
    );
  }
}
