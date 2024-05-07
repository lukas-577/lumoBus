import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mibus/firebase/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderMi>(context);
    final user = authProvider.user;
    final _buildUserWidget = (AuthProviderMi authProvider) {
      if (user == null) {
        return Text('Not logged in');
      } else {
        return Text('Logged in as ${user.email}');
      }
    };

    Map<String, String> _formData = {
      'email': 'luk@gmail.com',
      'password': '123456',
    };

    final emailController = TextEditingController(text: _formData['email']);

    final passwordController =
        TextEditingController(text: _formData['password']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                _formData['email'] = value;
              },
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              onChanged: (value) {
                _formData['password'] = value;
              },
            ),
            ElevatedButton(
              onPressed: () {
                authProvider.login(_formData['email']!, _formData['password']!);
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                authProvider.signUp(
                    _formData['email']!, _formData['password']!);
              },
              child: Text('Sign up'),
            ),
            ElevatedButton(
              onPressed: () {
                authProvider.logout();
              },
              child: Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                authProvider.signInWithGoogle();
              },
              child: Text('Sign in with Google'),
            ),
            _buildUserWidget(authProvider),
          ],
        ),
      ),
    );

    // if (authProvider.loading) {
    //   return CircularProgressIndicator(); // Or any loading indicator
    // }
  }
}
