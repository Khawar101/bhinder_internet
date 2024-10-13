import 'package:bhinder_internet/ui/views/screens/user_expanse_list/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'user_expanse_list_viewmodel.dart';
import 'package:bhinder_internet/ui/common/app_colors.dart';
import 'package:bhinder_internet/ui/common_widgets/custom_text.dart';

class UserExpanseListView extends StackedView<UserExpanseListViewModel> {
  const UserExpanseListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserExpanseListViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: 2, // Two tabs: Paid and Unpaid
      child: Scaffold(
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
            text: "User Payment List",
            fontWeight: FontWeight.bold,
            fontSize: extraMediumFontSize(context),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Paid Users'),
              Tab(text: 'Unpaid Users'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildUserList(context, viewModel, true),
            buildUserList(context, viewModel, false),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(UserExpanseListViewModel viewModel) {
    viewModel.fetchPaidUsers();
    viewModel.fetchUnpaidUsers();
    super.onViewModelReady(viewModel);
  }

  @override
  UserExpanseListViewModel viewModelBuilder(BuildContext context) =>
      UserExpanseListViewModel();
}
