import 'package:album_app/screens/bloc/album_bloc.dart';
import 'package:album_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumBloc(),
      child: MaterialApp(
        title: 'Album K-POP',
        theme: ThemeData(),
        home: const HomeScreen(),
      ),
    );
  }
}
