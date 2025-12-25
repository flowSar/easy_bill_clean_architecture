import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final String? placeholder;
  final Widget? icon;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final Color? bg;
  final TextInputType? keyType;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool readOnly;
  final VoidCallback? onErase;
  final String title;
  final (double, double)? m;

  const CustomTextField({
    super.key,
    this.placeholder,
    this.icon,
    this.controller,
    this.onChanged,
    this.bg,
    this.keyType,
    this.validator,
    this.initialValue,
    this.readOnly = false,
    this.onErase,
    this.title = '',
    this.m = (10, 3),
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    super.initState();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus ||
            (widget.controller?.text.isNotEmpty ?? false);
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.m!.$1, vertical: widget.m!.$2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? const Color.fromRGBO(255, 255, 255, 0.7)
                      : const Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? const Color.fromRGBO(255, 255, 255, 0.05)
                  : widget.bg ?? const Color.fromRGBO(0, 0, 0, 0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isFocused
                    ? theme.primaryColor
                    : (isDark
                        ? const Color.fromRGBO(255, 255, 255, 0.1)
                        : const Color.fromRGBO(0, 0, 0, 0.05)),
              ),
            ),
            child: TextFormField(
              readOnly: widget.readOnly,
              initialValue: widget.initialValue,
              keyboardType: widget.keyType ?? TextInputType.text,
              controller: widget.controller,
              onChanged: widget.onChanged,
              focusNode: _focusNode,
              validator: widget.validator,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                prefixIcon: widget.icon,
                hintStyle: TextStyle(
                  color: isDark
                      ? const Color.fromRGBO(255, 255, 255, 0.3)
                      : const Color.fromRGBO(0, 0, 0, 0.3),
                ),
                suffixIcon: widget.controller?.text.isNotEmpty == true &&
                        widget.onErase != null
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 20),
                        onPressed: widget.onErase,
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
