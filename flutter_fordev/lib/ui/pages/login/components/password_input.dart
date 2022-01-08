import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginPresenter presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<String>(
        stream: presenter.passwordErrorStream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 32),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Senha",
                icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
              ),
              onChanged: presenter.validatePassword,
              obscureText: true,
            ),
          );
        });
  }
}
