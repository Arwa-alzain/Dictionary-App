import 'package:flutter/material.dart';
import 'package:flutter_application_6/Controller/Controller.dart';
import 'package:flutter_application_6/Core/colors.dart';
import 'package:flutter_application_6/Core/sizes.dart';
import 'package:flutter_application_6/Core/strings.dart';
import 'package:flutter_application_6/View/FavoriteScreen.dart';
import 'package:flutter_application_6/View/Widgets/InfoCard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final bool isDarkTheme;
  final VoidCallback onToggleTheme;
  final List<String> favorites;
  final Function(String) onAddFavorite;

  const HomePage({
    super.key,
    required this.isDarkTheme,
    required this.onToggleTheme,
    required this.favorites,
    required this.onAddFavorite,
    });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DictionaryCubit>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.amber0,
          title: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: Sizes.s20, fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: Strings.hashPlus,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.black0,
                  ),
                ),
                TextSpan(
                  text: Strings.dictionary,
                  style: TextStyle(color: MyColors.white0),
                ),
              ],
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                widget.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
                color: MyColors.black0,
              ),
              onPressed: widget.onToggleTheme,
            ),
            IconButton(
              icon: Icon(Icons.favorite_border_outlined, color: MyColors.black0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FavoritesScreen(favorites: widget.favorites),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(Sizes.s15),
          child: Column(
            children: [
              TextField(
                controller: textController,
                onSubmitted: (value) => cubit.getWord(value.trim()),
                decoration: InputDecoration(
                  hintText: Strings.searchFieldHintText,
                  filled: true,
                  fillColor:
                      Theme.of(context).inputDecorationTheme.fillColor ??
                      MyColors.transparent0,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.s15),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Sizes.s10,
                    vertical: Sizes.s10,
                  ),
                ),
              ),
              SizedBox(height: Sizes.s20),
              Expanded(
                child: BlocBuilder<DictionaryCubit, DictionaryState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is FailureState) {
                      return Text(
                        state.errorMessage,
                        style: TextStyle(color: MyColors.red0),
                      );
                    } else if (state is SuccessState) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            InfoCard(
                              title: Strings.word,
                              value: state.word,
                              backgroundColor: MyColors.pink100,
                            ),
                            SizedBox(height: Sizes.s15),
                            InfoCard(
                              title: Strings.meaning,
                              value: state.meaning,
                              backgroundColor: MyColors.purple100,
                            ),
                            SizedBox(height: Sizes.s15),
                            InfoCard(
                              title: Strings.example,
                              value: state.example,
                              backgroundColor: MyColors.yellow100,
                              isItalic: true,
                            ),
                            SizedBox(height: Sizes.s15),
                            ElevatedButton.icon(
                              icon: Icon(Icons.favorite),
                              label: Text(Strings.addFavorite),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.red1,
                                foregroundColor: MyColors.white0,
                              ),
                              onPressed: () {
                                if (!widget.favorites.contains(state.word)) {
                                  widget.onAddFavorite(state.word);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        Strings.addFavorite,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        Strings.alreadyFavorite,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          Strings.searchWord,
                          style: TextStyle(color: MyColors.grey0),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}