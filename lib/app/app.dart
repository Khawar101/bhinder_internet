import 'package:bhinder_internet/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:bhinder_internet/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:bhinder_internet/ui/views/home/home_view.dart';
import 'package:bhinder_internet/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:bhinder_internet/ui/views/screens/add_daily_expanse/add_daily_expanse_view.dart';
import 'package:bhinder_internet/ui/views/screens/daily_expanse_list/daily_expanse_list_view.dart';
import 'package:bhinder_internet/ui/views/screens/add_user_data/add_user_data_view.dart';
import 'package:bhinder_internet/ui/views/screens/user_expanse_list/user_expanse_list_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: AddDailyExpanseView),
    MaterialRoute(page: DailyExpanseListView),
    MaterialRoute(page: AddUserDataView),
    MaterialRoute(page: UserExpanseListView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
