import 'package:bhinder_internet/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddUserDataViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void back() {
    _navigationService.back();
  }

  bool isPaidSelected = true; // Default to 'Paid' selected

  void togglePaymentSelection(bool paidSelected) {
    isPaidSelected = paidSelected;
    notifyListeners(); // Updates the UI when the selection changes
  }
}
