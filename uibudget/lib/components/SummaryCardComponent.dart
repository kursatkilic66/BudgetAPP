// import 'package:flutter/material.dart';

// class SummaryCardComponent extends StatelessWidget {
//   final String title;
//   final String amount;
//   final IconData icon;
//   final bool isPrimary; // Kartın vurgulu olup olmayacağını belirler

//   const SummaryCardComponent({
//     super.key,
//     required this.title,
//     required this.amount,
//     required this.icon,
//     this.isPrimary = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Aktif temanın renk paletini çekiyoruz (Aydınlık mı Karanlık mı algılar)
//     final colors = Theme.of(context).colorScheme;

//     return Card(
//       color: colors.surface, // Dinamik zemin rengi
//       elevation: 0,
//       margin: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(
//           color: isPrimary
//               ? colors.primary.withOpacity(0.5)
//               : colors.onSurfaceVariant.withOpacity(0.1),
//           width: 1.5,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Icon(
//               icon,
//               size: 28,
//               color: isPrimary ? colors.primary : colors.onSurfaceVariant,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: colors.onSurfaceVariant, // Dinamik alt metin rengi
//                     letterSpacing: 0.3,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   amount,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: isPrimary
//                         ? colors.primary
//                         : colors.onSurface, // Dinamik ana metin rengi
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SummaryCardComponent extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback? onTap; // Tıklama özelliği eklendi

  const SummaryCardComponent({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    this.isPrimary = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: colors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isPrimary
                ? colors.primary.withOpacity(0.6) // Seçiliyse pembe
                : colors.onSurfaceVariant.withOpacity(
                    0.1,
                  ), // Değilse standart sınır
            width: isPrimary ? 2.0 : 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                size: 28,
                color: isPrimary ? colors.primary : colors.onSurfaceVariant,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: colors.onSurfaceVariant,
                      letterSpacing: 0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isPrimary ? colors.primary : colors.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
