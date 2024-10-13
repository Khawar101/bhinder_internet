import 'package:bhinder_internet/app/app.locator.dart';
import 'package:bhinder_internet/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  // final _dialogService = locator<DialogService>();
  // final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  void addDailyExpanse() {
    _navigationService.navigateToAddDailyExpanseView();
  }

  void dailyExpanseList() {
    _navigationService.navigateToDailyExpanseListView();
  }

  void addDailyUser() {
    _navigationService.navigateToAddUserDataView();
  }


void userList() {
    _navigationService.navigateToUserExpanseListView();
  }
  // String get counterLabel => 'Counter is: $_counter';

  // int _counter = 0;

  // void incrementCounter() {
  //   _counter++;
  //   rebuildUi();
  // }

  // void showDialog() {
  //   _dialogService.showCustomDialog(
  //     variant: DialogType.infoAlert,
  //     title: 'Stacked Rocks!',
  //     description: 'Give stacked $_counter stars on Github',
  //   );
  // }

  // void showBottomSheet() {
  //   _bottomSheetService.showCustomSheet(
  //     variant: BottomSheetType.notice,
  //     title: ksHomeBottomSheetTitle,
  //     description: ksHomeBottomSheetDescription,
  //   );
  // }
}
