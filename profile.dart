import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsapp/home.dart';
import 'package:newsapp/login.dart';
import 'package:newsapp/passreset.dart'; 

class Myprofile extends StatefulWidget {
  const Myprofile({super.key});

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  String name = 'Loading...';
  String email = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    user = FirebaseAuth.instance.currentUser;

    setState(() {
      name = user?.displayName ?? 'No name';
      email = user?.email ?? 'No email';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile',
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
        centerTitle: true,
         leading:
        Builder(builder: (context)=> 
        Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
            }
            ,
            child: Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(shape: BoxShape.circle,color:  const Color.fromARGB(232, 255, 72, 0),),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 16,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3)
                      ),
                    ),
                    SizedBox(height: 6,),
                     Container(
                      width: 11,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              readOnly: true,
              controller: TextEditingController(text: name),
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: email),
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PasswordChangePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(232, 255, 72, 0),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Password Change',style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(232, 255, 72, 0),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Logout',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}