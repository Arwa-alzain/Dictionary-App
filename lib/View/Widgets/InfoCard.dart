import 'package:flutter/material.dart';
import 'package:flutter_application_6/Core/colors.dart';
import 'package:flutter_application_6/Core/sizes.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;
  final bool isItalic;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.backgroundColor,
    this.isItalic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor, 
        borderRadius: BorderRadius.circular(Sizes.s15),
        boxShadow: [
          BoxShadow(color: MyColors.black12, blurRadius: Sizes.s8,),
        ],
      ),
      padding: EdgeInsets.all(Sizes.s15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.s15,
              color: MyColors.black0,
            ),
          ),
          SizedBox(height: Sizes.s5),
          Text(
            value,
            style: TextStyle(
              fontSize: Sizes.s15,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              color: MyColors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
