import 'dart:async';

import 'package:flutter/material.dart';

class CommonError {
  void showMaterialBanner(context, String text) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        onVisible: () {
          Timer(const Duration(milliseconds: 1500), () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
        },
        backgroundColor: Colors.red,
        content: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            // child: const Text("Dismiss"),
          ),
        ],
      ),
    );
  }
}
