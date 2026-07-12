import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/auth_service.dart';
import '../../shared/widgets/app_logo.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService.instance.signUp(
  name: _nameController.text.trim(),
  email: _emailController.text.trim(),
  password: _passwordController.text.trim(),
);

      if (mounted) {
        context.go('/dashboard');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F172A),
              Color(0xFF1E3A8A),
              Color(0xFF2563EB),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.20),
                  ),
                ),
                child: Column(
                  children: [
                    const AppLogo(size: 90),

                    const SizedBox(height: 24),

                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Start building your dream career.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 35),

                    AppTextField(
                      controller: _nameController,
                      hintText: "Full Name",
                      prefixIcon: Icons.person_outline,
                    ),

                    const SizedBox(height: 20),

                    AppTextField(
                      controller: _emailController,
                      hintText: "Email",
                      prefixIcon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 20),

                    AppTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                    ),

                    const SizedBox(height: 20),

                    AppTextField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : PrimaryButton(
                              text: "Create Account",
                              icon: Icons.person_add_alt_1,
                              onPressed: _register,
                            ),
                    ),

                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}