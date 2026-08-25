// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uibudget/components/SummaryCardComponent.dart';

// class Summarypage extends StatefulWidget {
//   final String userName;
//   const Summarypage({super.key, required this.userName});

//   @override
//   State<StatefulWidget> createState() => _SummarypageState();
// }

// class _SummarypageState extends State<Summarypage> {
//   final String _baseUrl = "http://10.0.2.2:5268";

//   bool _isLoading = true;
//   int _activeCardIndex = 0;

//   double _totalExpense = 0.0;
//   double _carExpense = 0.0;
//   double _foodExpense = 0.0;
//   double _generalBudget = 0.0; // Localden çekilecek

//   @override
//   void initState() {
//     super.initState();
//     _fetchSummaryData();
//   }

//   Future<void> _fetchSummaryData() async {
//     setState(() => _isLoading = true);
//     double carTotal = 0;
//     double foodTotal = 0;

//     try {
//       // 1. Genel Bütçeyi Localden Çek
//       final prefs = await SharedPreferences.getInstance();
//       _generalBudget = prefs.getDouble('generalBudget') ?? 0.0;

//       // 2. Araç Giderlerini Topla
//       final fuelRes = await http.get(Uri.parse("$_baseUrl/api/FuelOrders"));
//       if (fuelRes.statusCode == 200) {
//         for (var item in jsonDecode(fuelRes.body))
//           carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
//               .toDouble();
//       }

//       final parkRes = await http.get(Uri.parse("$_baseUrl/api/ParkingOrders"));
//       if (parkRes.statusCode == 200) {
//         for (var item in jsonDecode(parkRes.body))
//           carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
//               .toDouble();
//       }

//       final passRes = await http.get(Uri.parse("$_baseUrl/api/PassingOrders"));
//       if (passRes.statusCode == 200) {
//         for (var item in jsonDecode(passRes.body))
//           carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
//       }

//       final otherRes = await http.get(
//         Uri.parse("$_baseUrl/api/OtherCarOrders"),
//       );
//       if (otherRes.statusCode == 200) {
//         for (var item in jsonDecode(otherRes.body))
//           carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
//       }

//       // 3. Yemek ve Ulaşım Giderlerini Topla
//       final foodRes = await http.get(Uri.parse("$_baseUrl/api/FoodOrders"));
//       if (foodRes.statusCode == 200) {
//         for (var item in jsonDecode(foodRes.body))
//           foodTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
//       }

//       final transRes = await http.get(
//         Uri.parse("$_baseUrl/api/TransportationOrders"),
//       );
//       if (transRes.statusCode == 200) {
//         for (var item in jsonDecode(transRes.body))
//           foodTotal += (item['amount'] ?? item['Amount'] ?? 0).toDouble();
//       }

//       setState(() {
//         _carExpense = carTotal;
//         _foodExpense = foodTotal;
//         _totalExpense = carTotal + foodTotal;
//       });
//     } catch (e) {
//       print("Özet Hatası: $e");
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _selectCard(int index) {
//     setState(() {
//       _activeCardIndex = index;
//     });
//     if (index == 3) _showBudgetDialog();
//   }

//   // --- BÜTÇE BELİRLEME PENCERESİ (LOCAL DB) ---
//   void _showBudgetDialog() {
//     final TextEditingController budgetCtrl = TextEditingController();
//     final colors = Theme.of(context).colorScheme;

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Theme.of(context).cardColor,
//           title: Text(
//             "Genel Bütçe Belirle",
//             style: TextStyle(color: colors.onSurface),
//           ),
//           content: TextField(
//             controller: budgetCtrl,
//             keyboardType: TextInputType.number,
//             style: TextStyle(color: colors.onSurface),
//             decoration: InputDecoration(
//               hintText: "Örn: 15000",
//               hintStyle: TextStyle(color: colors.onSurfaceVariant),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: colors.primary),
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 "İptal",
//                 style: TextStyle(color: colors.onSurfaceVariant),
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
//               onPressed: () async {
//                 double newBudget = double.tryParse(budgetCtrl.text) ?? 0.0;
//                 final prefs = await SharedPreferences.getInstance();
//                 await prefs.setDouble('generalBudget', newBudget);

//                 setState(() {
//                   _generalBudget = newBudget;
//                 });
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 "Kaydet",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
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

//             if (_isLoading)
//               const Center(child: CircularProgressIndicator())
//             else
//               GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 1.05,
//                 children: [
//                   SummaryCardComponent(
//                     title: "Toplam Harcama",
//                     amount: "₺ ${_totalExpense.toStringAsFixed(2)}",
//                     icon: Icons.account_balance_wallet_outlined,
//                     isPrimary: _activeCardIndex == 0,
//                     onTap: () => _selectCard(0),
//                   ),
//                   SummaryCardComponent(
//                     title: "Araç Masrafı",
//                     amount: "₺ ${_carExpense.toStringAsFixed(2)}",
//                     icon: Icons.directions_car_outlined,
//                     isPrimary: _activeCardIndex == 1,
//                     onTap: () => _selectCard(1),
//                   ),
//                   SummaryCardComponent(
//                     title: "Yemek & Ulaşım",
//                     amount: "₺ ${_foodExpense.toStringAsFixed(2)}",
//                     icon: Icons.restaurant_outlined,
//                     isPrimary: _activeCardIndex == 2,
//                     onTap: () => _selectCard(2),
//                   ),
//                   SummaryCardComponent(
//                     title: "Genel Bütçe",
//                     amount: _generalBudget > 0
//                         ? "₺ ${_generalBudget.toStringAsFixed(0)}"
//                         : "Bütçe Belirle",
//                     icon: Icons.pie_chart_outline,
//                     isPrimary: _activeCardIndex == 3,
//                     onTap: () => _selectCard(3),
//                   ),
//                 ],
//               ),

//             const SizedBox(height: 48),

//             if (!_isLoading && _totalExpense == 0)
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.insights,
//                       size: 64,
//                       color: colors.onSurfaceVariant.withOpacity(0.4),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       "Henüz bir harcama verisi bulunmuyor.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: colors.onSurface,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       "Alttaki '+' butonuna basarak ilk harcamanızı ekleyebilirsiniz.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: colors.onSurfaceVariant,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
  double _generalBudget = 0.0; // Artık DB'den gelecek

  @override
  void initState() {
    super.initState();
    _fetchSummaryData();
  }

  Future<void> _fetchSummaryData() async {
    setState(() => _isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    final int currentUserId = prefs.getInt('userId') ?? 0;

    double carTotal = 0;
    double foodTotal = 0;

    try {
      // 1. Genel Bütçeyi API'den Kullanıcı (User) Tablosundan Çek
      final userRes = await http.get(
        Uri.parse("$_baseUrl/api/Users/$currentUserId"),
      );
      if (userRes.statusCode == 200) {
        var userJson = jsonDecode(userRes.body);
        // NOT: C# tarafında property adını ne verdiysen onu yaz (Örn: generalBudget, budget vs.)
        _generalBudget =
            (userJson['budget'] ??
                    userJson['generalBudget'] ??
                    userJson['GeneralBudget'] ??
                    0)
                .toDouble();
      }

      // 2. Araç Giderlerini Topla (ID'ye göre)
      final fuelRes = await http.get(
        Uri.parse("$_baseUrl/api/FuelOrders/$currentUserId"),
      );
      if (fuelRes.statusCode == 200) {
        for (var item in jsonDecode(fuelRes.body)) {
          carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
              .toDouble();
        }
      }

      final parkRes = await http.get(
        Uri.parse("$_baseUrl/api/ParkingOrders/$currentUserId"),
      );
      if (parkRes.statusCode == 200) {
        for (var item in jsonDecode(parkRes.body)) {
          carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
              .toDouble();
        }
      }

      final passRes = await http.get(
        Uri.parse("$_baseUrl/api/PassingOrders/$currentUserId"),
      );
      if (passRes.statusCode == 200) {
        for (var item in jsonDecode(passRes.body)) {
          carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
        }
      }

      final otherRes = await http.get(
        Uri.parse("$_baseUrl/api/OtherCarOrders/$currentUserId"),
      );
      if (otherRes.statusCode == 200) {
        for (var item in jsonDecode(otherRes.body)) {
          carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
        }
      }

      // 3. Yemek ve Ulaşım Giderlerini Topla (ID'ye göre)
      final foodRes = await http.get(
        Uri.parse("$_baseUrl/api/FoodOrders/$currentUserId"),
      );
      if (foodRes.statusCode == 200) {
        for (var item in jsonDecode(foodRes.body)) {
          foodTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
        }
      }

      final transRes = await http.get(
        Uri.parse("$_baseUrl/api/TransportationOrders/$currentUserId"),
      );
      if (transRes.statusCode == 200) {
        for (var item in jsonDecode(transRes.body)) {
          foodTotal += (item['amount'] ?? item['Amount'] ?? 0).toDouble();
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
    if (index == 3) _showBudgetDialog();
  }

  // --- BÜTÇE BELİRLEME PENCERESİ (DB'ye PUT İSTEĞİ) ---
  void _showBudgetDialog() {
    final TextEditingController budgetCtrl = TextEditingController();
    final colors = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            "Genel Bütçe Belirle",
            style: TextStyle(color: colors.onSurface),
          ),
          content: TextField(
            controller: budgetCtrl,
            keyboardType: TextInputType.number,
            style: TextStyle(color: colors.onSurface),
            decoration: InputDecoration(
              hintText: "Örn: 15000",
              hintStyle: TextStyle(color: colors.onSurfaceVariant),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.primary),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "İptal",
                style: TextStyle(color: colors.onSurfaceVariant),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
              onPressed: () async {
                double newBudget = double.tryParse(budgetCtrl.text) ?? 0.0;

                final prefs = await SharedPreferences.getInstance();
                final int currentUserId = prefs.getInt('userId') ?? 0;

                // Veritabanındaki User tablosunu güncelle (PUT)
                // C# API'deki property adına göre "generalBudget" kısmını değiştirebilirsin
                try {
                  await http.put(
                    Uri.parse("$_baseUrl/api/Users/AddBudget/$currentUserId"),
                    headers: {"Content-Type": "application/json"},
                    body: jsonEncode({
                      "id": currentUserId,
                      "budget": newBudget, // DB'deki yeni property
                    }),
                  );
                } catch (e) {
                  print("Bütçe güncellenirken hata: $e");
                }

                setState(() {
                  _generalBudget = newBudget;
                });
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text(
                "Kaydet",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
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
                    title: "Yemek & Ulaşım",
                    amount: "₺ ${_foodExpense.toStringAsFixed(2)}",
                    icon: Icons.restaurant_outlined,
                    isPrimary: _activeCardIndex == 2,
                    onTap: () => _selectCard(2),
                  ),
                  SummaryCardComponent(
                    title: "Genel Bütçe",
                    amount: _generalBudget > 0
                        ? "₺ ${_generalBudget.toStringAsFixed(0)}"
                        : "Bütçe Belirle",
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
