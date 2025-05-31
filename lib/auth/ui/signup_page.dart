import 'package:chat2/auth/logic/auth_provider.dart';
import 'package:chat2/auth/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'widgets/custom_button.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});
  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await ref.read(authServiceProviderProvider).signUp(
            _emailController.text.trim(),
            _passwordController.text.trim(),
            _usernameController.text.trim(),
          );
      context.go('/chats');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Image.network("https://i.pinimg.com/originals/e3/1b/75/e31b752875679b64fce009922f9f0dda.gif"),
             SizedBox(height: 10,),
              const Text(
                  'ChatSphere',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              SizedBox(height: 20,),
              CustomTextField(
                label: 'Username',
                controller: _usernameController,
                validator: (value) =>
                    value!.isEmpty ? 'Username is required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                controller: _emailController,
                validator: (value) =>
                    value!.isEmpty ? 'Email is required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                obscureText: true,
                controller: _passwordController,
                validator: (value) =>
                    value!.isEmpty ? 'Password is required' : null,
              ),
              const SizedBox(height: 16),
              CustomButton(text: 'Sign Up', onPressed: _signUp, isLoading: _isLoading),
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text('Login', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}