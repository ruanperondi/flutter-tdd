import 'package:get/get.dart';

import '../../domain/entity/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  final RxString _navigateTo = RxString('');

  GetxSplashPresenter({required this.loadCurrentAccount});

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

  @override
  Future<void> checkAccount() async {
    try {
      AccountEntity? account = await loadCurrentAccount.load();

      await Future.delayed(const Duration(seconds: 2));

      if (account == null) {
        _navigateTo.value = '/login';
      } else {
        _navigateTo.value = '/surveys';
      }
    } catch (error) {
      _navigateTo.value = '/login';
    }
  }
}
