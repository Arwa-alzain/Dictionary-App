import 'package:flutter/material.dart';
import 'package:flutter_application_6/Controller/Controller.dart';
import 'package:flutter_application_6/Core/colors.dart';
import 'package:flutter_application_6/Core/sizes.dart';
import 'package:flutter_application_6/Core/strings.dart';
import 'package:flutter_application_6/View/Widgets/InfoCard.dart';
import 'package:flutter_application_6/View/details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  final List<String> favorites;
  const FavoritesScreen({super.key, required this.favorites});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.FavoriteWords, style: TextStyle(color: MyColors.black0, fontSize: Sizes.s20, fontWeight: FontWeight.bold),),backgroundColor: MyColors.amber0,),
      /*body: BlocBuilder<DictionaryCubit, DictionaryState>(
      builder: (context, state) {
        if(state is favoriteWords){
          return ListView.builder(
            itemCount: state.words.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  child: InfoCard(title: Strings.word, value: widget.favorites[index], backgroundColor: MyColors.yellow100,);
                },
              );
            },
          );
        } else {
          return Center(child: Text("No favorite words"),);
        }
      },
      ),*/
      body: Padding(
        padding: EdgeInsets.all(15),
        child: widget.favorites.isEmpty
            ? Center(child: Text(Strings.Nofavorites))
            : ListView.builder(
                itemCount: widget.favorites.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Sizes.s15),
                    child: InkWell(
                      onTap: () {
                        context.read<DictionaryCubit>().getWord(widget.favorites[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Details())
                          );
                      },
                      child: InfoCard(title: Strings.word, value: widget.favorites[index], backgroundColor: MyColors.yellow100,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}