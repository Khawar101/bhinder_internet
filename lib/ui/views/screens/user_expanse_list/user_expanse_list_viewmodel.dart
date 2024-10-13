import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bhinder_internet/app/app.locator.dart';
import 'package:excel/excel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserExpanseListViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  List<UserData> paidUsers = [];
  List<UserData> unpaidUsers = [];

  // To hold the filtered users during search
  List<UserData> filteredPaidUsers = [];
  List<UserData> filteredUnpaidUsers = [];

  String searchQueryPaid = "";
  String searchQueryUnpaid = "";

  void back() {
    _navigationService.back();
  }

  // Fetch Paid Users from Firestore
  Future<void> fetchPaidUsers() async {
    setBusy(true);
    try {
      QuerySnapshot snapshot = await _firestore.collection('paid_users').get();
      paidUsers = snapshot.docs.map((doc) {
        return UserData(
          id: doc.id,
          userName: doc['name'],
          fees: doc['payment'],
          speed: doc['speed'],
          dateTime: (doc['date'] as Timestamp).toDate(),
        );
      }).toList();
      filteredPaidUsers = paidUsers;
      // notifyListeners(); // Notify the UI to rebuild
    } catch (e) {
      log('Error fetching paid users: $e');
    } finally {
      setBusy(false); // Set busy state to false when done
      notifyListeners(); // Ensure the UI updates with new data
    }
  }

  // Fetch Unpaid Users from Firestore
  Future<void> fetchUnpaidUsers() async {
    setBusy(true);
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('unpaid_users').get();
      unpaidUsers = snapshot.docs.map((doc) {
        return UserData(
          id: doc.id,
          userName: doc['name'],
          fees: doc['payment'],
          speed: doc['speed'],
          dateTime: (doc['date'] as Timestamp).toDate(),
        );
      }).toList();
      filteredUnpaidUsers = unpaidUsers;
      // notifyListeners(); // Notify the UI to rebuild
    } catch (e) {
      log('Error fetching unpaid users: $e');
    } finally {
      setBusy(false); // Set busy state to false when done
      notifyListeners(); // Ensure the UI updates with new data
    }
  }

  // Update payment status and move the user between lists
  Future<void> updateUserStatus(UserData user, bool isPaid) async {
    try {
      if (isPaid) {
        // Move user from unpaid to paid list
        await _firestore.collection('unpaid_users').doc(user.id).delete();
        await _firestore.collection('paid_users').add({
          'name': user.userName,
          'payment': user.fees,
          'speed': user.speed,
          'date': Timestamp.fromDate(user.dateTime),
        });
        unpaidUsers.remove(user);
        paidUsers.add(user);
      } else {
        // Move user from paid to unpaid list
        await _firestore.collection('paid_users').doc(user.id).delete();
        await _firestore.collection('unpaid_users').add({
          'name': user.userName,
          'payment': user.fees,
          'speed': user.speed,
          'date': Timestamp.fromDate(user.dateTime),
        });
        paidUsers.remove(user);
        unpaidUsers.add(user);
      }
      notifyListeners();
    } catch (e) {
      log('Error updating user status: $e');
    }
  }

// delete user
  Future<void> deleteUser(UserData user, bool isPaid) async {
    try {
      // Check if the user ID is valid before proceeding
      if (user.id.isEmpty) {
        log('User ID is empty, cannot delete user.');
        return;
      }

      if (isPaid) {
        // Remove user from the paid users list
        await _firestore.collection('paid_users').doc(user.id).delete();
        paidUsers.removeWhere((u) => u.id == user.id); // Ensure to match by ID
        filteredPaidUsers
            .removeWhere((u) => u.id == user.id); // Update filtered list
        log('Deleted user from paid users: ${user.userName}');
      } else {
        // Remove user from the unpaid users list
        await _firestore.collection('unpaid_users').doc(user.id).delete();
        unpaidUsers
            .removeWhere((u) => u.id == user.id); // Ensure to match by ID
        filteredUnpaidUsers
            .removeWhere((u) => u.id == user.id); // Update filtered list
        log('Deleted user from unpaid users: ${user.userName}');
      }
      notifyListeners(); // Update UI
    } catch (e) {
      log('Error deleting user: $e');
      // Optionally show a message to the user
      // Example: showDialog(...) to inform the user about the failure
    }
  }

  // Filter Paid Users based on search query
  void searchPaidUsers(String query) {
    searchQueryPaid = query;
    if (query.isEmpty) {
      filteredPaidUsers = paidUsers;
    } else {
      filteredPaidUsers = paidUsers
          .where((user) =>
              user.userName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Filter Unpaid Users based on search query
  void searchUnpaidUsers(String query) {
    searchQueryUnpaid = query;
    if (query.isEmpty) {
      filteredUnpaidUsers = unpaidUsers;
    } else {
      filteredUnpaidUsers = unpaidUsers
          .where((user) =>
              user.userName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Format date and time
  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  // Calculate total fees for Paid users
  double getTotalPaidFees() {
    return paidUsers.fold(0, (total, user) => total + user.fees);
  }

// Calculate total fees for Unpaid users
  double getTotalUnpaidFees() {
    return unpaidUsers.fold(0, (total, user) => total + user.fees);
  }

// save  excel sheet
  String selectedMonth = DateFormat('MMMM yyyy').format(DateTime.now());
  void setSelectedMonth(String month) {
    selectedMonth = month;
    notifyListeners();
  }

  UserExpanseListViewModel() {
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          _onNotificationTapped, // Handle tap on notification
    );
  }

  List<UserData> expenses = [];

  // Filter expenses by month
  List<UserData> getExpensesByMonth(DateTime selectedMonth) {
    return expenses
        .where((expense) =>
            expense.dateTime.year == selectedMonth.year &&
            expense.dateTime.month == selectedMonth.month)
        .toList();
  }

// Export filtered expenses to Excel
  Future<void> exportToPaidExcel(
      DateTime selectedMonth, List<UserData> users, String fileName) async {
    var excel = Excel.createExcel(); // Create a new Excel document
    Sheet sheetObject = excel['Users'];

    // Add headers
    sheetObject.appendRow(['User Name', 'Fees', 'Speed', 'Date']);

    // Add rows of data
    for (var expense in users) {
      sheetObject.appendRow([
        expense.userName,
        expense.fees,
        expense.speed,
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
        Directory directory = Directory('/storage/emulated/0/Download/');
        if (!await directory.exists()) {
          directory =
              await getExternalStorageDirectory() ?? Directory.systemTemp;
        }

        String filePath =
            '${directory.path}$fileName/${selectedMonth.month}_${selectedMonth.year}.xlsx';

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

  // Export filtered expenses to Excel
  Future<void> exportToUnpaidExcel(
      DateTime selectedMonth, List<UserData> users, String fileName) async {
    var excel = Excel.createExcel(); // Create a new Excel document
    Sheet sheetObject = excel['Users'];

    // Add headers
    sheetObject.appendRow(['User Name', 'Fees', 'Speed', 'Date']);

    // Add rows of data
    for (var expense in users) {
      sheetObject.appendRow([
        expense.userName,
        expense.fees,
        expense.speed,
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
        Directory directory = Directory('/storage/emulated/0/Download/');
        if (!await directory.exists()) {
          directory =
              await getExternalStorageDirectory() ?? Directory.systemTemp;
        }

        String filePath =
            '${directory.path}$fileName/${selectedMonth.month}_${selectedMonth.year}.xlsx';

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
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Make sure this matches your Notification Channel ID
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'File Downloaded',
      'Your User List file has been downloaded.',
      platformChannelSpecifics,
      payload: filePath, // Pass the file path to the payload
    );
  }

  // Handle notification tap
  Future<void> _onNotificationTapped(
      NotificationResponse notificationResponse) async {
    String? payload = notificationResponse.payload;
    if (payload != null) {
      // Open the file using the file path received in the payload
      File file = File(payload);
      if (await file.exists()) {
        OpenFile.open(payload);
      } else {
        log('File does not exist: $payload');
      }
    }
  }
}

class UserData {
  final String id;
  final String userName;
  final double fees;
  final String speed;
  final DateTime dateTime;

  UserData({
    required this.id,
    required this.userName,
    required this.fees,
    required this.speed,
    required this.dateTime,
  });
}
