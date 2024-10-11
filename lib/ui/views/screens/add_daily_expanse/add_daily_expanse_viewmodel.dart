import 'dart:developer';

import 'package:bhinder_internet/app/app.locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddDailyExpanseViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void back() {
    _navigationService.back();
  }

    // Variables to hold the form input
  String? name;
  String? description;
  double? payment;

  // Method to update description
  void updateDescription(String value) {
    description = value;
    notifyListeners();  // Notifies UI of changes if necessary
  }

   void updateName(String value) {
    name = value;
    notifyListeners();  // Notifies UI of changes if necessary
  }

  // Method to update payment
  void updatePayment(String value) {
    payment = double.tryParse(value);
    notifyListeners();  // Notifies UI of changes if necessary
  }

  // Method to save data to Firestore
 // Method to save data to Firestore
// Method to save data to Firestore
Future<void> addDailyExpanse() async {
  if (description != null && payment != null) {
    try {
      // Create a new expense entry
      Map<String, dynamic> newExpense = {
        'name': name,
        'description': description,
        'payment': payment,
        'date': FieldValue.serverTimestamp(), // Saves the current timestamp
      };

      // Saving the new expense entry to Firestore collection 'daily_expenses'
      await _firestore.collection('daily_expenses').add(newExpense);

      // Navigate back after saving
      _navigationService.back();
    } catch (e) {
      // Handle errors (e.g., show an error message)
      log("Error adding expense: $e");
    }
  } else {
    // Handle form validation, show an error if required
    log("Please fill all fields");
  }
}




}
