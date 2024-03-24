import 'package:flutter/material.dart';
import 'package:medical_center_patient/pages/loader_page/loader_page.dart';

void main() {
  runApp(
    const Application(),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoaderPage(),
    );
  }
}
