import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferPage extends StatelessWidget {
  final Map<String, dynamic>? arguments;
  const OfferPage({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    // Arguments passed via Get.toNamed are available in Get.arguments
    // or via state if using GoRouter params in some setups, but here we assume Get
    final args = arguments ?? Get.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Special Offer')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_offer, size: 80, color: Colors.orange),
              const SizedBox(height: 20),
              Text(
                args?['title'] ?? 'No Title',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Offer ID: ${args?['id'] ?? 'Unknown'}',
                 style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              if (args?['image'] != null)
                Image.network(
                  args!['image'],
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 50),
                ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
