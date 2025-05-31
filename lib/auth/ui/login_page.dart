import 'package:chat2/auth/logic/auth_provider.dart';
import 'package:chat2/auth/ui/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'widgets/custom_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await ref.read(authServiceProviderProvider).signIn(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      context.go('/chats');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        padding: const EdgeInsets.all(16),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.easeIn,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network("https://i.pinimg.com/originals/e3/1b/75/e31b752875679b64fce009922f9f0dda.gif"),
                const Text(
                  'ChatSphere',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email is required';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
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
                CustomButton(text: 'Login', onPressed: _login, isLoading: _isLoading),
                TextButton(
                  onPressed: () => context.go('/signup'),
                  child: const Text('Sign Up', style: TextStyle(color: Colors.blue, fontSize: 17)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}