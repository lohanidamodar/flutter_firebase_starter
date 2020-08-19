import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasestarter/core/presentation/res/analytics.dart';
import 'package:firebasestarter/generated/l10n.dart';
import '../../data/model/user_repository.dart';

class UserInfoPage extends StatelessWidget {
  final User user;

  const UserInfoPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profilePageTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.email),
            RaisedButton(
              child: Text(S.of(context).logoutButtonText),
              onPressed: () {
                logEvent(context, AppAnalyticsEvents.logOut);
                Provider.of<UserRepository>(context, listen: false).signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
