// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:uibudget/components/SummaryCardComponent.dart';

// class LifeAndExpensesPage extends StatefulWidget {
//   const LifeAndExpensesPage({super.key});

//   @override
//   State<StatefulWidget> createState() => _LifeAndExpensesPageState();
// }

// class _LifeAndExpensesPageState extends State<LifeAndExpensesPage> {
//   // TODO: Kendi .NET API adresini buraya yaz
//   final String _baseUrl = "http://10.0.2.2:5268";

//   bool _isLoading = true;
//   List<Map<String, dynamic>> lifeExpenses = [];
//   double _totalMonthlyExpense = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _fetchLifeExpenses();
//   }

//   String _formatDate(String? isoString) {
//     if (isoString == null) return "";
//     try {
//       DateTime date = DateTime.parse(isoString);
//       List<String> months = [
//         "",
//         "Oca",
//         "Şub",
//         "Mar",
//         "Nis",
//         "May",
//         "Haz",
//         "Tem",
//         "Ağu",
//         "Eyl",
//         "Eki",
//         "Kas",
//         "Ara",
//       ];
//       return "${date.day} ${months[date.month]}";
//     } catch (e) {
//       return "";
//     }
//   }

//   // --- API'DEN YAŞAM HARCAMALARINI ÇEKME ---
//   Future<void> _fetchLifeExpenses() async {
//     setState(() => _isLoading = true);
//     List<Map<String, dynamic>> tempList = [];
//     double total = 0;

//     try {
//       final foodRes = await http.get(Uri.parse("$_baseUrl/api/FoodOrders"));
//       if (foodRes.statusCode == 200) {
//         for (var item in jsonDecode(foodRes.body)) {
//           double price = (item['price'] ?? item['Price'] ?? 0).toDouble();
//           total += price;

//           tempList.add({
//             "title": item['food_name'] ?? item['Food_name'] ?? "Yemek Gideri",
//             "description":
//                 item['restaurant'] ??
//                 item['Restaurant'] ??
//                 "Mekan Belirtilmedi",
//             "amount": "₺ $price",
//             "date": _formatDate(item['createdAt'] ?? item['CreatedAt']),
//             "sortDate":
//                 DateTime.tryParse(
//                   item['createdAt'] ?? item['CreatedAt'] ?? "",
//                 ) ??
//                 DateTime.now(),
//             "icon": Icons.fastfood_outlined,
//           });
//         }
//       }

//       tempList.sort((a, b) => b["sortDate"].compareTo(a["sortDate"]));

//       setState(() {
//         lifeExpenses = tempList;
//         _totalMonthlyExpense = total;
//       });
//     } catch (e) {
//       print("API Hatası (Yaşam): $e");
//     } finally {
//       setState(() => _isLoading = false);
//     }
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
//             // --- 1. GENEL AYLIK ÖZET KARTI ---
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//               decoration: BoxDecoration(
//                 color: colors.surface,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: colors.onSurfaceVariant.withOpacity(0.15),
//                   width: 1.5,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     "Bu Ay Toplam Gider: ₺ $_totalMonthlyExpense",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: colors.onSurface,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     _totalMonthlyExpense > 0
//                         ? "Geçmiş Harcamalarınız Listeleniyor"
//                         : "Henüz veri yok",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: colors.onSurfaceVariant.withOpacity(0.8),
//                       letterSpacing: 0.3,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),

//             // --- 2. KATEGORİ BAZLI 3'LÜ KART ALANI ---
//             Row(
//               children: const [
//                 Expanded(
//                   child: SummaryCardComponent(
//                     title: "Konut",
//                     amount: "₺ 0",
//                     icon: Icons.home_outlined,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: SummaryCardComponent(
//                     title: "Gıda",
//                     amount: "₺ 0",
//                     icon: Icons.restaurant_outlined,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: SummaryCardComponent(
//                     title: "Ulaşım",
//                     amount: "₺ 0",
//                     icon: Icons.directions_bus_outlined,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 32),

//             // --- 3. LİSTE BAŞLIĞI ---
//             Text(
//               "Yaşam & Gider Geçmişi",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: colors.onSurface,
//                 letterSpacing: 0.5,
//               ),
//             ),
//             const SizedBox(height: 16),

//             // --- 4. DİNAMİK LİSTE VEYA BOŞ DURUM ---
//             if (_isLoading)
//               const Center(child: CircularProgressIndicator())
//             else if (lifeExpenses.isEmpty)
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 40,
//                   horizontal: 20,
//                 ),
//                 decoration: BoxDecoration(
//                   color: colors.surface,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: colors.onSurfaceVariant.withOpacity(0.15),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.shopping_bag_outlined,
//                       size: 48,
//                       color: colors.onSurfaceVariant.withOpacity(0.5),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       "Henüz bir yaşam gideri eklemediniz.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: colors.onSurfaceVariant,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             else
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: lifeExpenses.length,
//                 itemBuilder: (context, index) {
//                   final expense = lifeExpenses[index];
//                   return _buildExpenseCard(
//                     context,
//                     title: expense["title"],
//                     description: expense["description"],
//                     amount: expense["amount"],
//                     date: expense["date"],
//                     icon: expense["icon"],
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildExpenseCard(
//     BuildContext context, {
//     required String title,
//     required String description,
//     required String amount,
//     required String date,
//     required IconData icon,
//   }) {
//     final colors = Theme.of(context).colorScheme;
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: colors.surface,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: colors.onSurfaceVariant.withOpacity(0.15),
//           width: 1,
//         ),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         leading: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: colors.primary.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: colors.primary, size: 24),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             color: colors.onSurface,
//             fontWeight: FontWeight.w600,
//             fontSize: 15,
//           ),
//         ),
//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: 4.0),
//           child: Text(
//             description,
//             style: TextStyle(color: colors.onSurfaceVariant, fontSize: 13),
//           ),
//         ),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               amount,
//               style: TextStyle(
//                 color: colors.primary,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               date,
//               style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uibudget/components/SummaryCardComponent.dart';

class LifeAndExpensesPage extends StatefulWidget {
  const LifeAndExpensesPage({super.key});

  @override
  State<StatefulWidget> createState() => _LifeAndExpensesPageState();
}

class _LifeAndExpensesPageState extends State<LifeAndExpensesPage> {
  final String _baseUrl = "http://10.0.2.2:5268";

  bool _isLoading = true;
  List<Map<String, dynamic>> lifeExpenses = [];
  double _totalMonthlyExpense = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchLifeExpenses();
  }

  String _formatDate(String? isoString) {
    if (isoString == null) return "";
    try {
      DateTime date = DateTime.parse(isoString);
      List<String> months = [
        "",
        "Oca",
        "Şub",
        "Mar",
        "Nis",
        "May",
        "Haz",
        "Tem",
        "Ağu",
        "Eyl",
        "Eki",
        "Kas",
        "Ara",
      ];
      return "${date.day} ${months[date.month]}";
    } catch (e) {
      return "";
    }
  }

  Future<void> _fetchLifeExpenses() async {
    setState(() => _isLoading = true);
    List<Map<String, dynamic>> tempList = [];
    double total = 0;

    try {
      final foodRes = await http.get(Uri.parse("$_baseUrl/api/FoodOrders"));
      if (foodRes.statusCode == 200) {
        for (var item in jsonDecode(foodRes.body)) {
          // .NET entity alan adlarına uyumlu kontrol (price veya Price)
          double price = (item['price'] ?? item['Price'] ?? 0).toDouble();
          total += price;

          tempList.add({
            "title": item['food_name'] ?? item['Food_name'] ?? "Yemek Gideri",
            "description":
                item['restaurant'] ??
                item['Restaurant'] ??
                "Mekan Belirtilmedi",
            "amount": "₺ $price",
            "date": _formatDate(item['createdAt'] ?? item['CreatedAt']),
            "sortDate":
                DateTime.tryParse(
                  item['createdAt'] ?? item['CreatedAt'] ?? "",
                ) ??
                DateTime.now(),
            "icon": Icons.fastfood_outlined,
          });
        }
      }

      tempList.sort((a, b) => b["sortDate"].compareTo(a["sortDate"]));

      setState(() {
        lifeExpenses = tempList;
        _totalMonthlyExpense = total;
      });
    } catch (e) {
      print("API Hatası (Yaşam): $e");
    } finally {
      setState(() => _isLoading = false);
    }
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
            // --- 1. DİNAMİK TOPLAM GİDER KARTI ---
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
                    "Bu Ay Toplam Gider: ₺ $_totalMonthlyExpense",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _totalMonthlyExpense > 0
                        ? "Geçmiş Harcamalarınız Listeleniyor"
                        : "Henüz veri yok",
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

            // --- 2. KATEGORİ BAZLI 3'LÜ KART (Gıda tutarı dinamikleşti) ---
            Row(
              children: [
                const Expanded(
                  child: SummaryCardComponent(
                    title: "Konut",
                    amount: "₺ 0",
                    icon: Icons.home_outlined,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SummaryCardComponent(
                    title: "Gıda",
                    amount:
                        "₺ $_totalMonthlyExpense", // Gıda harcamaları buraya yansır
                    icon: Icons.restaurant_outlined,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: SummaryCardComponent(
                    title: "Ulaşım",
                    amount: "₺ 0",
                    icon: Icons.directions_bus_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

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

            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (lifeExpenses.isEmpty)
              Container(
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
            else
              ListView.builder(
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
