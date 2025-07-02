
import 'package:admin/core/themes/colors.dart';
import 'package:flutter/material.dart';

class SearchAndFilter extends StatelessWidget {
  final IconData icon;
  final VoidCallback action;
   const SearchAndFilter({
    required this.action,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: AppPalette.mainClr, borderRadius: BorderRadius.circular(14)),
      child: IconButton(
          splashColor: Colors.white,
          highlightColor: AppPalette.buttonClr,
          focusColor: AppPalette.greenClr,
          onPressed: action,
          
          icon: Icon(
            icon,
            color: AppPalette.whiteClr,
          )),
    );
  }
}
