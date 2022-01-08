abstract class LoginPresenter {
  Stream<String> get emailErrorStream;
  Stream<String> get passwordErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;
  Stream<String> get mainErrorStream;

  Future<void> auth();
  void dispose();
  void validateEmail(String email);
  void validatePassword(String password);
}

class LoginPresenterFInal extends LoginPresenter {
  @override
  void validateEmail(String email) {
    // TODO: implement validateEmail
  }

  @override
  void validatePassword(String password) {
    // TODO: implement validatePassword
  }

  @override
  // TODO: implement emailErrorStream
  Stream<String> get emailErrorStream => throw UnimplementedError();

  @override
  // TODO: implement passwordErrorStream
  Stream<String> get passwordErrorStream => throw UnimplementedError();

  @override
  // TODO: implement isFormValidStream
  Stream<bool> get isFormValidStream => throw UnimplementedError();

  @override
  Future<void> auth() async {
    // TODO: implement auth
  }

  @override
  // TODO: implement isLoadingStream
  Stream<bool> get isLoadingStream => throw UnimplementedError();

  @override
  // TODO: implement mainErrorStream
  Stream<String> get mainErrorStream => throw UnimplementedError();

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
