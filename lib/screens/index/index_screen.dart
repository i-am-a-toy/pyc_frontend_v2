import 'package:flutter/material.dart';

class IndexScreen extends StatelessWidget {
  static String routeName = '/index';
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Index')),
    );
  }
}
