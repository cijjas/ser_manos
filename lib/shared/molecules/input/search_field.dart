// lib/shared/molecules/input/search_field.dart
import 'package:flutter/material.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/shared/atoms/icons/app_icons.dart';
import 'package:ser_manos/shared/tokens/border_radius.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/typography.dart';
import 'package:ser_manos/shared/tokens/shadow.dart';

/// A fixed-size (328×48) search input with:
///  • 2px corner radius, white bg, shadow1
///  • subtitle01 text (16px) in neutral100
///  • placeholder in neutral75 → neutral50 on focus
///  • prefix AppIcons.BUSCAR in neutral75
///  • suffix:
//       – emptySuffix (e.g. AppIcons.MAPA/… in primary100) when empty
///       – a neutral75 “×” button while typing
///  • cursor in secondary200
class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
    this.controller,
    this.hintText = 'Buscar',
    this.onChanged,
    required this.emptySuffix, // pass e.g. AppIcon(icon: AppIcons.MAPA, color: AppIconsColor.PRIMARY100)
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final Widget emptySuffix;

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _ctrl =
      widget.controller ?? TextEditingController();
  late final FocusNode _focusNode = FocusNode();

  bool get _isFocused => _focusNode.hasFocus;
  bool get _hasText => _ctrl.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    if (widget.controller == null) _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
    widget.onChanged?.call(_ctrl.text);
  }

  void _onFocusChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: const BoxDecoration(
        color: AppColors.neutral0,
        borderRadius: AppBorderRadius.border2,
        boxShadow: AppShadows.shadow1,
      ),
      child: TextField(
        controller: _ctrl,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        style: AppTypography.subtitle01.copyWith(color: AppColors.neutral100),
        cursorColor: AppColors.secondary200,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTypography.subtitle01.copyWith(
            color: _isFocused ? AppColors.neutral50 : AppColors.neutral75,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          prefixIcon: const Padding(
            padding: EdgeInsetsDirectional.only(start: 16, end: 4),
            child: AppIcon(
              icon: AppIcons.BUSCAR,
              color: AppIconsColor.NEUTRAL_75,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 32),
          suffixIcon: _hasText
              ? IconButton(
            icon: const Icon(Icons.close_rounded),
            color: AppColors.neutral75,
            splashRadius: 20,
            onPressed: () => _ctrl.clear(),
          )
              : Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: widget.emptySuffix,
          ),
        ),
      ),
    );
  }
}