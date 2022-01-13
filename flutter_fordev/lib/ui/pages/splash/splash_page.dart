import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_presenter.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  const SplashPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();

    presenter.navigateToStream.listen((page) {
      if (page.isNotEmpty) {
        Get.offAllNamed(page);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('4Dev')),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
