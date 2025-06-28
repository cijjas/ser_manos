import 'package:flutter/material.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/constants/app_icons.dart';
import 'package:ser_manos/shared/tokens/border_radius.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/shadow.dart';
import 'package:ser_manos/shared/tokens/typography.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.controller,
    this.hintText = 'Buscar',
    this.onChanged,
    this.emptySuffix,
    this.onEmptySuffixTap,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final Widget? emptySuffix;
  final VoidCallback? onEmptySuffixTap;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _ctrl =
      widget.controller ?? TextEditingController();
  late final FocusNode _focus = FocusNode();

  bool get _focused => _focus.hasFocus;
  bool get _hasText => _ctrl.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_notify);
    _focus.addListener(_notify);
  }

  @override
  void dispose() {
    _ctrl.removeListener(_notify);
    _focus.removeListener(_notify);
    if (widget.controller == null) _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _notify() => setState(() {});

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
        focusNode: _focus,
        onChanged: widget.onChanged,
        style: AppTypography.subtitle01.copyWith(color: AppColors.neutral100),
        cursorColor: AppColors.secondary200,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          hintText: widget.hintText,
          hintStyle: AppTypography.subtitle01.copyWith(
            color: _focused ? AppColors.neutral50 : AppColors.neutral75,
          ),
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
            icon: const Icon(Icons.close_rounded,
                color: AppColors.neutral75),
            splashRadius: 20,
            onPressed: () {
              _ctrl.clear();
              widget.onChanged?.call(''); // Notify listener on clear
            } ,
          )
              : (widget.emptySuffix != null
              ? Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),
            child: IconButton(
              icon: widget.emptySuffix!,
              onPressed: widget.onEmptySuffixTap,
              splashRadius: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          )
              : const SizedBox.shrink()),
        ),
      ),
    );
  }
}