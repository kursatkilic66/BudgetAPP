// import 'package:flutter/material.dart';
// import 'package:uibudget/components/SummaryCardComponent.dart';

// class Summarypage extends StatefulWidget {
//   final String userName;

//   const Summarypage({super.key, required this.userName});

//   @override
//   State<StatefulWidget> createState() => _SummarypageState();
// }

// class _SummarypageState extends State<Summarypage> {
//   int _activeCardIndex = 0; // İlk kart varsayılan olarak seçili

//   void _selectCard(int index) {
//     setState(() {
//       _activeCardIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;

//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Merhaba ${widget.userName},",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: colors.onSurfaceVariant,
//                 letterSpacing: 0.5,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               "Aylık Durumun",
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: colors.onSurface,
//                 letterSpacing: 1.0,
//               ),
//             ),
//             const SizedBox(height: 24),

//             GridView.count(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisCount: 2,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//               childAspectRatio: 1.05,
//               children: [
//                 SummaryCardComponent(
//                   title: "Toplam Harcama",
//                   amount: "₺ 3.145,20",
//                   icon: Icons.account_balance_wallet_outlined,
//                   isPrimary: _activeCardIndex == 0,
//                   onTap: () => _selectCard(0),
//                 ),
//                 SummaryCardComponent(
//                   title: "Araç Masrafı",
//                   amount: "₺ 650,00",
//                   icon: Icons.directions_car_outlined,
//                   isPrimary: _activeCardIndex == 1,
//                   onTap: () => _selectCard(1),
//                 ),
//                 SummaryCardComponent(
//                   title: "Yemek & Kafe",
//                   amount: "₺ 890,50",
//                   icon: Icons.restaurant_outlined,
//                   isPrimary: _activeCardIndex == 2,
//                   onTap: () => _selectCard(2),
//                 ),
//                 SummaryCardComponent(
//                   title: "Genel Bütçe",
//                   amount: "₺ 1.604,70",
//                   icon: Icons.pie_chart_outline,
//                   isPrimary: _activeCardIndex == 3,
//                   onTap: () => _selectCard(3),
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
import 'package:uibudget/components/SummaryCardComponent.dart';

class Summarypage extends StatefulWidget {
  final String userName;

  const Summarypage({super.key, required this.userName});

  @override
  State<StatefulWidget> createState() => _SummarypageState();
}

class _SummarypageState extends State<Summarypage> {
  int _activeCardIndex = 0;

  void _selectCard(int index) {
    setState(() {
      _activeCardIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Merhaba ${widget.userName},",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colors.onSurfaceVariant,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Aylık Durumun",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 24),

            // --- KARTLAR (Veri yokken 0.00 gösterir) ---
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.05,
              children: [
                SummaryCardComponent(
                  title: "Toplam Harcama",
                  amount: "₺ 0.00",
                  icon: Icons.account_balance_wallet_outlined,
                  isPrimary: _activeCardIndex == 0,
                  onTap: () => _selectCard(0),
                ),
                SummaryCardComponent(
                  title: "Araç Masrafı",
                  amount: "₺ 0.00",
                  icon: Icons.directions_car_outlined,
                  isPrimary: _activeCardIndex == 1,
                  onTap: () => _selectCard(1),
                ),
                SummaryCardComponent(
                  title: "Yemek & Kafe",
                  amount: "₺ 0.00",
                  icon: Icons.restaurant_outlined,
                  isPrimary: _activeCardIndex == 2,
                  onTap: () => _selectCard(2),
                ),
                SummaryCardComponent(
                  title: "Genel Bütçe",
                  amount: "₺ 0.00",
                  icon: Icons.pie_chart_outline,
                  isPrimary: _activeCardIndex == 3,
                  onTap: () => _selectCard(3),
                ),
              ],
            ),

            const SizedBox(height: 48),

            // --- BOŞ DURUM YÖNLENDİRME MESAJI ---
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.insights,
                    size: 48,
                    color: colors.onSurfaceVariant.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Henüz bir harcama verisi bulunmuyor.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Alttaki '+' butonuna basarak ilk harcamanızı ekleyin.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.onSurfaceVariant.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
