import 'package:bhinder_internet/ui/common/app_colors.dart';
import 'package:bhinder_internet/ui/common/ui_helpers.dart';
import 'package:bhinder_internet/ui/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';
import 'daily_expanse_list_viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';

class DailyExpanseListView extends StackedView<DailyExpanseListViewModel> {
  const DailyExpanseListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DailyExpanseListViewModel viewModel,
    Widget? child,
  ) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whitePrimaryColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              viewModel.back();
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        elevation: 0,
        toolbarHeight: 50,
        centerTitle: true,
        title: CustomText(
          text: "Daily expanse List",
          fontWeight: FontWeight.bold,
          fontSize: extraMediumFontSize(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              DateTime selectedMonthAsDate =
                  DateFormat('MMMM yyyy').parse(viewModel.selectedMonth);
              viewModel.exportToExcel(selectedMonthAsDate);
            },
          ),
          IconButton(
            icon: Icon(Icons.save), // Save icon
            onPressed: () async {
              // Request storage permission
              if (await Permission.storage.request().isGranted) {
                // Call the export function
                DateTime selectedMonthAsDate =
                    DateFormat('MMMM yyyy').parse(viewModel.selectedMonth);
                viewModel.exportToExcel(selectedMonthAsDate);
              } else {
                // Handle the case where permission is denied
                // Show a message to the user
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Storage permission is required to save the Excel file.')),
                );
              }
            },
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : viewModel.expenses.isEmpty
              ? const Center(child: Text('No expenses added'))
              : ListView.builder(
                  itemCount: viewModel.expenses.length,
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (context, index) {
                    final expense = viewModel.expenses[index];
                    return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: width * 0.4,
                                      child: CustomText(
                                          maxLines: 1,
                                          textOverflow: TextOverflow.ellipsis,
                                          text: expense.name,
                                          fontSize: mediumFontSize(context),
                                          fontWeight: FontWeight.w600)),
                                  CustomText(
                                      color: Colors.green,
                                      text: viewModel.formatDate(
                                        expense.dateTime,
                                      )),
                                  CustomText(text: 'Rs:${expense.amount}'),
                                ],
                              ),
                              verticalSpace(5),
                              CustomText(
                                text: expense.description,
                              )
                            ],
                          ),
                        ));
                  },
                ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Total Payment = ',
                  color: whitePrimaryColor,
                ),
                CustomText(
                  text: viewModel.expenses
                      .fold<double>(0, (sum, expense) => sum + expense.amount)
                      .toStringAsFixed(2),
                  color: whitePrimaryColor,
                ),
              ],
            ),
          )),
    );
  }

  @override
  void onViewModelReady(DailyExpanseListViewModel viewModel) {
    // Fetch expenses when the view is ready
    viewModel.fetchExpenses();
    super.onViewModelReady(viewModel);
  }

  @override
  DailyExpanseListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DailyExpanseListViewModel();
}
