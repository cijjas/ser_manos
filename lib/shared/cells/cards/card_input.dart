import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class CardInput extends StatefulWidget {
  final String title;
  final List<String> options;
  final ValueChanged<int>? onSelected;
  final int? selectedIndex;

  const CardInput({
    super.key,
    required this.title,
    required this.options,
    this.onSelected,
    this.selectedIndex,
  });

  @override
  CardInputState createState() => CardInputState();
}

class CardInputState extends State<CardInput> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant CardInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 152,
      decoration: BoxDecoration(
        color: AppColors.neutral10,
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          Container(
            width: double.infinity,
            height: 112,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.options.length, (i) {
                final selected = _selectedIndex == i;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = i;
                    });
                    widget.onSelected?.call(i);
                  },
                  child: Container(
                    height: 32,
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        // Outer circle (border)
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary100,
                              width: 2,
                            ),
                          ),
                          // Inner circle if selected
                          child: selected
                              ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary100,
                              ),
                            ),
                          )
                              : null,
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
          ),
        ],
      ),
    );
  }
}
