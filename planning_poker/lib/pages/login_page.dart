import 'package:flutter/material.dart';

class P2LoginPage extends StatefulWidget {
  @override
  _P2LoginPageState createState() => _P2LoginPageState();
}

class _P2LoginPageState extends State<P2LoginPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  void _cancelLogin() {
    Navigator.of(context).pop();
  }

  void _login(String username, String password, P2LoginType type) {
    if (type == P2LoginType.login) {
      if (username == "admin" && password == "admin") {}
    } else if (type == P2LoginType.signup) {}

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "Login",
            ),
            Tab(text: "Sign up")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          P2LoginTabView(
              type: P2LoginType.login,
              loginCallback: _login,
              cancelLoginCallback: _cancelLogin),
          P2LoginTabView(
              type: P2LoginType.signup,
              loginCallback: _login,
              cancelLoginCallback: _cancelLogin)
        ],
      ),
    );
  }
}

enum P2LoginType { login, signup }

typedef void LoginCallback(String username, String password, P2LoginType type);
typedef void CancelCallback();

class P2LoginTabView extends StatelessWidget {
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  final P2LoginType type;
  final LoginCallback loginCallback;
  final CancelCallback cancelLoginCallback;

  P2LoginTabView(
      {Key key, this.type, this.loginCallback, this.cancelLoginCallback})
      : super(key: key) {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        const SizedBox(height: 16.0),
        Container(height: 200.0, color: Theme.of(context).primaryColor),
        const SizedBox(height: 16.0),
        TextField(
            controller: _usernameController,
            decoration:
                InputDecoration(labelText: "Username", hintText: "Username")),
        const SizedBox(height: 16.0),
        TextField(
            controller: _passwordController,
            decoration:
                InputDecoration(labelText: "Password", hintText: "Password"),
            obscureText: true),
        const SizedBox(height: 16.0),
        ButtonBar(children: [
          FlatButton(
              onPressed: cancelLoginCallback ?? () {}, child: Text("Cancel")),
          RaisedButton(
            onPressed: () {
              if (loginCallback != null) {
                loginCallback(
                    _usernameController.text, _passwordController.text, type);
              }
            },
            child: Text("Login"),
          )
        ]),
        FlatButton(onPressed: () {}, child: Text("Forgot password"))
      ],
    );
  }
}
