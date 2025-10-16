import 'package:flutter/material.dart';
import 'package:weeding_invitation/Core/Constants/invitation_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;
  final Color? errorBorderColor;
  final double? borderWidth;
  final double? errorBorderWidth;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.validator,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.borderRadius,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorBorderColor,
    this.borderWidth,
    this.errorBorderWidth,
    this.onChanged,
    this.onTap,
    this.focusNode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? 20;
    final activeColor = widget.activeBorderColor ?? InvitationColors.royalBlue;
    final inactiveColor = widget.inactiveBorderColor ?? InvitationColors.royalBlue.withOpacity(0.4);
    final errorColor = widget.errorBorderColor ?? InvitationColors.error;
    final borderWidth = widget.borderWidth ?? 0.7;
    final errorBorderWidth = widget.errorBorderWidth ?? 0.7;

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText ? !_isPasswordVisible : false,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: widget.obscureText
            ? Padding(
                padding: EdgeInsetsDirectional.only(end: 8),
                child: IconButton(
                  icon: Icon(
                    !_isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: InvitationColors.royalBlue,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              )
            : widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: inactiveColor, width: borderWidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: inactiveColor, width: borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: activeColor, width: 2.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: errorColor, width: errorBorderWidth),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: errorColor, width: 2.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: inactiveColor.withOpacity(0.5), width: borderWidth),
        ),
      ),
    );
  }
}
