// lib/shared/cells/cards/card_input.dart

import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class CardInput extends StatefulWidget {
  final String title;
  final List<String> options;
  final ValueChanged<int>? onSelected;
  /// Nuevo parámetro para preseleccionar una opción
  final int? selectedIndex;

  const CardInput({
    Key? key,
    required this.title,
    required this.options,
    this.onSelected,
    this.selectedIndex,
  }) : super(key: key);

  @override
  _CardInputState createState() => _CardInputState();
}

class _CardInputState extends State<CardInput> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    // Inicializo con la opción que venga de afuera (o null)
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.neutral10,
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Encabezado
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.secondary25,
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: AppTypography.subtitle01.copyWith(
                color: AppColors.neutral100,
              ),
            ),
          ),
          // Opciones seleccionables
          Column(
            children: List.generate(widget.options.length, (i) {
              final selected = _selectedIndex == i;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedIndex = i);
                  widget.onSelected?.call(i);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                          selected ? AppColors.primary100 : AppColors.neutral10,
                          border: Border.all(
                            color: AppColors.primary100,
                            width: 2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.options[i],
                          style: AppTypography.body01.copyWith(
                            color: AppColors.neutral100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
