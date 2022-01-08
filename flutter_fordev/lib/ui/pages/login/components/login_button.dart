import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginPresenter presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<bool>(
        stream: presenter.isFormValidStream,
        builder: (context, snapshot) {
          return ElevatedButton(
              onPressed: snapshot.data == true ? presenter.auth : null,
              child: Text(
                "Entrar".toUpperCase(),
              ));
        });
  }
}
