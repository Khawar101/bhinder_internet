import 'dart:developer';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:bhinder_internet/app/app.locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DailyExpanseListViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  List<DailyExpense> expenses = [];
  String selectedMonth = DateFormat('MMMM yyyy').format(DateTime.now()); // Set default to the current month

  DailyExpanseListViewModel() {
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped, // Handle tap on notification
    );
  }

  void back() {
    _navigationService.back();
  }

  // Fetch data from Firestore
  Future<void> fetchExpenses() async {
    setBusy(true);
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('daily_expenses')
          .orderBy('date', descending: true) // Order by date in descending order
          .get();

      expenses = snapshot.docs.map((doc) {
        return DailyExpense(
          id: doc.id, 
          description: doc['description'],
          amount: doc['payment'],
          dateTime: (doc['date'] as Timestamp).toDate(),
          name: doc['name'] ?? 'No Name',
        );
      }).toList();
    } catch (e) {
      log('Error fetching expenses: $e');
    } finally {
      setBusy(false); // Set busy state to false when done
      notifyListeners(); // Ensure the UI updates with new data
    }
  }

  // delete index 
  // Add this method to your DailyExpanseListViewModel
Future<void> deleteExpense(int index) async {
  if (index < 0 || index >= expenses.length) {
    log('Invalid index for deletion');
    return;
  }

  // Get the expense to be deleted
  DailyExpense expenseToDelete = expenses[index];

  // Delete from Firestore
  try {
    // Assuming you have a document ID for each expense stored in Firestore
    await _firestore.collection('daily_expenses').doc(expenseToDelete.id).delete(); // Modify if you have a different way to get the document ID
    log('Deleted expense: ${expenseToDelete.description}');

    // Remove from local list
    expenses.removeAt(index);

    // Notify listeners to update the UI
    notifyListeners();
  } catch (e) {
    log('Error deleting expense: $e');
  }
}


  // Format date and time
  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  // Filter expenses by month
  List<DailyExpense> getExpensesByMonth(DateTime selectedMonth) {
    return expenses.where((expense) =>
        expense.dateTime.year == selectedMonth.year &&
        expense.dateTime.month == selectedMonth.month).toList();
  }

  // Export filtered expenses to Excel
  Future<void> exportToExcel(DateTime selectedMonth) async {
    List<DailyExpense> filteredExpenses = getExpensesByMonth(selectedMonth);
    var excel = Excel.createExcel(); // Create a new Excel document
    Sheet sheetObject = excel['Expenses'];

    // Add headers
    sheetObject.appendRow(['Name', 'Description', 'Amount', 'Date']);

    // Add rows of data
    for (var expense in filteredExpenses) {
      sheetObject.appendRow([
        expense.name,
        expense.description,
        expense.amount,
        DateFormat('dd MMM yyyy').format(expense.dateTime),
      ]);
    }

    // Save the Excel file
    var bytes = excel.save();
    if (bytes == null) return;

    // Request storage permissions
    var status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        // Get the external storage directory
        Directory directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory() ?? Directory.systemTemp;
        }

        String filePath = '${directory.path}/expenses_${selectedMonth.month}_${selectedMonth.year}.xlsx';

        // Write the file
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(bytes);
        log('Excel file saved at: $filePath');

        // Show notification for successful download
        await _showDownloadNotification(filePath);
      } catch (e) {
        log('Error saving Excel file: $e');
      }
    } else {
      log('Storage permission denied');
    }
  }

  // Show download notification
  Future<void> _showDownloadNotification(String filePath) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id', // Replace with your actual channel ID
      'your_channel_name', // Replace with your actual channel name
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'File Downloaded',
      'Your expenses file has been downloaded.',
      platformChannelSpecifics,
      payload: filePath, // Pass the file path to the payload
    );
  }

  // Handle notification tap
  Future<void> _onNotificationTapped(NotificationResponse notificationResponse) async {
    String? payload = notificationResponse.payload;
    if (payload != null) {
      // Open the file using the file path received in the payload
      File file = File(payload);
      if (await file.exists()) {
        // Open the file using the 'open_file' package
        OpenFile.open(payload); // Add the open_file package in your pubspec.yaml
      }
    }
  }

  void setSelectedMonth(String month) {
    selectedMonth = month;
    notifyListeners();
  }


  //delete index
  
}

class DailyExpense {
  final String id;
  final String name;
  final String description;
  final double amount;
  final DateTime dateTime;

  DailyExpense({
    required this.id, 
    required this.name,
    required this.description,
    required this.amount,
    required this.dateTime,
  });
}
