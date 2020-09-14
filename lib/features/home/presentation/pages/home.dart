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
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: 0,
            minExtendedWidth: 250,
            extended: true,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.category),
                label: Text("Categories"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add),
                label: Text("Add Question"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add),
                label: Text("Add Category"),
              ),
            ],
          ),
          Expanded(
            child: Text("Home Page"),
          ),
        ],
      ),
    );
  }
}
