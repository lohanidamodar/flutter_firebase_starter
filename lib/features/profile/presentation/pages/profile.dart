import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebasestarter/core/presentation/res/analytics.dart';
import 'package:firebasestarter/core/presentation/res/routes.dart';
import 'package:firebasestarter/features/auth/data/model/user_repository.dart';
import 'package:firebasestarter/features/profile/data/model/user.dart';
import 'package:firebasestarter/features/profile/presentation/widgets/avatar.dart';
import 'package:firebasestarter/generated/l10n.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profilePageTitle),
      ),
      body: Consumer<UserRepository>(builder: (context, userRepo, _) {
        UserModel user = userRepo.user;
        return ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            if (user != null) ...[
              Center(
                child: Avatar(
                  onButtonPressed: () {},
                  radius: 50,
                  image: user.photoUrl != null
                      ? NetworkImage(user.photoUrl)
                      : null,
                ),
              ),
              const SizedBox(height: 10.0),
              if(user.name != null) ...[
                Center(child: Text(user.name),),
                const SizedBox(height: 5.0),
              ],
              Center(child: Text(user?.email)),
            ],
            ...ListTile.divideTiles(
              color: Theme.of(context).dividerColor,
              tiles: [
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(S.of(context).editProfile),
                  onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile,arguments: user),
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(S.of(context).logoutButtonText),
                  onTap: () async {
                    await logEvent(context, AppAnalyticsEvents.logOut);
                    await Provider.of<UserRepository>(context, listen: false)
                        .signOut();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
