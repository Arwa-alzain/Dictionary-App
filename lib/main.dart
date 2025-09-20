import 'package:flutter/material.dart';
import 'package:flutter_application_6/Controller/Controller.dart';
import 'package:flutter_application_6/View/HomePage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(create: (_) => DictionaryCubit(), child: MyApp()));
}



class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController textController = TextEditingController();
  bool isDarkTheme = false;
  List<String> favorites = [];


    void addFavorite(String word) {
    if (!favorites.contains(word)) {
      setState(() {
        favorites.add(word);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => DictionaryCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        home: HomePage(
          isDarkTheme: isDarkTheme, 
          onToggleTheme: () => setState(() => isDarkTheme = !isDarkTheme),
          favorites: favorites, 
          onAddFavorite: addFavorite
          ), 
      ),
    );
  }
}
