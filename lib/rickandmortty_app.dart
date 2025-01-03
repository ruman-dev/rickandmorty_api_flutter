import 'package:flutter/material.dart';
import 'package:rickandmorty_project/screens/home_screen.dart';

class RickandmorttyApp extends StatelessWidget {
  const RickandmorttyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty',
      home: const HomeScreen(),
    );
  }
}
