import 'package:flutter/material.dart';

class Vendormapscreen extends StatefulWidget {
  const Vendormapscreen({super.key});

  @override
  State<Vendormapscreen> createState() => _VendormapscreenState();
}

class _VendormapscreenState extends State<Vendormapscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Map Screen',
        ),
      ),
    );
  }
}
