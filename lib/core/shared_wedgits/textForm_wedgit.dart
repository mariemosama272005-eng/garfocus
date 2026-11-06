
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';

class TextformWedgit extends StatefulWidget {
  final String hintT;
  final bool isPass;
  final String? Function(String?)? validator;
  final bool? autoFocus;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final int? maxLines;
  final int? minLines;

  const TextformWedgit({
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.autoFocus,
    required this.controller,
    this.validator,
    this.isPass = false,
    required this.hintT,
    super.key,
  });

  @override
  State<TextformWedgit> createState() => _TextformWedgitState();
}

class _TextformWedgitState extends State<TextformWedgit> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextFormField(
      autofocus: widget.autoFocus ?? false,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      maxLines: widget.isPass ? 1 : widget.maxLines,
      minLines: widget.isPass ? 1 : widget.minLines,

      onTapOutside: (v) {
        FocusScope.of(context).unfocus();
      },

      cursorColor: colorScheme.primary,

      style: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 16.sp,
      ),

      obscureText: widget.isPass && isObsecure,

      decoration: InputDecoration(
        suffixIcon: widget.isPass
            ? InkWell(
                onTap: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
                child: Icon(
                  isObsecure
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            : null,

        fillColor: theme.cardColor,
        filled: true,

        hintStyle: AppTextstyle.hintTextStyle(context),

        hintText: widget.hintT,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: colorScheme.outline,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: colorScheme.outline,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
