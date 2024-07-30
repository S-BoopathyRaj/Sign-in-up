import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/auth.dart';
import 'successful_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://voyage-onirique.com/wp-content/uploads/2020/01/656579-1120x630.jpg',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 510,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 45),
                    _buildInputField(emailController, 'Email', TextInputType.emailAddress),
                    _buildInputField(passwordController, 'Password', TextInputType.visiblePassword),
                    _buildLoginButton(context),
                    SizedBox(height: 20),
                    Center(child: Text('Forgot password ?'),),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconButton(Icons.add),
                          _buildIconButton(Icons.book_online),
                        ],
                      ),
                    ),
                    Divider(thickness: 0, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: Colors.blueGrey.shade200, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          controller: controller,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: TextStyle(fontSize: 18, color: Colors.white70, fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(top: 5, left: 70, right: 70),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), backgroundColor: Colors.indigo.shade800,
        ),
        onPressed: () {
          _handleLogin(context);
        },
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);
    authProvider.login(emailController.text, passwordController.text)
      .then((_) {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SuccessfulScreen()));
      })
      .catchError((error) {
        // Handle login errors, e.g., display an error message
        print('Login failed: $error');
      });
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(onPressed: () {}, child: Text('Login')),
        ],
      ),
    );
  }
}
