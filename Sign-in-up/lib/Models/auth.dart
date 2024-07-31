import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../key.dart'; // Assuming this imports your apiKey variable

final String urlAuth = 'https://your-auth-url.com'; // Replace with your actual authentication URL
final String urlLogin = 'https://your-login-url.com'; // Replace with your actual login URL

class Auth with ChangeNotifier {
  
  Future<void> signup(String email, String password) async {
    final url = Uri.parse('$urlAuth?key=$apiKey'); // Construct URL with apiKey for signup
    try {
      final response = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }));
      final responseData = json.decode(response.body);
      print(responseData);
    } catch (error) {
      print('Error signing up: $error');
      throw error; // Optionally rethrow or handle the error as needed
    }
  }
  
  Future<void> login(String email, String password) async {
    final url = Uri.parse('$urlLogin?key=$apiKey'); // Construct URL with apiKey for login
    try {
      final response = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }));
      final responseData = json.decode(response.body);
      print(responseData);
    } catch (error) {
      print('Error logging in: $error');
      throw error; // Optionally rethrow or handle the error as needed
    }
  }
}
