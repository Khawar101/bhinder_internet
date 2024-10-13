import 'package:bhinder_internet/ui/common/app_colors.dart';
import 'package:bhinder_internet/ui/common/ui_helpers.dart';
import 'package:bhinder_internet/ui/common_widgets/custom_text.dart';
import 'package:bhinder_internet/ui/common_widgets/custom_text_form_field.dart';
import 'package:bhinder_internet/ui/views/screens/user_expanse_list/user_expanse_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildUserList(
  BuildContext context,
  UserExpanseListViewModel viewModel,
  bool isPaidList,
) {
  final users =
      isPaidList ? viewModel.filteredPaidUsers : viewModel.filteredUnpaidUsers;
  final searchFunction =
      isPaidList ? viewModel.searchPaidUsers : viewModel.searchUnpaidUsers;
  final noUsersText = isPaidList ? 'No Paid Users' : 'No Unpaid Users';
  final totalFees = isPaidList
      ? viewModel.getTotalPaidFees()
      : viewModel.getTotalUnpaidFees();

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 7, right: 20),
        child: CustomTextFormField(
          onChanged: searchFunction,
          hintText: 'Search users',
        ),
      ),
      Expanded(
        child: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : users.isEmpty
                ? Center(
                    child: CustomText(
                    text: noUsersText,
                    fontSize: mediumFontSize(context),
                  ))
                : ListView.builder(
                    itemCount: users.length +
                        1, // Add one extra item for the total fees
                    padding: const EdgeInsets.only(bottom: 20),
                    itemBuilder: (context, index) {
                      if (index == users.length) {
                        // Display total fees at the bottom of the list
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Card(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: isPaidList
                                        ? 'Total Paid Fees'
                                        : 'Total Unpaid Fees',
                                    fontSize: mediumFontSize(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomText(
                                    text: totalFees.toStringAsFixed(2),
                                    fontSize: mediumFontSize(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      DateTime selectedMonthAsDate =
                                          DateFormat('MMMM yyyy')
                                              .parse(viewModel.selectedMonth);
                                      isPaidList
                                          ? viewModel.exportToPaidExcel(
                                              selectedMonthAsDate,
                                              viewModel.paidUsers,
                                              'PaidUsers')
                                          : viewModel.exportToPaidExcel(
                                              selectedMonthAsDate,
                                              viewModel.unpaidUsers,
                                              'UnPaidUsers');
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: CustomText(
                                          text: isPaidList
                                              ? 'Save List'
                                              : 'Save List',
                                          fontSize: mediumFontSize(context),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      final user = users[index];
                      return GestureDetector(
                        onLongPress: (){
                          _showDeleteDialog(context, viewModel, user, isPaidList);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildUserInfo(context, user),
                                    _buildActionButton(
                                        context, viewModel, user, isPaidList),
                                  ],
                                ),
                                verticalSpaceTiny,
                                _buildUserDetails(context, user, viewModel),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    ],
  );
}

Widget _buildUserInfo(BuildContext context, UserData user) {
  return Row(
    children: [
      CustomText(
        text: 'User Name: ',
        fontSize: mediumFontSize(context),
        fontWeight: FontWeight.w600,
      ),
      CustomText(text: user.userName),
    ],
  );
}

Widget _buildActionButton(BuildContext context,
    UserExpanseListViewModel viewModel, UserData user, bool isPaidList) {
  return GestureDetector(
    onTap: () {
      _showStatusChangeDialog(context, viewModel, user, isPaidList);
    },
    child: Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
        child: CustomText(
          text: isPaidList ? 'PAID' : 'UNPAID',
          fontSize: mediumFontSize(context),
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Widget _buildUserDetails(
  BuildContext context,
  UserData user,
  UserExpanseListViewModel viewModel,
) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: 'Fees: ${user.fees}'),
          CustomText(text: 'Speed: ${user.speed}'),
        ],
      ),
      verticalSpaceTiny,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: viewModel.formatTime(user.dateTime)),
          CustomText(text: viewModel.formatDate(user.dateTime)),
        ],
      ),
    ],
  );
}

Future<void> _showStatusChangeDialog(
  BuildContext context,
  UserExpanseListViewModel viewModel,
  UserData user,
  bool isPaidList,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: CustomText(
          text: isPaidList ? 'Change to Unpaid?' : 'Change to Paid?',
          fontSize: largeFontSize(context),
        ),
        content: Text(
            'Do you want to move this user to the ${isPaidList ? 'Unpaid' : 'Paid'} list?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              viewModel.updateUserStatus(user, !isPaidList);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


Future<void> _showDeleteDialog(
  BuildContext context,
  UserExpanseListViewModel viewModel,
  UserData user,
  bool isPaidList,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: CustomText(
           text: isPaidList ? 'Delete from Paid?' : 'Delete from Unpaid?',
          fontSize: largeFontSize(context),
        ),
        content: Text(
            'Do you want to Delete this user to the ${isPaidList ? 'Paid' : 'Unpaid'} list?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              viewModel.deleteUser(user, isPaidList);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}