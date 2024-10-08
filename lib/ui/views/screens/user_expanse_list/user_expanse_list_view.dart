import 'package:bhinder_internet/ui/common/app_colors.dart';
import 'package:bhinder_internet/ui/common/ui_helpers.dart';
import 'package:bhinder_internet/ui/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'user_expanse_list_viewmodel.dart';

class UserExpanseListView extends StackedView<UserExpanseListViewModel> {
  const UserExpanseListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserExpanseListViewModel viewModel,
    Widget? child,
  ) {
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
      ),
      body: viewModel.expenses.isEmpty
          ? const Center(child: Text('No expenses added'))
          : ListView.builder(
              itemCount: viewModel.expenses.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                final expense = viewModel.expenses[index];
                return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'User Name :  ',
                                    fontSize: mediumFontSize(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  verticalSpace(4),
                                  CustomText(text: 'hghgjhgjhgjh'
                                      // expense.userName,
                                      ),
                                ],
                              ),
                              CustomText(
                                    text: 'PAID',
                                    fontSize: mediumFontSize(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ],
                          ),
                          verticalSpaceTiny,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'fees :  ',
                                fontSize: mediumFontSize(context),
                                fontWeight: FontWeight.w600,
                              ),
                              verticalSpace(4),
                              CustomText(
                                text: expense.fees.toString(),
                              ),
                            ],
                          ),
                          
                          verticalSpaceTiny,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: viewModel.formatTime(expense.dateTime)),
                              CustomText(
                                  text: viewModel.formatDate(expense.dateTime)),
                            ],
                          ),
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
                  text: '000',
                  color: whitePrimaryColor,
                ),
              ],
            ),
          )),
    );
  }

  @override
  UserExpanseListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserExpanseListViewModel();
}
