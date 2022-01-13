import 'package:flutter_fordev/main/factories/usecases/load_current_account.dart';
import 'package:flutter_fordev/presentation/presenters/presenters.dart';
import 'package:flutter_fordev/ui/pages/splash/splash.dart';

SplashPresenter makeGetxSplashPresenter() {
  return GetxSplashPresenter(
    loadCurrentAccount: makeLoadCurrentAccount(),
  );
}
