import 'dart:async';

import 'package:flutter_fordev/domain/usecases/usecases.dart';

import '../../ui/pages/login/login_presenter.dart';
import '../../domain/usecases/authentication.dart';
import '../../domain/helpers/helpers.dart';

import '../protocols/protocols.dart';

class LoginState {
  String email = '';
  String password = '';

  String emailError = '';
  String passwordError = '';
  bool get isFormValid => emailError.isEmpty && passwordError.isEmpty && email.isNotEmpty && password.isNotEmpty;

  bool isLoading = false;
  String mainError = '';
}

class StreamLoginPresenter extends LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final _controller = StreamController<LoginState>.broadcast();
  final _state = LoginState();

  StreamLoginPresenter({required this.validation, required this.authentication});

  @override
  validateEmail(String email) {
    if (_controller.isClosed) {
      return;
    }

    _state.emailError = validation.validate(field: 'email', value: email);
    _state.email = email;
    _controller.add(_state);
  }

  @override
  validatePassword(String password) {
    if (_controller.isClosed) {
      return;
    }

    _state.passwordError = validation.validate(field: 'password', value: password);
    _state.password = password;
    _controller.add(_state);
  }

  @override
  Stream<String> get emailErrorStream => _controller.stream.map((state) => state.emailError).distinct();

  @override
  Stream<String> get passwordErrorStream => _controller.stream.map((state) => state.passwordError).distinct();

  @override
  Stream<String> get mainErrorStream => _controller.stream.map((state) => state.mainError).distinct();

  @override
  Stream<bool> get isFormValidStream => _controller.stream.map((state) => state.isFormValid).distinct();

  @override
  Stream<bool> get isLoadingStream => _controller.stream.map((state) => state.isLoading).distinct();

  @override
  Future<void> auth() async {
    if (_controller.isClosed) {
      return;
    }

    _state.isLoading = true;
    _update();

    try {
      await authentication.auth(AuthenticationParams(email: _state.email, secret: _state.password));
    } on DomainError catch (error) {
      _state.mainError = error.description;
    }
    _state.isLoading = false;

    _update();
  }

  @override
  void dispose() {
    if (_controller.isClosed) {
      return;
    }

    _controller.close();
  }

  void _update() {
    _controller.add(_state);
  }
}
