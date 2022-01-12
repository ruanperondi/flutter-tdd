import 'package:flutter_fordev/main/factories/usecases/save_current_account.dart';
import 'package:flutter_fordev/presentation/presenters/getx_login_presenter.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

LoginPresenter makeLoginPresenter() {
  return StreamLoginPresenter(validation: makeLoginValidation(), authentication: makeRemoteAuthentication());
}

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
    validation: makeLoginValidation(),
    authentication: makeRemoteAuthentication(),
    saveCurrentAccount: makeSaveCurrentAccount(),
  );
}
