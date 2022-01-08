import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_fordev/ui/pages/pages.dart';

import 'login_page_test.mocks.dart';

@GenerateMocks([LoginPresenter])
void main() {
  late MockLoginPresenter loginPresenter;
  late StreamController<String> emailErrorController;
  late StreamController<String> passwordController;
  late StreamController<bool> isFormValidController;
  late StreamController<bool> isLoadingController;
  late StreamController<String> mainErrorController;

  Future<void> loadPage(WidgetTester tester) async {
    loginPresenter = MockLoginPresenter();
    emailErrorController = StreamController<String>();
    passwordController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
    mainErrorController = StreamController<String>();

    var loginPage = MaterialApp(home: LoginPage(presenter: loginPresenter));

    when(loginPresenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(loginPresenter.passwordErrorStream).thenAnswer((_) => passwordController.stream);
    when(loginPresenter.isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(loginPresenter.isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(loginPresenter.mainErrorStream).thenAnswer((_) => mainErrorController.stream);

    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
    passwordController.close();
    mainErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
  });

  testWidgets("Should load with correct initial state", (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(
      emailTextChildren,
      findsOneWidget,
      reason: 'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text',
    );

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(
      passwordTextChildren,
      findsOneWidget,
      reason: 'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text',
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets("Should call validate with correct values", (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(loginPresenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(loginPresenter.validatePassword(password));
  });

  testWidgets("Should present error if email is invalid", (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');

    await tester.pump();

    expect(find.text("any error"), findsOneWidget);
  });

  testWidgets("Should present no error if email is valid", (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('');

    await tester.pump();

    expect(
      find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets("Should present error if password is invalid", (WidgetTester tester) async {
    await loadPage(tester);

    passwordController.add('any error');

    await tester.pump();

    expect(find.text("any error"), findsOneWidget);
  });

  testWidgets("Should present no error if password is valid", (WidgetTester tester) async {
    await loadPage(tester);

    passwordController.add('');

    await tester.pump();

    expect(
      find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets("Should enable button if form is valid", (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);

    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets("Should disable button if form is invalid", (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false);

    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets("Should call authentication on form submit", (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);

    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(loginPresenter.auth()).called(1);
  });

  testWidgets("Should present loading", (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("Should present loading", (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets("Should present error message if authentication fails", (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add('main error');
    await tester.pump();

    expect(find.text('main error'), findsOneWidget);
  });

  testWidgets("Should close streams on dispose", (WidgetTester tester) async {
    await loadPage(tester);

    addTearDown(() {
      verify(loginPresenter.dispose()).called(1);
    });
  });
}
