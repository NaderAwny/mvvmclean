import 'dart:async';
import 'package:mvvmclean/domain/model/models.dart';
import 'package:mvvmclean/presentation/base/baseviewmodel.dart';
import 'package:mvvmclean/presentation/resources/assets_manger.dart';
import 'package:mvvmclean/presentation/resources/strings_manger.dart';

class OnBoardingViewModel extends BaseViewModel
    implements OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controllers outputs
  // ignore: unused_field
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  // ignore: unused_field
  late final List<SliderObject> _list;

  int _currentIndex = 0;

  //OnBoarding ViewModel Inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    //implement start
    // call any data
    _list = getSliderData();
    _postDataToView();
  }

  @override
  int goPrevious() {
    //  implement goPrevious
    int prviosIndex = --_currentIndex;
    if (prviosIndex == -1) {
      prviosIndex = _list.length - 1;
    }
    return prviosIndex;
  }

  @override
  void onPageChanged(int index) {
    //implement onPageChanged
    _currentIndex = index;
    _postDataToView();
  }

  @override
  int goNext() {
    // implement goNext
    // ignore: non_constant_identifier_names
    int NextIndex = ++_currentIndex;
    if (NextIndex == _list.length) {
      NextIndex = 0;
    }
    return NextIndex;
  }

  @override
  // implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  //  implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject =>
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
      _streamController.stream.map((SliderViewObject) => SliderViewObject);
  //function private
  void _postDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(_list[_currentIndex], _list.length, _currentIndex),
    );
  }

  List<SliderObject> getSliderData() {
    return [
      SliderObject(
        AppStrings.onBoardingTitle1,
        AppStrings.onBoardingSubTitle1,
        ImageAssets.onboardingLogo1,
      ),
      SliderObject(
        AppStrings.onBoardingTitle2,
        AppStrings.onBoardingSubTitle2,
        ImageAssets.onboardingLogo2,
      ),
      SliderObject(
        AppStrings.onBoardingTitle3,
        AppStrings.onBoardingSubTitle3,
        ImageAssets.onboardingLogo3,
      ),
      SliderObject(
        AppStrings.onBoardingTitle4,
        AppStrings.onBoardingSubTitle4,
        ImageAssets.onboardingLogo4,
      ),
    ];
  }
}

// inputs mean that "Orders" that our view model will receive from view
abstract class OnBoardingViewModelInputs {
  int goNext(); // when user clicks on right arrow or swipe left
  int goPrevious(); // when user clicks on left arrow or swipe right
  void onPageChanged(int index);
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}
