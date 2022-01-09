import 'package:flutter/material.dart';

import '../../../../ui/pages/login/login_page.dart';
import 'login_presenter_factory.dart';

Widget makeLoginPage() {
  return LoginPage(presenter: makeLoginPresenter());
}
