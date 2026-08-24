// import 'package:flutter/material.dart';
// import 'package:uibudget/components/SummaryCardComponent.dart';

// class LifeAndExpensesPage extends StatefulWidget {
//   const LifeAndExpensesPage({super.key});

//   @override
//   State<StatefulWidget> createState() => _LifeAndExpensesPageState();
// }

// class _LifeAndExpensesPageState extends State<LifeAndExpensesPage> {
//   // --- TEMA RENKLERİ ---
//   static const Color _cardDark = Color(0xFF241A21);
//   static const Color _accentPink = Color(0xFFFF7EB3);
//   static const Color _textLight = Color(0xFFF3E8EE);
//   static const Color _textMuted = Color(0xFF8B7382);

//   @override
//   Widget build(BuildContext context) {
//     // --- YAŞAM & GİDERLER VERİ LİSTESİ ---
//     final List<Map<String, dynamic>> lifeExpenses = [
//       {
//         "title": "Market Alışverişi",
//         "description": "A101 - Haftalık Alışveriş",
//         "amount": "₺ 850.00",
//         "date": "12 Ağu",
//         "icon": Icons.shopping_cart_outlined,
//       },
//       {
//         "title": "Dışarıda Yemek",
//         "description": "Akşam Yemeği (İtalyan Restoranı)",
//         "amount": "₺ 420.50",
//         "date": "13 Ağu",
//         "icon": Icons.restaurant_outlined,
//       },
//       {
//         "title": "Elektrik Faturası",
//         "description": "Enerjisa Temmuz Faturası",
//         "amount": "₺ 620.00",
//         "date": "10 Ağu",
//         "icon": Icons.bolt_outlined,
//       },
//       {
//         "title": "Su Faturası",
//         "description": "İSKİ Temmuz Dönemi",
//         "amount": "₺ 180.00",
//         "date": "08 Ağu",
//         "icon": Icons.water_drop_outlined,
//       },
//       {
//         "title": "İnternet Aboneliği",
//         "description": "Türk Telekom Fiber Faturası",
//         "amount": "₺ 350.00",
//         "date": "05 Ağu",
//         "icon": Icons.wifi,
//       },
//       {
//         "title": "Ev Kirası",
//         "description": "Temmuz Ayı Ev Kirası",
//         "amount": "₺ 6.000.00",
//         "date": "01 Ağu",
//         "icon": Icons.key_outlined,
//       },
//     ];

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // --- 1. GENEL AYLIK ÖZET KARTI ---
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//             decoration: BoxDecoration(
//               color: _cardDark,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 color: _textMuted.withOpacity(0.15),
//                 width: 1.5,
//               ),
//             ),
//             child: Column(
//               children: [
//                 const Text(
//                   "Bu Ay Toplam Gider: ₺ 12.500",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: _textLight,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   "Önceki Aya Göre: +%10",
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: _textMuted.withOpacity(0.8),
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),

//           // --- 2. KATEGORİ BAZLI 3'LÜ KART ALANI ---
//           Row(
//             children: const [
//               Expanded(
//                 child: SummaryCardComponent(
//                   title: "Konut",
//                   amount: "₺ 6.000",
//                   icon: Icons.home_outlined,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Expanded(
//                 child: SummaryCardComponent(
//                   title: "Gıda",
//                   amount: "₺ 3.000",
//                   icon: Icons.restaurant_outlined,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Expanded(
//                 child: SummaryCardComponent(
//                   title: "Ulaşım (Araç Dışı)",
//                   amount: "₺ 1.500",
//                   icon: Icons.directions_bus_outlined,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 32),

//           // --- 3. LİSTE BAŞLIĞI ---
//           const Text(
//             "Yaşam & Gider Geçmişi",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: _textLight,
//               letterSpacing: 0.5,
//             ),
//           ),
//           const SizedBox(height: 16),

//           // --- 4. KAYDIRILABİLİR HARCAMA LİSTESİ ---
//           Expanded(
//             child: ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               itemCount: lifeExpenses.length,
//               itemBuilder: (context, index) {
//                 final expense = lifeExpenses[index];
//                 return _buildExpenseCard(
//                   title: expense["title"],
//                   description: expense["description"],
//                   amount: expense["amount"],
//                   date: expense["date"],
//                   icon: expense["icon"],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- HARCAMA KARTI YARDIMCI WIDGET'I ---
//   Widget _buildExpenseCard({
//     required String title,
//     required String description,
//     required String amount,
//     required String date,
//     required IconData icon,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: _cardDark,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: _textMuted.withOpacity(0.15), width: 1),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         leading: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: _accentPink.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: _accentPink, size: 24),
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(
//             color: _textLight,
//             fontWeight: FontWeight.w600,
//             fontSize: 15,
//           ),
//         ),
//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: 4.0),
//           child: Text(
//             description,
//             style: const TextStyle(color: _textMuted, fontSize: 13),
//           ),
//         ),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               amount,
//               style: const TextStyle(
//                 color:
//                     _accentPink, // Rakamları tasarımdaki gibi pembe yapıyoruz
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(date, style: const TextStyle(color: _textMuted, fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:uibudget/components/SummaryCardComponent.dart';

class LifeAndExpensesPage extends StatefulWidget {
  const LifeAndExpensesPage({super.key});

  @override
  State<StatefulWidget> createState() => _LifeAndExpensesPageState();
}

class _LifeAndExpensesPageState extends State<LifeAndExpensesPage> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // --- LİSTE BİLEREK BOŞ BIRAKILDI ---
    final List<Map<String, dynamic>> lifeExpenses = [];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. GENEL AYLIK ÖZET KARTI (Boş Veri) ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colors.onSurfaceVariant.withOpacity(0.15),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Bu Ay Toplam Gider: ₺ 0.00",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Henüz veri yok",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colors.onSurfaceVariant.withOpacity(0.8),
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- 2. KATEGORİ BAZLI 3'LÜ KART ALANI ---
            Row(
              children: const [
                Expanded(
                  child: SummaryCardComponent(
                    title: "Konut",
                    amount: "₺ 0",
                    icon: Icons.home_outlined,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: SummaryCardComponent(
                    title: "Gıda",
                    amount: "₺ 0",
                    icon: Icons.restaurant_outlined,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: SummaryCardComponent(
                    title: "Ulaşım",
                    amount: "₺ 0",
                    icon: Icons.directions_bus_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // --- 3. LİSTE BAŞLIĞI ---
            Text(
              "Yaşam & Gider Geçmişi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 16),

            // --- 4. DİNAMİK LİSTE VEYA BOŞ DURUM ---
            lifeExpenses.isEmpty
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colors.onSurfaceVariant.withOpacity(0.15),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 48,
                          color: colors.onSurfaceVariant.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Henüz bir yaşam gideri eklemediniz.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lifeExpenses.length,
                    itemBuilder: (context, index) {
                      final expense = lifeExpenses[index];
                      return _buildExpenseCard(
                        context,
                        title: expense["title"],
                        description: expense["description"],
                        amount: expense["amount"],
                        date: expense["date"],
                        icon: expense["icon"],
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseCard(
    BuildContext context, {
    required String title,
    required String description,
    required String amount,
    required String date,
    required IconData icon,
  }) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.onSurfaceVariant.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: colors.primary, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            description,
            style: TextStyle(color: colors.onSurfaceVariant, fontSize: 13),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: TextStyle(
                color: colors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              date,
              style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
