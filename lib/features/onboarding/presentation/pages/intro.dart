import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:firebasestarter/features/auth/data/model/user_repository.dart';
import 'package:firebasestarter/features/profile/data/model/user_field.dart';
import 'package:firebasestarter/features/profile/data/service/user_db_service.dart';
import 'package:firebasestarter/generated/l10n.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Swiper(
        itemCount: 1,
        itemBuilder: (context,index){
          return Column(
            children: <Widget>[
              //implement intro screen
              Spacer(),
              RaisedButton(
                onPressed: (){
                  _finishIntroScreen(context);
                },
                child: Text(S.of(context).introFinishButtonLabel),
              )
            ],
          );
        },
      ),
    );
  }

  _finishIntroScreen(BuildContext context) async {
    await userDBS.updateData(Provider.of<UserRepository>(context,listen: false).user.id, {
      UserFields.introSeen: true,
    });
  }
}