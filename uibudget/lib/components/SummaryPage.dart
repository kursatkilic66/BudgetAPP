import 'package:flutter/material.dart';
import 'package:uibudget/components/SummaryCardComponent.dart';

class Summarypage extends StatefulWidget {
  final String userName;

  const Summarypage({super.key, required this.userName});

  @override
  State<StatefulWidget> createState() => _SummarypageState();
}

class _SummarypageState extends State<Summarypage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Sola dayalı düzen
        children: [
          Text(
            "Merhaba ${widget.userName},",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8B7382), // textMuted
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Aylık Durumun",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF3E8EE), // textLight
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(
            height: 24,
          ), // Başlık ile kartlar arası nefes alma boşluğu

          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.05, // Kartları biraz daha dengeli yapar
              physics: const BouncingScrollPhysics(),
              children: const [
                // Verileri State'ten alacağın zaman buraya parametre geçersin
                SummaryCardComponent(
                  title: "Toplam Harcama",
                  amount: "₺ 3.145,20",
                  icon: Icons.account_balance_wallet_outlined,
                  isPrimary: true,
                ),
                SummaryCardComponent(
                  title: "Araç Masrafı",
                  amount: "₺ 650,00",
                  icon: Icons.directions_car_outlined,
                ),
                SummaryCardComponent(
                  title: "Yemek & Kafe",
                  amount: "₺ 890,50",
                  icon: Icons.restaurant_outlined,
                ),
                SummaryCardComponent(
                  title: "Genel Bütçe",
                  amount: "₺ 1.604,70",
                  icon: Icons.pie_chart_outline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
