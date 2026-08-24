// import 'package:flutter/material.dart';
// import 'package:uibudget/components/SummaryCardComponent.dart';

// class Summarypage extends StatefulWidget {
//   final String userName;

//   const Summarypage({super.key, required this.userName});

//   @override
//   State<StatefulWidget> createState() => _SummarypageState();
// }

// class _SummarypageState extends State<Summarypage> {
//   int _activeCardIndex = 0;

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

//             // --- KARTLAR (Veri yokken 0.00 gösterir) ---
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
//                   amount: "₺ 0.00",
//                   icon: Icons.account_balance_wallet_outlined,
//                   isPrimary: _activeCardIndex == 0,
//                   onTap: () => _selectCard(0),
//                 ),
//                 SummaryCardComponent(
//                   title: "Araç Masrafı",
//                   amount: "₺ 0.00",
//                   icon: Icons.directions_car_outlined,
//                   isPrimary: _activeCardIndex == 1,
//                   onTap: () => _selectCard(1),
//                 ),
//                 SummaryCardComponent(
//                   title: "Yemek & Kafe",
//                   amount: "₺ 0.00",
//                   icon: Icons.restaurant_outlined,
//                   isPrimary: _activeCardIndex == 2,
//                   onTap: () => _selectCard(2),
//                 ),
//                 SummaryCardComponent(
//                   title: "Genel Bütçe",
//                   amount: "₺ 0.00",
//                   icon: Icons.pie_chart_outline,
//                   isPrimary: _activeCardIndex == 3,
//                   onTap: () => _selectCard(3),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 48),

//             // --- BOŞ DURUM YÖNLENDİRME MESAJI ---
//             Center(
//               child: Column(
//                 children: [
//                   Icon(
//                     Icons.insights,
//                     size: 48,
//                     color: colors.onSurfaceVariant.withOpacity(0.3),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     "Henüz bir harcama verisi bulunmuyor.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: colors.onSurfaceVariant,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     "Alttaki '+' butonuna basarak ilk harcamanızı ekleyin.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: colors.onSurfaceVariant.withOpacity(0.8),
//                     ),
//                   ),
//                 ],
//               ),
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

class Summarypage extends StatefulWidget {
  final String userName;

  const Summarypage({super.key, required this.userName});

  @override
  State<StatefulWidget> createState() => _SummarypageState();
}

class _SummarypageState extends State<Summarypage> {
  final String _baseUrl = "http://10.0.2.2:5268";

  bool _isLoading = true;
  int _activeCardIndex = 0;

  double _totalExpense = 0.0;
  double _carExpense = 0.0;
  double _foodExpense = 0.0;
  final double _generalBudget = 12500.0; // Şimdilik Sabit Bütçe Hedefi

  @override
  void initState() {
    super.initState();
    _fetchSummaryData();
  }

  Future<void> _fetchSummaryData() async {
    setState(() => _isLoading = true);
    double carTotal = 0;
    double foodTotal = 0;

    try {
      // 1. Araç Giderlerini Topla
      final fuelRes = await http.get(Uri.parse("$_baseUrl/api/FuelOrders"));
      if (fuelRes.statusCode == 200) {
        for (var item in jsonDecode(fuelRes.body)) {
          carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
              .toDouble();
        }
      }

      final parkRes = await http.get(Uri.parse("$_baseUrl/api/ParkingOrders"));
      if (parkRes.statusCode == 200) {
        for (var item in jsonDecode(parkRes.body)) {
          carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
              .toDouble();
        }
      }

      final passRes = await http.get(Uri.parse("$_baseUrl/api/PassingOrders"));
      if (passRes.statusCode == 200) {
        for (var item in jsonDecode(passRes.body)) {
          carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
        }
      }

      final otherRes = await http.get(
        Uri.parse("$_baseUrl/api/OtherCarOrders"),
      );
      if (otherRes.statusCode == 200) {
        for (var item in jsonDecode(otherRes.body)) {
          carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
        }
      }

      // 2. Yemek/Yaşam Giderlerini Topla
      final foodRes = await http.get(Uri.parse("$_baseUrl/api/FoodOrders"));
      if (foodRes.statusCode == 200) {
        for (var item in jsonDecode(foodRes.body)) {
          foodTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
        }
      }

      setState(() {
        _carExpense = carTotal;
        _foodExpense = foodTotal;
        _totalExpense = carTotal + foodTotal;
      });
    } catch (e) {
      print("Özet Hatası: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

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

            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
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
                    amount: "₺ ${_totalExpense.toStringAsFixed(2)}",
                    icon: Icons.account_balance_wallet_outlined,
                    isPrimary: _activeCardIndex == 0,
                    onTap: () => _selectCard(0),
                  ),
                  SummaryCardComponent(
                    title: "Araç Masrafı",
                    amount: "₺ ${_carExpense.toStringAsFixed(2)}",
                    icon: Icons.directions_car_outlined,
                    isPrimary: _activeCardIndex == 1,
                    onTap: () => _selectCard(1),
                  ),
                  SummaryCardComponent(
                    title: "Yemek & Kafe",
                    amount: "₺ ${_foodExpense.toStringAsFixed(2)}",
                    icon: Icons.restaurant_outlined,
                    isPrimary: _activeCardIndex == 2,
                    onTap: () => _selectCard(2),
                  ),
                  SummaryCardComponent(
                    title: "Genel Bütçe",
                    amount: "₺ ${_generalBudget.toStringAsFixed(2)}",
                    icon: Icons.pie_chart_outline,
                    isPrimary: _activeCardIndex == 3,
                    onTap: () => _selectCard(3),
                  ),
                ],
              ),

            const SizedBox(height: 48),

            if (!_isLoading && _totalExpense == 0)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.insights,
                      size: 64,
                      color: colors.onSurfaceVariant.withOpacity(0.4),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Henüz bir harcama verisi bulunmuyor.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Alttaki '+' butonuna basarak ilk harcamanızı ekleyebilirsiniz.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.onSurfaceVariant,
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
