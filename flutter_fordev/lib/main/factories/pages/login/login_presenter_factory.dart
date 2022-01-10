import 'package:flutter_fordev/presentation/presenters/getx_login_presenter.dart';

import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

LoginPresenter makeLoginPresenter() {
  return StreamLoginPresenter(validation: makeLoginValidation(), authentication: makeRemoteAuthenticatoin());
}

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(validation: makeLoginValidation(), authentication: makeRemoteAuthenticatoin());
}
