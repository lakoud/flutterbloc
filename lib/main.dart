import 'package:app_pfa/bloc/todo_bloc.dart';
import 'package:app_pfa/bloc/todo_event.dart';
import 'package:app_pfa/home.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void  main() async {
    WidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage=await HydratedStorage.build(
        storageDirectory:await  getTemporaryDirectory(),
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            background: Colors.white,
            onBackground: Colors.white,
            primary: Colors.blue,
            onPrimary: Colors.white,
            secondary: Colors.lightGreen,
            onSecondary: Colors.white
        )
      ),
      
      home: BlocProvider<TodoBloc>(
        create: (context) => TodoBloc()..add(
            TodoStarted()
        ),
        child: const HomeScreen(),
      )
    );
  }
}

