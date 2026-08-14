import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class Drawercomponent extends StatefulWidget {
  // final Color backgroundColor;
  final String semanticLabel;

  const Drawercomponent({
    super.key,
    // required this.backgroundColor,
    required this.semanticLabel,
  });

  @override
  State<StatefulWidget> createState() => _DrawercomponentState();
}

class _DrawercomponentState extends State<Drawercomponent> {
  // Standart ExpansionTileController kullanıyoruz
  final List<ExpansionTileController> controllers = List.generate(
    4,
    (_) => ExpansionTileController(),
  );

  // KASMAYI ÖNLEYEN DEĞİŞİKLİK: setState kaldırıldı!
  // Controller zaten tile'ı açıp kapatırken kendi UI'ını günceller.
  // Tüm çekmeceyi baştan çizdirmemize gerek yok.
  void _handleExpansion(int index, bool isOpen) {
    if (isOpen) {
      for (int i = 0; i < controllers.length; i++) {
        if (i != index && controllers[i].isExpanded) {
          controllers[i].collapse();
        }
      }
    }
  }

  // --- ANİMASYON STİLİ ---
  // Tüm tile'larda aynı akıcı efekti kullanmak için bir sabit tanımlıyoruz
  final AnimationStyle _smoothAnimation = AnimationStyle(
    duration: const Duration(milliseconds: 400), // Daha yavaş ve tok bir açılış
    curve: Curves
        .easeInOutCubic, // Yavaş başlayıp ortada hızlanan, yavaşça biten göz yormayan eğri
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: widget.backgroundColor,
      elevation: 4,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      semanticLabel: widget.semanticLabel,
      child: ListView(
        primary: false,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12.0),
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            // color: const Color.fromRGBO(24, 24, 36, 1),
            height: 80.0,
            margin: const EdgeInsets.fromLTRB(16, 32, 8, 0),
            child: const Text(
              "Akıllı Yakıt & Masraf Takipçisi",
              style: TextStyle(
                fontSize: 16.0,
                letterSpacing: 1.2,
                // fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),

          ExpansionTile(
            controller: controllers[0],
            leading: const Icon(BootstrapIcons.car_front_fill),
            title: const Text("Araç & Yolculuk"),
            expansionAnimationStyle: _smoothAnimation, // YENİ: Akıcı Animasyon
            onExpansionChanged: (value) => _handleExpansion(0, value),
            children: const [
              ListTile(
                title: Text("Araç Bilgileri & Kilometre Geçmişi"),
                leading: Icon(BootstrapIcons.speedometer2),
              ),
              ListTile(
                title: Text("Yakıt Tüketim Raporları"),
                leading: Icon(BootstrapIcons.fuel_pump),
              ),
              ListTile(
                title: Text("Otopark & Geçiş Ücretleri"),
                leading: Icon(BootstrapIcons.ticket_detailed),
              ),
            ],
          ),

          ExpansionTile(
            controller: controllers[1],
            leading: const Icon(BootstrapIcons.fork_knife),
            title: const Text("Yaşam & Giderler"),
            expansionAnimationStyle: _smoothAnimation, // YENİ: Akıcı Animasyon
            onExpansionChanged: (value) => _handleExpansion(1, value),
            children: const [
              ListTile(
                title: Text("Dışarıda Yemek Harcamaları"),
                leading: Icon(BootstrapIcons.cup_hot),
              ),
              ListTile(
                title: Text("Genel Bütçe & Kategoriler"),
                leading: Icon(BootstrapIcons.wallet2),
              ),
            ],
          ),

          ExpansionTile(
            controller: controllers[2],
            leading: const Icon(BootstrapIcons.graph_up),
            title: const Text("Analiz & Raporlar"),
            expansionAnimationStyle: _smoothAnimation, // YENİ: Akıcı Animasyon
            onExpansionChanged: (value) => _handleExpansion(2, value),
            children: const [
              ListTile(
                title: Text("Aylık Harcama Özeti"),
                leading: Icon(BootstrapIcons.bar_chart_line),
              ),
              ListTile(
                title: Text("Yakıt Maliyet Trendleri"),
                leading: Icon(BootstrapIcons.graph_up_arrow),
              ),
            ],
          ),

          ExpansionTile(
            controller: controllers[3],
            leading: const Icon(BootstrapIcons.gear),
            title: const Text("Sistem & Ayarlar"),
            expansionAnimationStyle: _smoothAnimation, // YENİ: Akıcı Animasyon
            onExpansionChanged: (value) => _handleExpansion(3, value),
            children: const [
              ListTile(
                title: Text("Veritabanı / Yedekleme"),
                leading: Icon(BootstrapIcons.database),
              ),
              ListTile(
                title: Text("Tema & Görünüm"),
                leading: Icon(BootstrapIcons.palette),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
