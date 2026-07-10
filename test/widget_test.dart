import 'dart:io';

import 'package:cawil/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  late Directory hiveDir;

  setUp(() async {
    hiveDir = await Directory.systemTemp.createTemp('cawil_test_hive_');
    Hive.init(hiveDir.path);
    await Hive.openBox<dynamic>('auth');
    await Hive.openBox<dynamic>('user_profile');
  });

  tearDown(() async {
    await Hive.close();
    await hiveDir.delete(recursive: true);
  });

  testWidgets('shows intro screen when signed out',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(
      find.text('Quick and easy way to reserve a seat.'),
      findsOneWidget,
    );
    expect(find.text('Swipe to book'), findsOneWidget);
  });
}
