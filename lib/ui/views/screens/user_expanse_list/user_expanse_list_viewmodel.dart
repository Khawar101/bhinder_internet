import 'package:bhinder_internet/app/app.locator.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserExpanseListViewModel extends BaseViewModel {
final _navigationService = locator<NavigationService>();
   void back() {
    _navigationService.back();
  }

  // Sample list of expenses
  List<UserData> expenses = [
    UserData(userName: 'Lunch', fees: 150.0, dateTime: DateTime.now()),
    UserData(
        userName: 'Groceries',
        fees: 500.0,
        dateTime: DateTime.now().subtract(Duration(days: 1))),
    UserData(
        userName: 'Fuel',
        fees: 1200.0,
        dateTime: DateTime.now().subtract(Duration(days: 2))),
  ];

  // Format date and time
  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }
}


class UserData {
  final String userName;
  final double fees;
  final DateTime dateTime;

  UserData({
    required this.userName,
    required this.fees,
    required this.dateTime,
  });
}