import 'package:flutter/material.dart';
import 'package:uibudget/components/SummaryCardComponent.dart';

class Cardetailsandpastpage extends StatefulWidget {
  final String title;
  final String name;
  final String brand;
  final String model;
  final String year;

  const Cardetailsandpastpage({
    super.key,
    required this.title,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
  });

  @override
  State<StatefulWidget> createState() => _CardetailandpastpageState();
}

class _CardetailandpastpageState extends State<Cardetailsandpastpage> {
  // --- TEMA RENKLERİ ---
  static const Color _cardDark = Color(0xFF241A21);
  static const Color _accentPink = Color(0xFFFF7EB3);
  static const Color _textLight = Color(0xFFF3E8EE);
  static const Color _textMuted = Color(0xFF8B7382);

  @override
  Widget build(BuildContext context) {
    // --- 4 FARKLI SENARYOYA UYGUN DİNAMİK VERİ LİSTESİ ---
    final List<Map<String, dynamic>> expenses = [
      {
        "title": "Yakıt Alımı",
        "description": "Opet İstasyonu", // İstasyon bilgisi
        "amount": "₺ 1.450.00",
        "date": "14 Ağu",
        "icon": Icons.local_gas_station,
        "extraInfo": "₺ 41.50 / Lt", // Sadece yakıta özel ekstra bilgi
      },
      {
        "title": "Periyodik Bakım",
        "description":
            "10.000 KM Bakımı (Yağ & Filtre Değişimi)", // Bakım açıklaması
        "amount": "₺ 4.200.00",
        "date": "10 Ağu",
        "icon": Icons.engineering,
      },
      {
        "title": "Otopark",
        "description": "Zorlu Center AVM Otoparkı", // Konum açıklaması
        "amount": "₺ 150.00",
        "date": "08 Ağu",
        "icon": Icons.local_parking,
      },
      {
        "title": "Oto Yıkama",
        "description": "İç / Dış Cilalı Yıkama", // Yıkama açıklaması
        "amount": "₺ 350.00",
        "date": "05 Ağu",
        "icon": Icons.local_car_wash,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- GÖRSEL ALANI ---
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/25004_01.webp',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 180,
            ),
          ),
          const SizedBox(height: 24),

          // --- BAŞLIKLAR ---
          Text(
            "${widget.title} (${widget.name}'in Arabası)",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: _textLight,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${widget.brand} ${widget.model} - ${widget.year}",
            style: const TextStyle(
              fontSize: 16,
              color: _textMuted,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 24),

          // --- ÜST KARTLAR ALANI ---
          Row(
            children: const [
              Expanded(
                child: SummaryCardComponent(
                  title: "Kilometre",
                  amount: "141.366",
                  icon: Icons.speed,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: SummaryCardComponent(
                  title: "Kapasite",
                  amount: "35 Lt",
                  icon: Icons.local_gas_station,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: SummaryCardComponent(
                  title: "Tüketim",
                  amount: "6.8 Lt",
                  icon: Icons.trending_up,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // --- HARCAMALAR LİSTESİ BAŞLIĞI ---
          const Text(
            "Tüketim & Harcama Geçmişi",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _textLight,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),

          // --- KAYDIRILABİLİR HARCAMA KARTLARI LİSTESİ ---
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return _buildExpenseCard(
                  title: expense["title"],
                  description: expense["description"],
                  amount: expense["amount"],
                  date: expense["date"],
                  icon: expense["icon"],
                  extraInfo:
                      expense["extraInfo"], // İsteğe bağlı parametre (Lt fiyatı vb.)
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- GELİŞTİRİLMİŞ HARCAMA KARTI WIDGET'I ---
  Widget _buildExpenseCard({
    required String title,
    required String description,
    required String amount,
    required String date,
    required IconData icon,
    String? extraInfo, // Nullable yapıldı. Sadece veri gönderilirse çizilecek.
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _textMuted.withOpacity(0.15), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _accentPink.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: _accentPink, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: _textLight,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(color: _textMuted, fontSize: 13),
            ),
            // Eğer extraInfo (örn: Lt fiyatı) verilmişse, şık bir etiket olarak çiz
            if (extraInfo != null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _accentPink.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  extraInfo,
                  style: const TextStyle(
                    color: _accentPink,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: const TextStyle(
                color: _textLight,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 6),
            Text(date, style: const TextStyle(color: _textMuted, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
