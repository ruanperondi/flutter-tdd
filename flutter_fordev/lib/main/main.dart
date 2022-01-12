import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../ui/components/components.dart';
import 'factories/factories.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    ThemeData theme = makeAppTheme();

    return GetMaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(primary: theme.primaryColor),
      ),
      initialRoute: "/login",
      getPages: [
        GetPage(name: "/login", page: makeLoginPage),
        GetPage(
            name: "/surveys",
            page: () => Scaffold(
                  body: Text("Enquetes"),
                )),
      ],
    );
  }
}
