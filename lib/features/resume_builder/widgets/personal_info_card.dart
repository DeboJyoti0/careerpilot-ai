import 'package:flutter/material.dart';

class PersonalInfoCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController linkedinController;
  final TextEditingController githubController;
  final TextEditingController portfolioController;

  const PersonalInfoCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.linkedinController,
    required this.githubController,
    required this.portfolioController,
  });

  InputDecoration decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "👤 Personal Information",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.blue.shade100,
                child: const Icon(
                  Icons.person,
                  size: 45,
                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: nameController,
              decoration: decoration(
                "Full Name",
                Icons.person_outline,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              decoration: decoration(
                "Email",
                Icons.email_outlined,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: decoration(
                "Phone Number",
                Icons.phone_outlined,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: addressController,
              maxLines: 2,
              decoration: decoration(
                "Address",
                Icons.location_on_outlined,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: linkedinController,
              decoration: decoration(
                "LinkedIn",
                Icons.link,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: githubController,
              decoration: decoration(
                "GitHub",
                Icons.code,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: portfolioController,
              decoration: decoration(
                "Portfolio Website",
                Icons.language,
              ),
            ),
          ],
        ),
      ),
    );
  }
}