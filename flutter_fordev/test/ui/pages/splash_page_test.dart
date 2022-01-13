import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fordev/ui/pages/splash/splash.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_page_test.mocks.dart';

@GenerateMocks([SplashPresenter])
main() {
  late MockSplashPresenter presenter;
  late StreamController<String> navigateToController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockSplashPresenter();
    navigateToController = StreamController<String>();

    when(presenter.checkAccount()).thenAnswer((_) async => {});
    when(presenter.navigateToStream).thenAnswer((_) => navigateToController.stream);

    var splashPage = GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page: () => SplashPage(presenter: presenter)),
        GetPage(name: '/fake_page', page: () => const Scaffold(body: Text("fake page"))),
      ],
    );

    await tester.pumpWidget(splashPage);
  }

  testWidgets('Should present loading spinner on page loader', (tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call load current account on page load', (tester) async {
    await loadPage(tester);

    verify(presenter.checkAccount()).called(1);
  });

  tearDown(() {
    navigateToController.close();
  });

  testWidgets('Should load page', (tester) async {
    await loadPage(tester);

    navigateToController.add('/fake_page');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/fake_page');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();
    expect(Get.currentRoute, '/');
  });
}
