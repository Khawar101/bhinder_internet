import 'package:bhinder_internet/ui/common/app_colors.dart';
import 'package:bhinder_internet/ui/common/ui_helpers.dart';
import 'package:bhinder_internet/ui/common_widgets/custom_text.dart';
import 'package:bhinder_internet/ui/common_widgets/custom_text_form_field.dart';
import 'package:bhinder_internet/ui/common_widgets/icon_Text_box.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'add_daily_expanse_viewmodel.dart';

class AddDailyExpanseView extends StackedView<AddDailyExpanseViewModel> {
  const AddDailyExpanseView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddDailyExpanseViewModel viewModel,
    Widget? child,
  ) {
    final height = MediaQuery.of(context).size.height;
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
          text: "Daily expanse",
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
                text: 'Name :',
                fontSize: mediumFontSize(context),
                fontWeight: FontWeight.w600,
              ),
              verticalSpaceTiny,
              CustomTextFormField(
                hintText: 'write your name ',
                onChanged: viewModel.updateName,
              ),
              verticalSpaceMedium,
              CustomText(
                text: 'Description for Daily expanse :',
                fontSize: mediumFontSize(context),
                fontWeight: FontWeight.w600,
              ),
              verticalSpaceTiny,
              CustomTextFormField(
                hintText: 'write description',
                maxLines: 5,
                onChanged: viewModel.updateDescription,
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
                hintText: '0',
                onChanged: viewModel.updatePayment,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
        child: IconTextContainer(
          height: 50,
          onPress: viewModel.addDailyExpanse,
          text: 'Add daily expense',
          textColor: Colors.white,
          boxcolor: Colors.black,
        ),
      ),
    );
  }

  @override
  AddDailyExpanseViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddDailyExpanseViewModel();
}
