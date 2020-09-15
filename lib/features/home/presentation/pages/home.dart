import 'package:flutter/material.dart';
import 'package:firebasestarter/core/presentation/res/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/providers/providers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    context.read(pnProvider).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Quiz Admin'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
          )
        ],
      ),
      body: ListView(
        children: [Text("Home Page")],
      ),
    );
  }
}
