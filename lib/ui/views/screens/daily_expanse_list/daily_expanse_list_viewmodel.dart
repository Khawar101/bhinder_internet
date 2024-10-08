import 'package:bhinder_internet/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';

class DailyExpanseListViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void back() {
    _navigationService.back();
  }

  // Sample list of expenses
  List<DailyExpense> expenses = [
    DailyExpense(description: 'Lunch', amount: 150.0, dateTime: DateTime.now()),
    DailyExpense(
        description: 'Groceries',
        amount: 500.0,
        dateTime: DateTime.now().subtract(Duration(days: 1))),
    DailyExpense(
        description: 'Fuel',
        amount: 1200.0,
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

class DailyExpense {
  final String description;
  final double amount;
  final DateTime dateTime;

  DailyExpense({
    required this.description,
    required this.amount,
    required this.dateTime,
  });
}
