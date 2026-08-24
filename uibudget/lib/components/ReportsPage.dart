// import 'package:flutter/material.dart';

// class ReportsPage extends StatefulWidget {
//   const ReportsPage({super.key});

//   @override
//   State<StatefulWidget> createState() => _ReportsPageState();
// }

// class _ReportsPageState extends State<ReportsPage> {
//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;

//     // --- VERİ YOK SENARYOSU ---
//     // İleride veritabanından veri çektiğinde, liste boşsa bu değeri false yapacaksın.
//     bool hasData = false;

//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // --- 1. AYLIK HEDEF SAĞLIĞI ---
//           _buildTargetHealthCard(colors, hasData),
//           const SizedBox(height: 16),

//           // --- 2. ORTA BÖLÜM (KATEGORİLER & KARŞILAŞTIRMA) ---
//           Row(
//             children: [
//               Expanded(child: _buildCategoriesCard(colors, hasData)),
//               const SizedBox(width: 16),
//               Expanded(child: _buildComparisonCard(colors, hasData)),
//             ],
//           ),
//           const SizedBox(height: 24),

//           // --- 3. TEMEL ANALİZ & İPUÇLARI BAŞLIĞI ---
//           Text(
//             "TEMEL ANALİZ & İPUÇLARI",
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w800,
//               color: colors.onSurface,
//               letterSpacing: 1.2,
//             ),
//           ),
//           const SizedBox(height: 12),

//           // --- 4. İPUÇLARI LİSTESİ VEYA BOŞ DURUM ---
//           hasData
//               ? Column(
//                   children: [
//                     _buildInsightCard(
//                       colors,
//                       title: "Yemek Harcamanız Düştü!",
//                       description:
//                           "Önceki aya göre %15 tasarruf ettiniz. İyi İş!",
//                       icon: Icons.restaurant_menu,
//                       isPositive: true,
//                     ),
//                     _buildInsightCard(
//                       colors,
//                       title: "Yakıt Maliyeti Artışı!",
//                       description:
//                           "Yakıt fiyatları ve tüketim arttı. Daha verimli sürüş deneyin.",
//                       icon: Icons.trending_up,
//                       isPositive: false,
//                     ),
//                   ],
//                 )
//               : Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 30,
//                     horizontal: 20,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).cardColor,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: colors.onSurfaceVariant.withOpacity(0.15),
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.auto_graph,
//                         size: 40,
//                         color: colors.onSurfaceVariant.withOpacity(0.4),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         "Akıllı analizler için henüz yeterli harcama verisi bulunmuyor.",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: colors.onSurfaceVariant,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTargetHealthCard(ColorScheme colors, bool hasData) {
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
//                     if (hasData)
//                       CircularProgressIndicator(
//                         value: 0.68,
//                         strokeWidth: 10,
//                         color: colors.primary,
//                         backgroundColor: Colors.transparent,
//                       ),
//                     Center(
//                       child: Text(
//                         hasData ? "68%" : "%0",
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
//                     hasData ? "₺ 8.500" : "₺ 0",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: colors.onSurface,
//                     ),
//                   ),
//                   Text(
//                     hasData ? "₺ 12.500" : "Hedef Belirlenmedi",
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
//           const SizedBox(height: 20),
//           Text(
//             hasData
//                 ? "Harcama hızınız iyi, hedefin gerisindesiniz."
//                 : "Bütçe hedeflerinizi Ayarlar'dan belirleyebilirsiniz.",
//             style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoriesCard(ColorScheme colors, bool hasData) {
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
//                 painter: _DonutChartPainter(
//                   color1: colors.primary,
//                   color2: colors.secondary,
//                   color3: colors.onSurfaceVariant.withOpacity(0.5),
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
//             _buildLegendItem("Araç", "28%", colors.primary, colors),
//             const SizedBox(height: 6),
//             _buildLegendItem("Yaşam", "25%", colors.secondary, colors),
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
//             hasData ? "-16.6%" : "-",
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: colors.onSurfaceVariant,
//             ),
//           ),
//           const Spacer(),
//           if (hasData)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 _buildBarColumn(
//                   "Geçen Ay",
//                   "₺10.2k",
//                   100,
//                   colors.onSurfaceVariant.withOpacity(0.5),
//                   colors,
//                 ),
//                 _buildBarColumn("Bu Ay", "₺8.5k", 80, colors.primary, colors),
//               ],
//             )
//           else
//             Icon(
//               Icons.bar_chart,
//               size: 64,
//               color: colors.onSurfaceVariant.withOpacity(0.3),
//             ),
//           if (!hasData) const Spacer(),
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
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Container(
//           width: 36,
//           height: height,
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

// class _DonutChartPainter extends CustomPainter {
//   final Color color1;
//   final Color color2;
//   final Color color3;

//   _DonutChartPainter({
//     required this.color1,
//     required this.color2,
//     required this.color3,
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
//       ..strokeWidth = strokeWidth;

//     paint.color = color1;
//     canvas.drawArc(rect, -1.57, 1.8, false, paint);

//     paint.color = color2;
//     canvas.drawArc(rect, 0.25, 1.5, false, paint);

//     paint.color = color3;
//     canvas.drawArc(rect, 1.78, 2.9, false, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final double _generalBudget = 12500.0;

  @override
  void initState() {
    super.initState();
    _fetchReportData();
  }

  Future<void> _fetchReportData() async {
    setState(() => _isLoading = true);
    double carTotal = 0;
    double foodTotal = 0;

    try {
      final fuelRes = await http.get(Uri.parse("$_baseUrl/api/FuelOrders"));
      if (fuelRes.statusCode == 200)
        for (var item in jsonDecode(fuelRes.body))
          carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
              .toDouble();

      final parkRes = await http.get(Uri.parse("$_baseUrl/api/ParkingOrders"));
      if (parkRes.statusCode == 200)
        for (var item in jsonDecode(parkRes.body))
          carTotal += (item['total_price'] ?? item['Total_price'] ?? 0)
              .toDouble();

      final passRes = await http.get(Uri.parse("$_baseUrl/api/PassingOrders"));
      if (passRes.statusCode == 200)
        for (var item in jsonDecode(passRes.body))
          carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();

      final otherRes = await http.get(
        Uri.parse("$_baseUrl/api/OtherCarOrders"),
      );
      if (otherRes.statusCode == 200)
        for (var item in jsonDecode(otherRes.body))
          carTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();

      final foodRes = await http.get(Uri.parse("$_baseUrl/api/FoodOrders"));
      if (foodRes.statusCode == 200)
        for (var item in jsonDecode(foodRes.body))
          foodTotal += (item['price'] ?? item['Price'] ?? 0).toDouble();

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
    double ratio = hasData ? (_totalExpense / _generalBudget) : 0;

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
                    if (hasData)
                      CircularProgressIndicator(
                        value: ratio,
                        strokeWidth: 10,
                        color: colors.primary,
                        backgroundColor: Colors.transparent,
                      ),
                    Center(
                      child: Text(
                        hasData ? "%${(ratio * 100).toInt()}" : "%0",
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
                    "₺ ${_generalBudget.toStringAsFixed(0)}",
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
          if (hasData)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBarColumn(
                  "Hedef",
                  "₺12.5k",
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
          if (!hasData) const Spacer(),
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
    // Bar yüksekliğini 100 ile sınırlıyoruz taşmayı önlemek için
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

    double startAngle = -1.57; // -90 dereceden (en üstten) başlar

    // Araç Dilimi Çizimi
    double carSweep = carRatio * 2 * pi;
    paint.color = color1;
    if (carSweep > 0)
      canvas.drawArc(rect, startAngle, carSweep - 0.1, false, paint);

    // Yemek Dilimi Çizimi
    startAngle += carSweep;
    double foodSweep = foodRatio * 2 * pi;
    paint.color = color2;
    if (foodSweep > 0)
      canvas.drawArc(rect, startAngle, foodSweep - 0.1, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true; // Değerler değiştikçe yeniden çizilmesi için true yapıldı
}
