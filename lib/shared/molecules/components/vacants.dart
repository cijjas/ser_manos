// // core/components/vacants.dart
// import 'package:flutter/material.dart';
// import 'package:lucide_icons/lucide_icons.dart';
//
// class Vacants extends StatelessWidget {
//   final int count;
//
//   const Vacants({super.key, required this.count});
//
//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;
//     final bool isAvailable = count > 0;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: isAvailable ? colorScheme.primary.withOpacity(0.1) : colorScheme.surfaceVariant,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Vacantes:',
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//               color: colorScheme.onSurface,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Icon(
//             LucideIcons.user,
//             size: 20,
//             color: isAvailable
//                 ? colorScheme.primary
//                 : colorScheme.primary.withOpacity(0.4),
//           ),
//           const SizedBox(width: 4),
//           Text(
//             '$count',
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//               color: isAvailable
//                   ? colorScheme.primary
//                   : colorScheme.primary.withOpacity(0.4),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
