import 'package:flutter/material.dart';
import './login.dart';
import './signup.dart';

class AuthDialog extends StatefulWidget {
  final int selectedTab;
  final Function onClose;
  const AuthDialog({Key key, this.selectedTab, this.onClose}) : super(key: key);
  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  int _selectedTab;
  @override
  void initState() {
    super.initState();
    _selectedTab = widget.selectedTab ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTabController(
        initialIndex: _selectedTab,
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        _selectedTab = index;
                      });
                    },
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).primaryColor,
                    ),
                    tabs: <Widget>[
                      Tab(
                        text: "Login",
                      ),
                      Tab(
                        text: "Signup",
                      )
                    ],
                  ),
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.clear),
                  onPressed: () => widget.onClose != null
                      ? widget.onClose()
                      : Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(0),
              color: Colors.grey.shade200,
              height: 300,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _selectedTab == 0 ? LoginForm() : SignupForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
