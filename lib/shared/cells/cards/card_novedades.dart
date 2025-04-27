import 'package:flutter/material.dart';
import 'package:ser_manos/shared/tokens/border_radius.dart';

import '../../molecules/buttons/app_button.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';

// TODO check what to do with the widget state
class CardNovedades extends StatelessWidget {
  final String type;
  final String name;
  final String description;
  final String imgUrl;

  const CardNovedades({
    super.key,
    required this.type,
    required this.name,
    required this.description,
    required this.imgUrl,
  });
// TODO recheck sizing in news page
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      decoration: const BoxDecoration(
        color: AppColors.neutral0,
        borderRadius: AppBorderRadius.border2,
        boxShadow: AppShadows.shadow2,
      ),
      clipBehavior: Clip.antiAlias,
      child:Row(
        children: [
          SizedBox(
            width: 118,
            height: 156,
            child: Image.network(
              imgUrl,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
            width: 210,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type.toUpperCase(), style: AppTypography.caption, overflow: TextOverflow.ellipsis),
                    Text(name, style: AppTypography.subtitle01, overflow: TextOverflow.ellipsis),
                    Text(description, style: AppTypography.body02, maxLines: 3, overflow: TextOverflow.ellipsis),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppButton(
                      label: "Leer más",
                      onPressed: () => debugPrint('Leer más tapped'),
                      type: AppButtonType.tonal,
                    )
                  ]
                )
              ]
            )
          )
        ]
      ),
    );
  }
}