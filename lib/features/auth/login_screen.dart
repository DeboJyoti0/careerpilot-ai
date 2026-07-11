import 'package:flutter/material.dart';

import '../../shared/widgets/app_logo.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppLogo(size: 90),

                    const SizedBox(height: 24),

                    const Text(
                      "CareerPilot AI",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Build resumes that get you hired.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 40),

                    const AppTextField(
                      hintText: "Email",
                      prefixIcon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 20),

                    const AppTextField(
                      hintText: "Password",
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                    ),

                    const SizedBox(height: 30),

                    PrimaryButton(
                      text: "Login",
                      icon: Icons.login,
                      onPressed: () {},
                    ),

                    const SizedBox(height: 24),

                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Create an Account",
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