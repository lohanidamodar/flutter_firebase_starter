import 'package:flutter/material.dart';
import 'package:firebasestarter/generated/l10n.dart';
import '../../data/model/user_repository.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextStyle style = TextStyle(fontSize: 20.0);
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _confirmPassword;
  FocusNode _passwordField;
  FocusNode _confirmPasswordField;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  UserRepository user;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    _confirmPassword = TextEditingController(text: "");
    _passwordField = FocusNode();
    _confirmPasswordField = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(0),
            child: TextFormField(
              key: Key("email-field"),
              controller: _email,
              validator: (value) =>
                  (value.isEmpty) ? S.of(context).emailValidationError : null,
              decoration: InputDecoration(
                labelText: S.of(context).emailFieldlabel,
              ),
              style: style,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_passwordField);
              },
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(0),
            child: TextFormField(
              focusNode: _passwordField,
              key: Key("password-field"),
              controller: _password,
              obscureText: true,
              validator: (value) =>
                  (value.isEmpty) ? S.of(context).passwordValidationError : null,
              decoration: InputDecoration(
                labelText: S.of(context).passwordValidationError,
              ),
              style: style,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_confirmPasswordField);
              },
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(0),
            child: TextFormField(
              key: Key("confirm-password-field"),
              controller: _confirmPassword,
              obscureText: true,
              validator: (value) => (value.isEmpty)
                  ? S.of(context).confirmPasswordValidationEmptyError
                  : value.isNotEmpty && _password.text != _confirmPassword.text
                      ? S.of(context).confirmPasswordValidationMatchError
                      : null,
              decoration: InputDecoration(
                labelText: S.of(context).confirmPasswordFieldLabel,
              ),
              style: style,
              focusNode: _confirmPasswordField,
              onEditingComplete: () => _signup(),
            ),
          ),
          SizedBox(height: 10.0),
          if (user.status == Status.Authenticating)
            Center(child: CircularProgressIndicator()),
          if (user.status != Status.Authenticating)
            Center(
              child: RaisedButton(
                elevation: 0,
                highlightElevation: 0,
                onPressed: _signup,
                child: Text(S.of(context).signupButtonText),
              ),
            ),
        ],
      ),
    );
  }

  _signup() async {
    if (_formKey.currentState.validate()) {
      //signup user
      if (!await user.signup(_email.text, _password.text))
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(user.error),
        ));
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
