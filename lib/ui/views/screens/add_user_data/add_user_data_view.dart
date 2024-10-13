import 'package:bhinder_internet/ui/common/app_colors.dart';
import 'package:bhinder_internet/ui/common/ui_helpers.dart';
import 'package:bhinder_internet/ui/common_widgets/custom_text.dart';
import 'package:bhinder_internet/ui/common_widgets/custom_text_form_field.dart';
import 'package:bhinder_internet/ui/common_widgets/icon_Text_box.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'add_user_data_viewmodel.dart';

class AddUserDataView extends StackedView<AddUserDataViewModel> {
  const AddUserDataView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddUserDataViewModel viewModel,
    Widget? child,
  ) {
    final height = MediaQuery.of(context).size.height;
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
          text: "Add User",
          fontWeight: FontWeight.bold,
          fontSize: extraMediumFontSize(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height * 1,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'User Name :',
                fontSize: mediumFontSize(context),
                fontWeight: FontWeight.w600,
              ),
              verticalSpaceTiny,
              CustomTextFormField(
                hintText: 'Write user name',
                onChanged: (value) => viewModel.userName = value, // Capture input
              ),
              verticalSpaceMedium,
              CustomText(
                text: 'User Speed :',
                fontSize: mediumFontSize(context),
                fontWeight: FontWeight.w600,
              ),
              verticalSpaceTiny,
              CustomTextFormField(
                hintText: '00 MB',
                onChanged: (value) => viewModel.internetSpeed = value, // Capture input
              ),
              verticalSpaceMedium,
              CustomText(
                text: 'Payment :',
                fontSize: mediumFontSize(context),
                fontWeight: FontWeight.w600,
              ),
              verticalSpaceTiny,
              CustomTextFormField(
                textInputType: TextInputType.number,
                hintText: '0000',
                onChanged: (value) => viewModel.payment = value, // Capture input
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconTextContainer(
                    radius: 10,
                    height: 50,
                    text: 'Paid',
                    width: width * 0.3,
                    textColor: viewModel.isPaidSelected
                        ? Colors.white
                        : Colors.black, // Dynamic color
                    boxcolor: viewModel.isPaidSelected
                        ? Colors.black
                        : Colors.white, // Dynamic background
                    onPress: () {
                      viewModel.togglePaymentSelection(true); // Set to Paid
                    },
                  ),
                  IconTextContainer(
                    radius: 10,
                    height: 50,
                    text: 'UnPaid',
                    width: width * 0.3,
                    textColor: !viewModel.isPaidSelected
                        ? Colors.white
                        : Colors.black, // Dynamic color
                    boxcolor: !viewModel.isPaidSelected
                        ? Colors.black
                        : Colors.white, // Dynamic background
                    onPress: () {
                      viewModel.togglePaymentSelection(false); // Set to UnPaid
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
        child: IconTextContainer(
          height: 50,
          onPress: viewModel.addUserData, // Call addUserData method
          text: 'Add User',
          textColor: Colors.white,
          boxcolor: Colors.black,
        ),
      ),
    );
  }

  @override
  AddUserDataViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddUserDataViewModel();
}
