// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class ReportsPage extends StatefulWidget {
//   const ReportsPage({super.key});

//   @override
//   State<StatefulWidget> createState() => _ReportsPageState();
// }

// class _ReportsPageState extends State<ReportsPage> {
//   final String _baseUrl = "http://10.0.2.2:5268";

//   bool _isLoading = true;
//   double _totalCar = 0;
//   double _totalFood = 0;
//   double _totalExpense = 0;
//   double _generalBudget = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _fetchReportData();
//   }

//   Future<void> _fetchReportData() async {
//     setState(() => _isLoading = true);
//     double carTotal = 0;
//     double foodTotal = 0;

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       _generalBudget = prefs.getDouble('generalBudget') ?? 0.0;

//       final fuelRes = await http.get(Uri.parse("$_baseUrl/api/FuelOrders"));
//       if (fuelRes.statusCode == 200)
//         for (var item in jsonDecode(fuelRes.body))
//           carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
//               .toDouble();

//       final parkRes = await http.get(Uri.parse("$_baseUrl/api/ParkingOrders"));
//       if (parkRes.statusCode == 200)
//         for (var item in jsonDecode(parkRes.body))
//           carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
//               .toDouble();

//       final passRes = await http.get(Uri.parse("$_baseUrl/api/PassingOrders"));
//       if (passRes.statusCode == 200)
//         for (var item in jsonDecode(passRes.body))
//           carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();

//       final otherRes = await http.get(
//         Uri.parse("$_baseUrl/api/OtherCarOrders"),
//       );
//       if (otherRes.statusCode == 200)
//         for (var item in jsonDecode(otherRes.body))
//           carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();

//       final foodRes = await http.get(Uri.parse("$_baseUrl/api/FoodOrders"));
//       if (foodRes.statusCode == 200)
//         for (var item in jsonDecode(foodRes.body))
//           foodTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();

//       // Ulaşım
//       final transRes = await http.get(
//         Uri.parse("$_baseUrl/api/TransportationOrders"),
//       );
//       if (transRes.statusCode == 200)
//         for (var item in jsonDecode(transRes.body))
//           foodTotal += (item['amount'] ?? item['Amount'] ?? 0).toDouble();

//       setState(() {
//         _totalCar = carTotal;
//         _totalFood = foodTotal;
//         _totalExpense = carTotal + foodTotal;
//       });
//     } catch (e) {
//       print("Rapor Hatası: $e");
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;
//     bool hasData = _totalExpense > 0;

//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildTargetHealthCard(colors, hasData),
//           const SizedBox(height: 16),

//           if (_isLoading)
//             const Center(child: CircularProgressIndicator())
//           else ...[
//             Row(
//               children: [
//                 Expanded(child: _buildCategoriesCard(colors, hasData)),
//                 const SizedBox(width: 16),
//                 Expanded(child: _buildComparisonCard(colors, hasData)),
//               ],
//             ),
//             const SizedBox(height: 24),

//             Text(
//               "TEMEL ANALİZ & İPUÇLARI",
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w800,
//                 color: colors.onSurface,
//                 letterSpacing: 1.2,
//               ),
//             ),
//             const SizedBox(height: 12),

//             hasData
//                 ? Column(
//                     children: [
//                       if (_totalCar > _totalFood)
//                         _buildInsightCard(
//                           colors,
//                           title: "Araç Giderleri Yüksek!",
//                           description: "Bütçenizin büyük kısmı araca gidiyor.",
//                           icon: Icons.directions_car,
//                           isPositive: false,
//                         )
//                       else
//                         _buildInsightCard(
//                           colors,
//                           title: "Araç Tasarrufu",
//                           description: "Araç harcamalarınız dengeli ilerliyor.",
//                           icon: Icons.thumb_up,
//                           isPositive: true,
//                         ),

//                       if (_generalBudget > 0)
//                         _buildInsightCard(
//                           colors,
//                           title: "Bütçe Durumu",
//                           description:
//                               "Toplam hedefin ${((_totalExpense / _generalBudget) * 100).toStringAsFixed(1)}%'i kullanıldı.",
//                           icon: Icons.pie_chart,
//                           isPositive: true,
//                         ),
//                     ],
//                   )
//                 : Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 30,
//                       horizontal: 20,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(
//                         color: colors.onSurfaceVariant.withOpacity(0.15),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.auto_graph,
//                           size: 40,
//                           color: colors.onSurfaceVariant.withOpacity(0.4),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           "Akıllı analizler için henüz yeterli harcama verisi bulunmuyor.",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: colors.onSurfaceVariant,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _buildTargetHealthCard(ColorScheme colors, bool hasData) {
//     double ratio = (hasData && _generalBudget > 0)
//         ? (_totalExpense / _generalBudget)
//         : 0;

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: colors.primary.withOpacity(0.3), width: 1.5),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "AYLIK HARCAMA HEDEFİ SAĞLIĞI",
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w800,
//               color: colors.onSurface,
//               letterSpacing: 1.0,
//             ),
//           ),
//           const SizedBox(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: 80,
//                 height: 80,
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     CircularProgressIndicator(
//                       value: 1.0,
//                       strokeWidth: 10,
//                       color: colors.onSurfaceVariant.withOpacity(0.2),
//                     ),
//                     if (hasData && _generalBudget > 0)
//                       CircularProgressIndicator(
//                         value: ratio,
//                         strokeWidth: 10,
//                         color: colors.primary,
//                         backgroundColor: Colors.transparent,
//                       ),
//                     Center(
//                       child: Text(
//                         hasData && _generalBudget > 0
//                             ? "%${(ratio * 100).toInt()}"
//                             : "%0",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: colors.onSurface,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     hasData ? "₺ ${_totalExpense.toStringAsFixed(0)}" : "₺ 0",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: colors.onSurface,
//                     ),
//                   ),
//                   Text(
//                     _generalBudget > 0
//                         ? "Hedef: ₺ ${_generalBudget.toStringAsFixed(0)}"
//                         : "Hedef Belirlenmedi",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: colors.onSurfaceVariant.withOpacity(0.8),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoriesCard(ColorScheme colors, bool hasData) {
//     double carRatio = hasData ? (_totalCar / _totalExpense) : 0;
//     double foodRatio = hasData ? (_totalFood / _totalExpense) : 0;

//     return Container(
//       height: 240,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: colors.onSurfaceVariant.withOpacity(0.15),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "KATEGORİLER",
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w800,
//               color: colors.onSurface,
//               letterSpacing: 1.0,
//             ),
//           ),
//           const Spacer(),
//           if (hasData)
//             SizedBox(
//               width: 90,
//               height: 90,
//               child: CustomPaint(
//                 painter: _DynamicDonutChartPainter(
//                   color1: colors.primary,
//                   color2: colors.secondary,
//                   carRatio: carRatio,
//                   foodRatio: foodRatio,
//                 ),
//               ),
//             )
//           else
//             Icon(
//               Icons.pie_chart_outline,
//               size: 64,
//               color: colors.onSurfaceVariant.withOpacity(0.3),
//             ),
//           const Spacer(),
//           if (hasData) ...[
//             _buildLegendItem(
//               "Araç",
//               "%${(carRatio * 100).toInt()}",
//               colors.primary,
//               colors,
//             ),
//             const SizedBox(height: 6),
//             _buildLegendItem(
//               "Yaşam",
//               "%${(foodRatio * 100).toInt()}",
//               colors.secondary,
//               colors,
//             ),
//           ] else
//             Text(
//               "Veri Bekleniyor",
//               style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildComparisonCard(ColorScheme colors, bool hasData) {
//     return Container(
//       height: 240,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: colors.onSurfaceVariant.withOpacity(0.15),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "KARŞILAŞTIRMA",
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w800,
//               color: colors.onSurface,
//               letterSpacing: 1.0,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             hasData ? "Aktif" : "-",
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: colors.onSurfaceVariant,
//             ),
//           ),
//           const Spacer(),
//           if (hasData && _generalBudget > 0)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 _buildBarColumn(
//                   "Hedef",
//                   "₺${(_generalBudget / 1000).toStringAsFixed(1)}k",
//                   100,
//                   colors.onSurfaceVariant.withOpacity(0.5),
//                   colors,
//                 ),
//                 _buildBarColumn(
//                   "Şu An",
//                   "₺${(_totalExpense / 1000).toStringAsFixed(1)}k",
//                   (_totalExpense / _generalBudget) * 100,
//                   colors.primary,
//                   colors,
//                 ),
//               ],
//             )
//           else
//             Icon(
//               Icons.bar_chart,
//               size: 64,
//               color: colors.onSurfaceVariant.withOpacity(0.3),
//             ),
//           if (!hasData || _generalBudget <= 0) const Spacer(),
//         ],
//       ),
//     );
//   }

//   Widget _buildLegendItem(
//     String title,
//     String percent,
//     Color dotColor,
//     ColorScheme colors,
//   ) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Container(
//               width: 8,
//               height: 8,
//               decoration: BoxDecoration(
//                 color: dotColor,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             const SizedBox(width: 6),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 10,
//                 color: colors.onSurfaceVariant,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         Text(
//           percent,
//           style: TextStyle(
//             fontSize: 10,
//             color: colors.onSurface,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBarColumn(
//     String title,
//     String amount,
//     double height,
//     Color barColor,
//     ColorScheme colors,
//   ) {
//     double safeHeight = height > 100 ? 100 : height;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Container(
//           width: 36,
//           height: safeHeight,
//           decoration: BoxDecoration(
//             color: barColor,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(6),
//               topRight: Radius.circular(6),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           title,
//           style: TextStyle(fontSize: 10, color: colors.onSurfaceVariant),
//         ),
//         Text(
//           amount,
//           style: TextStyle(
//             fontSize: 10,
//             color: colors.onSurface,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildInsightCard(
//     ColorScheme colors, {
//     required String title,
//     required String description,
//     required IconData icon,
//     required bool isPositive,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: colors.onSurfaceVariant.withOpacity(0.1),
//           width: 1,
//         ),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         leading: Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: isPositive
//                 ? colors.primary.withOpacity(0.1)
//                 : colors.onSurfaceVariant.withOpacity(0.15),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: isPositive ? colors.primary : colors.onSurfaceVariant,
//             size: 24,
//           ),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             color: colors.onSurface,
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//           ),
//         ),
//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: 4.0),
//           child: Text(
//             description,
//             style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DynamicDonutChartPainter extends CustomPainter {
//   final Color color1;
//   final Color color2;
//   final double carRatio;
//   final double foodRatio;

//   _DynamicDonutChartPainter({
//     required this.color1,
//     required this.color2,
//     required this.carRatio,
//     required this.foodRatio,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     double strokeWidth = 18.0;
//     Rect rect = Rect.fromLTWH(
//       strokeWidth / 2,
//       strokeWidth / 2,
//       size.width - strokeWidth,
//       size.height - strokeWidth,
//     );

//     Paint paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round;

//     double startAngle = -1.57;

//     double carSweep = carRatio * 2 * pi;
//     paint.color = color1;
//     if (carSweep > 0)
//       canvas.drawArc(rect, startAngle, carSweep - 0.1, false, paint);

//     startAngle += carSweep;
//     double foodSweep = foodRatio * 2 * pi;
//     paint.color = color2;
//     if (foodSweep > 0)
//       canvas.drawArc(rect, startAngle, foodSweep - 0.1, false, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final String _baseUrl = "http://10.0.2.2:5268";

  bool _isLoading = true;
  double _totalCar = 0;
  double _totalFood = 0;
  double _totalExpense = 0;
  double _generalBudget = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchReportData();
  }

  Future<void> _fetchReportData() async {
    setState(() => _isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    final int currentUserId = prefs.getInt('userId') ?? 0;

    double carTotal = 0;
    double foodTotal = 0;

    try {
      // 1. Genel bütçeyi Kullanıcı Tablosundan (DB) çek
      final userRes = await http.get(
        Uri.parse("$_baseUrl/api/Users/$currentUserId"),
      );
      if (userRes.statusCode == 200) {
        var userJson = jsonDecode(userRes.body);
        _generalBudget =
            (userJson['budget'] ??
                    userJson['generalBudget'] ??
                    userJson['GeneralBudget'] ??
                    0)
                .toDouble();
      }

      final fuelRes = await http.get(
        Uri.parse("$_baseUrl/api/FuelOrders/$currentUserId"),
      );
      if (fuelRes.statusCode == 200)
        for (var item in jsonDecode(fuelRes.body)) {
          carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
              .toDouble();
        }

      final parkRes = await http.get(
        Uri.parse("$_baseUrl/api/ParkingOrders/$currentUserId"),
      );
      if (parkRes.statusCode == 200)
        for (var item in jsonDecode(parkRes.body)) {
          carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
              .toDouble();
        }

      final passRes = await http.get(
        Uri.parse("$_baseUrl/api/PassingOrders/$currentUserId"),
      );
      if (passRes.statusCode == 200)
        for (var item in jsonDecode(passRes.body)) {
          carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
        }

      final otherRes = await http.get(
        Uri.parse("$_baseUrl/api/OtherCarOrders/$currentUserId"),
      );
      if (otherRes.statusCode == 200)
        for (var item in jsonDecode(otherRes.body)) {
          carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
        }

      final foodRes = await http.get(
        Uri.parse("$_baseUrl/api/FoodOrders/$currentUserId"),
      );
      if (foodRes.statusCode == 200)
        for (var item in jsonDecode(foodRes.body)) {
          foodTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();
        }

      final transRes = await http.get(
        Uri.parse("$_baseUrl/api/TransportationOrders/$currentUserId"),
      );
      if (transRes.statusCode == 200)
        for (var item in jsonDecode(transRes.body)) {
          foodTotal += (item['amount'] ?? item['Amount'] ?? 0).toDouble();
        }

      setState(() {
        _totalCar = carTotal;
        _totalFood = foodTotal;
        _totalExpense = carTotal + foodTotal;
      });
    } catch (e) {
      print("Rapor Hatası: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    bool hasData = _totalExpense > 0;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTargetHealthCard(colors, hasData),
          const SizedBox(height: 16),

          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else ...[
            Row(
              children: [
                Expanded(child: _buildCategoriesCard(colors, hasData)),
                const SizedBox(width: 16),
                Expanded(child: _buildComparisonCard(colors, hasData)),
              ],
            ),
            const SizedBox(height: 24),

            Text(
              "TEMEL ANALİZ & İPUÇLARI",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: colors.onSurface,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),

            hasData
                ? Column(
                    children: [
                      if (_totalCar > _totalFood)
                        _buildInsightCard(
                          colors,
                          title: "Araç Giderleri Yüksek!",
                          description: "Bütçenizin büyük kısmı araca gidiyor.",
                          icon: Icons.directions_car,
                          isPositive: false,
                        )
                      else
                        _buildInsightCard(
                          colors,
                          title: "Araç Tasarrufu",
                          description: "Araç harcamalarınız dengeli ilerliyor.",
                          icon: Icons.thumb_up,
                          isPositive: true,
                        ),

                      if (_generalBudget > 0)
                        _buildInsightCard(
                          colors,
                          title: "Bütçe Durumu",
                          description:
                              "Toplam hedefin ${((_totalExpense / _generalBudget) * 100).toStringAsFixed(1)}%'i kullanıldı.",
                          icon: Icons.pie_chart,
                          isPositive: true,
                        ),
                    ],
                  )
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colors.onSurfaceVariant.withOpacity(0.15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.auto_graph,
                          size: 40,
                          color: colors.onSurfaceVariant.withOpacity(0.4),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Akıllı analizler için henüz yeterli harcama verisi bulunmuyor.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ],
      ),
    );
  }

  Widget _buildTargetHealthCard(ColorScheme colors, bool hasData) {
    double ratio = (hasData && _generalBudget > 0)
        ? (_totalExpense / _generalBudget)
        : 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.primary.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AYLIK HARCAMA HEDEFİ SAĞLIĞI",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: colors.onSurface,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 10,
                      color: colors.onSurfaceVariant.withOpacity(0.2),
                    ),
                    if (hasData && _generalBudget > 0)
                      CircularProgressIndicator(
                        value: ratio,
                        strokeWidth: 10,
                        color: colors.primary,
                        backgroundColor: Colors.transparent,
                      ),
                    Center(
                      child: Text(
                        hasData && _generalBudget > 0
                            ? "%${(ratio * 100).toInt()}"
                            : "%0",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colors.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hasData ? "₺ ${_totalExpense.toStringAsFixed(0)}" : "₺ 0",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                  Text(
                    _generalBudget > 0
                        ? "Hedef: ₺ ${_generalBudget.toStringAsFixed(0)}"
                        : "Hedef Belirlenmedi",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colors.onSurfaceVariant.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesCard(ColorScheme colors, bool hasData) {
    double carRatio = hasData ? (_totalCar / _totalExpense) : 0;
    double foodRatio = hasData ? (_totalFood / _totalExpense) : 0;

    return Container(
      height: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.onSurfaceVariant.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "KATEGORİLER",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: colors.onSurface,
              letterSpacing: 1.0,
            ),
          ),
          const Spacer(),
          if (hasData)
            SizedBox(
              width: 90,
              height: 90,
              child: CustomPaint(
                painter: _DynamicDonutChartPainter(
                  color1: colors.primary,
                  color2: colors.secondary,
                  carRatio: carRatio,
                  foodRatio: foodRatio,
                ),
              ),
            )
          else
            Icon(
              Icons.pie_chart_outline,
              size: 64,
              color: colors.onSurfaceVariant.withOpacity(0.3),
            ),
          const Spacer(),
          if (hasData) ...[
            _buildLegendItem(
              "Araç",
              "%${(carRatio * 100).toInt()}",
              colors.primary,
              colors,
            ),
            const SizedBox(height: 6),
            _buildLegendItem(
              "Yaşam",
              "%${(foodRatio * 100).toInt()}",
              colors.secondary,
              colors,
            ),
          ] else
            Text(
              "Veri Bekleniyor",
              style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
            ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(ColorScheme colors, bool hasData) {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.onSurfaceVariant.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "KARŞILAŞTIRMA",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: colors.onSurface,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hasData ? "Aktif" : "-",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colors.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          if (hasData && _generalBudget > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBarColumn(
                  "Hedef",
                  "₺${(_generalBudget / 1000).toStringAsFixed(1)}k",
                  100,
                  colors.onSurfaceVariant.withOpacity(0.5),
                  colors,
                ),
                _buildBarColumn(
                  "Şu An",
                  "₺${(_totalExpense / 1000).toStringAsFixed(1)}k",
                  (_totalExpense / _generalBudget) * 100,
                  colors.primary,
                  colors,
                ),
              ],
            )
          else
            Icon(
              Icons.bar_chart,
              size: 64,
              color: colors.onSurfaceVariant.withOpacity(0.3),
            ),
          if (!hasData || _generalBudget <= 0) const Spacer(),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    String title,
    String percent,
    Color dotColor,
    ColorScheme colors,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: colors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          percent,
          style: TextStyle(
            fontSize: 10,
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBarColumn(
    String title,
    String amount,
    double height,
    Color barColor,
    ColorScheme colors,
  ) {
    double safeHeight = height > 100 ? 100 : height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 36,
          height: safeHeight,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 10, color: colors.onSurfaceVariant),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 10,
            color: colors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard(
    ColorScheme colors, {
    required String title,
    required String description,
    required IconData icon,
    required bool isPositive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.onSurfaceVariant.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isPositive
                ? colors.primary.withOpacity(0.1)
                : colors.onSurfaceVariant.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isPositive ? colors.primary : colors.onSurfaceVariant,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            description,
            style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

class _DynamicDonutChartPainter extends CustomPainter {
  final Color color1;
  final Color color2;
  final double carRatio;
  final double foodRatio;

  _DynamicDonutChartPainter({
    required this.color1,
    required this.color2,
    required this.carRatio,
    required this.foodRatio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 18.0;
    Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startAngle = -1.57;

    double carSweep = carRatio * 2 * pi;
    paint.color = color1;
    if (carSweep > 0) {
      canvas.drawArc(rect, startAngle, carSweep - 0.1, false, paint);
    }

    startAngle += carSweep;
    double foodSweep = foodRatio * 2 * pi;
    paint.color = color2;
    if (foodSweep > 0) {
      canvas.drawArc(rect, startAngle, foodSweep - 0.1, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
