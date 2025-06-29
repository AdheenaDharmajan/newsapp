import 'package:flutter/material.dart';
import 'package:newsapp/register.dart';
import 'package:newsapp/home.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        User? user = FirebaseAuth.instance.currentUser;
        await user?.reload();
        user = FirebaseAuth.instance.currentUser;

        print("Logged in user name: ${user?.displayName}");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Login failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Login Page")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),

              Image.network(
                'https://th.bing.com/th/id/OIP.y9GCb4nCSTgZrtrp_lds2wAAAA?cb=iwp2&rs=1&pid=ImgDetMain',
                width: 100,
                height: 100,
                // errorBuilder: (context, error, stackTrace) =>
                //     const Icon(Icons.error, size: 50),
                // loadingBuilder: (context, child, loadingProgress) {
                //   if (loadingProgress == null) return child;
                //   return const CircularProgressIndicator();
                // },
              ),

              const SizedBox(height: 20),

              const Text(
                "News Live",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
              const SizedBox(height: 10),
              const Text('Login'),
              const Text('Enter your email to login for this app'),
              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                 
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: _validatePassword,
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 40,
                width: 200,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(232, 255, 72, 0),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Login"),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 40,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  NewsAppRegister(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(232, 255, 72, 0),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Register'),
                ),
              ),

              const SizedBox(height: 10),
              const Text(
                'By clicking continue, you agree to our terms of service and privacy policy',
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}