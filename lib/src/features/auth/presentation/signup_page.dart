import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up Page'),leading: IconButton(
        onPressed: () => context.pop(),
        icon: Icon(Icons.arrow_back_ios),
      ),),
      body: ListView(
        children: const [
          Text('SignUpPage page')
        ],
      ),
    );
  }
}
