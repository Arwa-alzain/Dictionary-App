import 'package:flutter/material.dart';
import 'package:flutter_application_6/Controller/Controller.dart';
import 'package:flutter_application_6/Core/colors.dart';
import 'package:flutter_application_6/Core/sizes.dart';
import 'package:flutter_application_6/Core/strings.dart';
import 'package:flutter_application_6/View/Widgets/InfoCard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details page"), backgroundColor: Colors.amber,),
      body: Padding(
        padding: EdgeInsets.all(Sizes.s15),
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
    );
  }
}