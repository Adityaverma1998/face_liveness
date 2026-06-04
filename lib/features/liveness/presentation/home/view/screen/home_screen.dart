import 'package:flutter/material.dart';
import 'package:face_liveness/core/routes/app_routes.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Face Recognition"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Face Icon
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.face_retouching_natural,
                size: 100,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              "Face Attendance System",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Register your face or recognize an existing face for attendance marking.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 48),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
  Navigator.pushNamed(
    context,
    AppRoutes.registerFace,
  );
},
                icon: const Icon(Icons.person_add_alt_1),
                label: const Text(
                  "Register Face",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: () {
                  // Navigate to Face Recognition
                },
                icon: const Icon(Icons.face),
                label: const Text(
                  "Recognize Face",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}