import 'package:flutter/material.dart';
import 'package:newsapp/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
class NewsAppRegister extends StatelessWidget {
  const NewsAppRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: RegisterScreen(),
      );
    
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter email';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm password';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your name';
    return null;
  }

 bool _isLoading = false;

void _submit() async {
  if (_formKey.currentState!.validate()) {
    setState(() => _isLoading = true);
    try {
    
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

  
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(_nameController.text.trim());
        await user.reload(); 
        user = FirebaseAuth.instance.currentUser;
        print("Updated display name: ${user?.displayName}");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create an account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Enter your details and create account',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  onFieldSubmitted: (_) {} ,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateName,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                   onFieldSubmitted: (_) {} ,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                   onFieldSubmitted: (_) {} ,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                   onFieldSubmitted: (_) {} ,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password Confirm',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateConfirmPassword,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(232, 255, 72, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:newsapp/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// class NewsAppRegister extends StatelessWidget {
//   const NewsAppRegister({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         body: RegisterScreen(),
//       );
    
//   }
// }

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
  
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter email';
//     final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
//     if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter password';
//     if (value.length < 6) return 'Password must be at least 6 characters';
//     return null;
//   }

//   String? _validateConfirmPassword(String? value) {
//     if (value == null || value.isEmpty) return 'Please confirm password';
//     if (value != _passwordController.text) return 'Passwords do not match';
//     return null;
//   }

//   String? _validateName(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter your name';
//     return null;
//   }

//  bool _isLoading = false;

// void _submit() async {
//   if (_formKey.currentState!.validate()) {
//     setState(() => _isLoading = true);
//     try {
    
//       UserCredential userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );

  
//       User? user = userCredential.user;
//       if (user != null) {
//         await user.updateDisplayName(_nameController.text.trim());
//         await user.reload(); 
//         user = FirebaseAuth.instance.currentUser;
//         print("Updated display name: ${user?.displayName}");
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Registration successful')),
//       );
      
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.message ?? 'Registration failed')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: (){
//           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
//         }, icon: Icon(Icons.arrow_back)),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Create an account',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 5),
//                 const Text(
//                   'Enter your details and create account',
//                   style: TextStyle(fontSize: 14, color: Colors.black54),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _nameController,
//                   onFieldSubmitted: (_) {} ,
//                   decoration: const InputDecoration(
//                     labelText: 'Name',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: _validateName,
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _emailController,
//                    onFieldSubmitted: (_) {} ,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: _validateEmail,
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _passwordController,
//                    onFieldSubmitted: (_) {} ,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: _validatePassword,
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _confirmPasswordController,
//                    onFieldSubmitted: (_) {} ,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     labelText: 'Password Confirm',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: _validateConfirmPassword,
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: _submit,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:const Color.fromARGB(232, 255, 72, 0),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: const Text(
//                       'Register',
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }