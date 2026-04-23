

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
   Dio dio;
   LoginScreen({super.key,required this.dio});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void didChangeDependencies() {
    print('@@@@ dependencies changed');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: Text('login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Text('Enter your gmail'),
                const SizedBox(height: 8),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'your email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Text('Enter your password'),
                const SizedBox(height: 8),

                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'your password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    }, icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ))
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                        try{
                          //Dio dio = Dio(); //coupling
                          final response =  await widget.dio.post(
                              'https://investment-qna-backend-1.onrender.com/api/auth/login',
                              data: {
                                //use email as 'test@gmail.com
                                //pass -> test
                                "email": emailController.text,
                                "password": passwordController.text
                              }
                          );
                          if(response.statusCode == 200){
                            context.push('/user');
                          }
                        }catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Invalid credentials'))
                          );
                        }
                      }
                    },
                    child: Text('Login')
                  ),
                )
              ],
          ),
        ),
      )
    );
  }
}
