import 'package:flutter_test/flutter_test.dart';
import 'package:bhinder_internet/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('AddUserDataViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
