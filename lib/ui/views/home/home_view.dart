import 'package:bhinder_internet/ui/common_widgets/custom_text.dart';
import 'package:bhinder_internet/ui/common_widgets/icon_Text_box.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:bhinder_internet/ui/common/app_colors.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whitePrimaryColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 50,
        centerTitle: true,
        title: CustomText(
          text: "Home",
          fontWeight: FontWeight.bold,
          fontSize: extraMediumFontSize(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SizedBox(
            height: height * 0.7,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextContainer(
                  height: 50,
                  onPress: viewModel.addDailyExpanse,
                  text: 'Add daily expense',
                  textColor: Colors.white,
                  boxcolor: Colors.black,
                ),
                IconTextContainer(
                  height: 50,
                  onPress: viewModel.dailyExpanseList,
                  text: 'Daily Expansis List',
                  textColor: Colors.white,
                  boxcolor: Colors.black,
                ),
                IconTextContainer(
                  height: 50,
                  onPress: viewModel.addDailyUser,
                  text: 'Add user data',
                  textColor: Colors.white,
                  boxcolor: Colors.black,
                ),
                IconTextContainer(
                  height: 50,
                  onPress: viewModel.userList,
                  text: 'Users fees list',
                  textColor: Colors.white,
                  boxcolor: Colors.black,
                ),
                //  verticalSpaceSmall,

                //  verticalSpaceSmall,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

// Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 verticalSpaceLarge,
//                 Column(
//                   children: [
//                     const Text(
//                       'Hello, STACKED!',
//                       style: TextStyle(
//                         fontSize: 35,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                     verticalSpaceMedium,
//                     MaterialButton(
//                       color: Colors.black,
//                       onPressed: viewModel.incrementCounter,
//                       child: Text(
//                         viewModel.counterLabel,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MaterialButton(
//                       color: kcDarkGreyColor,
//                       onPressed: viewModel.showDialog,
//                       child: const Text(
//                         'Show Dialog',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     MaterialButton(
//                       color: kcDarkGreyColor,
//                       onPressed: viewModel.showBottomSheet,
//                       child: const Text(
//                         'Show Bottom Sheet',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
