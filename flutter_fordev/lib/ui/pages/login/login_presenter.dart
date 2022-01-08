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
