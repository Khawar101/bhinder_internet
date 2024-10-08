import 'package:bhinder_internet/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddDailyExpanseViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void back() {
    _navigationService.back();
  }
}
