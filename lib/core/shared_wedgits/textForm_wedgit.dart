
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/themes/app_colors.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';

class TextformWedgit extends StatefulWidget {
  final String hintT;
   final bool isPass;
   final String ?Function(String?)? validator;
   final bool? autoFocus;
   final TextEditingController? controller;
   final void Function(String?)?onChanged;
   final int? maxLines;
  final int? minLines;
   const TextformWedgit({this.maxLines=1, this.minLines=1, this.onChanged, this.autoFocus, required this.controller, this.validator,this.isPass=false,required this.hintT,super.key});

  @override
  State<TextformWedgit> createState() => _TextformWedgitState();
}

class _TextformWedgitState extends State<TextformWedgit> {
  bool isObsecure =true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus??false,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onTapOutside: (v){
        FocusScope.of(context).unfocus();
      },
      cursorColor: AppColors.mainColor,
      obscureText: widget.isPass&&isObsecure,
      
      decoration: InputDecoration(
        suffixIcon: widget.isPass?InkWell(
          onTap: (){
            setState(() {
              isObsecure=!isObsecure;
            });

          },
          child: Icon(Icons.visibility)):null,
        fillColor: Colors.white70,
        filled: true,
        hintStyle: AppTextstyle.hintTextStyle,
        hintText:widget.hintT,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color:AppColors.borderColor,
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color:AppColors.borderColor,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color:AppColors.mainColor,
          )
        ),
      ),
    );
  }
}