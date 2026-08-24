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

//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // --- 1. AYLIK HEDEF SAĞLIĞI ---
//           _buildTargetHealthCard(colors),
//           const SizedBox(height: 16),

//           // --- 2. ORTA BÖLÜM (KATEGORİLER & KARŞILAŞTIRMA) ---
//           Row(
//             children: [
//               Expanded(child: _buildCategoriesCard(colors)),
//               const SizedBox(width: 16),
//               Expanded(child: _buildComparisonCard(colors)),
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

//           // --- 4. İPUÇLARI LİSTESİ ---
//           _buildInsightCard(
//             colors,
//             title: "Yemek Harcamanız Düştü!",
//             description: "Önceki aya göre %15 tasarruf ettiniz. İyi İş!",
//             icon: Icons.restaurant_menu,
//             isPositive: true,
//           ),
//           _buildInsightCard(
//             colors,
//             title: "Yakıt Maliyeti Artışı!",
//             description:
//                 "Yakıt fiyatları ve tüketim arttı. Daha verimli sürüş deneyin.",
//             icon: Icons.trending_up,
//             isPositive: false,
//           ),
//           _buildInsightCard(
//             colors,
//             title: "Dijital Abonelik Tasarrufu!",
//             description: "İki aboneliği iptal ederek ₺ 120 tasarruf ettiniz.",
//             icon: Icons.credit_card,
//             isPositive: true,
//           ),
//         ],
//       ),
//     );
//   }

//   // ===========================================================================
//   // WIDGET BİLEŞENLERİ
//   // ===========================================================================

//   Widget _buildTargetHealthCard(ColorScheme colors) {
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
//                     CircularProgressIndicator(
//                       value: 0.68,
//                       strokeWidth: 10,
//                       color: colors.primary,
//                       backgroundColor: Colors.transparent,
//                     ),
//                     Center(
//                       child: Text(
//                         "68%",
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
//                     "₺ 8.500",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: colors.onSurface,
//                     ),
//                   ),
//                   Text(
//                     "₺ 12.500",
//                     style: TextStyle(
//                       fontSize: 16,
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
//             "Harcama hızınız iyi, hedefin gerisindesiniz.",
//             style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoriesCard(ColorScheme colors) {
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
//           SizedBox(
//             width: 90,
//             height: 90,
//             child: CustomPaint(
//               painter: _DonutChartPainter(
//                 color1: colors.primary,
//                 color2: colors.secondary,
//                 color3: colors.onSurfaceVariant.withOpacity(0.5),
//               ),
//             ),
//           ),
//           const Spacer(),
//           _buildLegendItem("Araç", "28%", colors.primary, colors),
//           const SizedBox(height: 6),
//           _buildLegendItem("Yaşam", "25%", colors.secondary, colors),
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

//   Widget _buildComparisonCard(ColorScheme colors) {
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
//             "-16.6%",
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: colors.onSurfaceVariant,
//             ),
//           ),
//           const Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               _buildBarColumn(
//                 "Geçen Ay",
//                 "₺10.2k",
//                 100,
//                 colors.onSurfaceVariant.withOpacity(0.5),
//                 colors,
//               ),
//               _buildBarColumn("Bu Ay", "₺8.5k", 80, colors.primary, colors),
//             ],
//           ),
//         ],
//       ),
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

import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // --- VERİ YOK SENARYOSU ---
    // İleride veritabanından veri çektiğinde, liste boşsa bu değeri false yapacaksın.
    bool hasData = false;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. AYLIK HEDEF SAĞLIĞI ---
          _buildTargetHealthCard(colors, hasData),
          const SizedBox(height: 16),

          // --- 2. ORTA BÖLÜM (KATEGORİLER & KARŞILAŞTIRMA) ---
          Row(
            children: [
              Expanded(child: _buildCategoriesCard(colors, hasData)),
              const SizedBox(width: 16),
              Expanded(child: _buildComparisonCard(colors, hasData)),
            ],
          ),
          const SizedBox(height: 24),

          // --- 3. TEMEL ANALİZ & İPUÇLARI BAŞLIĞI ---
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

          // --- 4. İPUÇLARI LİSTESİ VEYA BOŞ DURUM ---
          hasData
              ? Column(
                  children: [
                    _buildInsightCard(
                      colors,
                      title: "Yemek Harcamanız Düştü!",
                      description:
                          "Önceki aya göre %15 tasarruf ettiniz. İyi İş!",
                      icon: Icons.restaurant_menu,
                      isPositive: true,
                    ),
                    _buildInsightCard(
                      colors,
                      title: "Yakıt Maliyeti Artışı!",
                      description:
                          "Yakıt fiyatları ve tüketim arttı. Daha verimli sürüş deneyin.",
                      icon: Icons.trending_up,
                      isPositive: false,
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }

  Widget _buildTargetHealthCard(ColorScheme colors, bool hasData) {
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
                        value: 0.68,
                        strokeWidth: 10,
                        color: colors.primary,
                        backgroundColor: Colors.transparent,
                      ),
                    Center(
                      child: Text(
                        hasData ? "68%" : "%0",
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
                    hasData ? "₺ 8.500" : "₺ 0",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                  Text(
                    hasData ? "₺ 12.500" : "Hedef Belirlenmedi",
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
          const SizedBox(height: 20),
          Text(
            hasData
                ? "Harcama hızınız iyi, hedefin gerisindesiniz."
                : "Bütçe hedeflerinizi Ayarlar'dan belirleyebilirsiniz.",
            style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesCard(ColorScheme colors, bool hasData) {
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
                painter: _DonutChartPainter(
                  color1: colors.primary,
                  color2: colors.secondary,
                  color3: colors.onSurfaceVariant.withOpacity(0.5),
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
            _buildLegendItem("Araç", "28%", colors.primary, colors),
            const SizedBox(height: 6),
            _buildLegendItem("Yaşam", "25%", colors.secondary, colors),
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
            hasData ? "-16.6%" : "-",
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
                  "Geçen Ay",
                  "₺10.2k",
                  100,
                  colors.onSurfaceVariant.withOpacity(0.5),
                  colors,
                ),
                _buildBarColumn("Bu Ay", "₺8.5k", 80, colors.primary, colors),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 36,
          height: height,
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

class _DonutChartPainter extends CustomPainter {
  final Color color1;
  final Color color2;
  final Color color3;

  _DonutChartPainter({
    required this.color1,
    required this.color2,
    required this.color3,
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
      ..strokeWidth = strokeWidth;

    paint.color = color1;
    canvas.drawArc(rect, -1.57, 1.8, false, paint);

    paint.color = color2;
    canvas.drawArc(rect, 0.25, 1.5, false, paint);

    paint.color = color3;
    canvas.drawArc(rect, 1.78, 2.9, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
