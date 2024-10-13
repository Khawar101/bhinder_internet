import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:bhinder_internet/app/app.locator.dart';

class AddUserDataViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isPaidSelected = true; // Default to 'Paid' selected
  String? userName;
  String? internetSpeed;
  String? payment;

  // Handle back navigation
  void back() {
    _navigationService.back();
  }

  // Toggle between 'Paid' and 'Unpaid'
  void togglePaymentSelection(bool paidSelected) {
    isPaidSelected = paidSelected;
    notifyListeners(); // Updates the UI when the selection changes
  }

  // Function to save user data to Firestore
  Future<void> addUserData() async {
    if (userName == null || internetSpeed == null || payment == null) {
      // Handle empty fields
      log('All fields are required');
      return;
    }

    try {
      // Create a reference to the correct Firestore collection
      final collection = isPaidSelected ? 'paid_users' : 'unpaid_users';

      // Add user data to Firestore
      await _firestore.collection(collection).add({
        'name': userName,
        'speed': internetSpeed,
        'payment': double.parse(payment!), // Assuming payment is a number
        'date': FieldValue.serverTimestamp(), // Save the current date
      });

      log('User data added successfully');
      back(); // Navigate back after saving the data
    } catch (e) {
      log('Error saving user data: $e');
    }
  }
}
