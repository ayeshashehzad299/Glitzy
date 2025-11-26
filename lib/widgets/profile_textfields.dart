import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTextfields extends StatefulWidget {
  const ProfileTextfields({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.validator,
    this.fillColor = Colors.white,
    this.borderRadius = 18.0,
    this.borderThickness = 1.5,
    this.activeColor = const Color.fromARGB(255, 255, 36, 146),
    this.errorColor = Colors.red,
    this.inactiveColor = const Color(0xFFFF69B4),
    this.autovalidate = true,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  // Styling options
  final Color fillColor;
  final double borderRadius;
  final double borderThickness;
  final Color activeColor;
  final Color errorColor;
  final Color inactiveColor;
  final bool autovalidate;

  @override
  State<ProfileTextfields> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<ProfileTextfields>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  String? _errorText;
  late AnimationController _animCtrl;
  late Animation<double> _errorSlideAnim;

  bool get _hasError => _errorText != null && _errorText!.isNotEmpty;
  bool get _hasFocus => _focusNode.hasFocus;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _errorSlideAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    if (widget.autovalidate) _validate(); // initial validate if needed
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    widget.controller.removeListener(_onTextChange);
    _focusNode.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      // re-build to animate border color
    });
    // validate when focus is lost (so user sees errors after leaving field)
    if (!_focusNode.hasFocus) _validate();
  }

  void _onTextChange() {
    if (widget.autovalidate) {
      _validate();
    } else {
      // Clear error while typing so user knows they're fixing it
      if (_hasError) {
        setState(() => _errorText = null);
        _animCtrl.reverse();
      }
    }
  }

  void _validate() {
    final validator = widget.validator;
    if (validator == null) return;
    final result = validator(widget.controller.text);
    if (result != _errorText) {
      setState(() {
        _errorText = result;
      });
      if (_errorText != null && _errorText!.isNotEmpty) {
        _animCtrl.forward();
      } else {
        _animCtrl.reverse();
      }
    }
  }

  Color get _currentBorderColor {
    if (_hasError) return widget.errorColor;
    if (_hasFocus) return widget.activeColor;
    return widget.inactiveColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: widget.fillColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _currentBorderColor,
              width: widget.borderThickness,
            ),
            boxShadow: _hasFocus
                ? [
                    BoxShadow(
                      color: _currentBorderColor.withOpacity(0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              if (widget.prefixIcon != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconTheme(
                    data: IconThemeData(color: _currentBorderColor),
                    child: widget.prefixIcon!,
                  ),
                ),
              ],
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.isPassword,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  style: GoogleFonts.quicksand(
                    color: Color(0xFF8E2A6C),
                    fontSize: 15,
                  ),
                  onEditingComplete: () {
                    // run validate when user finishes editing
                    _validate();
                    // move focus to next if any
                    _focusNode.unfocus();
                  },
                ),
              ),
            ],
          ),
        ),

        // Animated error text
        SizeTransition(
          sizeFactor: _errorSlideAnim,
          axisAlignment: -1.0,
          child: _hasError
              ? Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 16,
                        color: widget.errorColor,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          _errorText ?? '',
                          style: TextStyle(
                            color: widget.errorColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
