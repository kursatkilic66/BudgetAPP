// import 'package:bootstrap_icons/bootstrap_icons.dart';
// import 'package:flutter/material.dart';

// class Drawercomponent extends StatefulWidget {
//   // final Color backgroundColor;
//   final String semanticLabel;

//   const Drawercomponent({
//     super.key,
//     // required this.backgroundColor,
//     required this.semanticLabel,
//   });

//   @override
//   State<StatefulWidget> createState() => _DrawercomponentState();
// }

// class _DrawercomponentState extends State<Drawercomponent> {
//   // Standart ExpansionTileController kullanıyoruz
//   final List<ExpansionTileController> controllers = List.generate(
//     4,
//     (_) => ExpansionTileController(),
//   );

//   // KASMAYI ÖNLEYEN DEĞİŞİKLİK: setState kaldırıldı!
//   // Controller zaten tile'ı açıp kapatırken kendi UI'ını günceller.
//   // Tüm çekmeceyi baştan çizdirmemize gerek yok.
//   void _handleExpansion(int index, bool isOpen) {
//     if (isOpen) {
//       for (int i = 0; i < controllers.length; i++) {
//         if (i != index && controllers[i].isExpanded) {
//           controllers[i].collapse();
//         }
//       }
//     }
//   }

//   // --- ANİMASYON STİLİ ---
//   // Tüm tile'larda aynı akıcı efekti kullanmak için bir sabit tanımlıyoruz
//   final AnimationStyle _smoothAnimation = AnimationStyle(
//     duration: const Duration(milliseconds: 400), // Daha yavaş ve tok bir açılış
//     curve: Curves
//         .easeInOutCubic, // Yavaş başlayıp ortada hızlanan, yavaşça biten göz yormayan eğri
//   );

//   @override
//   Widget build(BuildContext context) {
//     // --- TASARIM SABİTLERİ (Karanlık Pembe Tema) ---
//     const Color bgDark = Color(0xFF181216); // Ana Zemin
//     const Color cardDark = Color(0xFF241A21); // Başlık Zemini
//     const Color accentPink = Color(0xFFFF7EB3); // Vurgu Pembesi
//     const Color textMuted = Color(0xFF8B7382); // Pasif Çizgi/İkon Rengi

//     return Drawer(
//       backgroundColor: bgDark,
//       elevation: 0, // Modern tasarımda flat (düz) görünüm daha iyidir
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//       semanticLabel: widget.semanticLabel,
//       child: ListView(
//         primary: false,
//         physics: const BouncingScrollPhysics(),
//         padding: EdgeInsets.zero, // Padding'i sıfırlayıp içeriye dağıtıyoruz
//         children: [
//           // 1. ÜST BAŞLIK ALANI (Modern Overline Tipografisi)
//           Container(
//             padding: const EdgeInsets.only(
//               left: 24,
//               top: 64,
//               bottom: 24,
//               right: 16,
//             ),
//             color: cardDark,
//             child: const Text(
//               "AKILLI YAKIT & MASRAF",
//               style: TextStyle(
//                 fontSize: 12.0,
//                 fontWeight: FontWeight.w800,
//                 letterSpacing:
//                     2.0, // Kurumsal ve modern duruş için harf arası açıldı
//                 color: accentPink,
//               ),
//             ),
//           ),
//           const Divider(height: 1, color: textMuted, thickness: 0.1),
//           const SizedBox(height: 8),

//           // 2. ANA MENÜ ELEMANLARI
//           ExpansionTile(
//             controller: controllers[0],
//             expansionAnimationStyle: _smoothAnimation,
//             onExpansionChanged: (value) => _handleExpansion(0, value),
//             leading: const Icon(BootstrapIcons.car_front_fill, size: 22),
//             title: const Text(
//               "Araç & Yolculuk",
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: 0.5,
//               ),
//             ),
//             children: [
//               _buildSubMenuItem(
//                 title: "Araç Bilgileri & Geçmiş",
//                 icon: BootstrapIcons.speedometer2,
//               ),
//               _buildSubMenuItem(
//                 title: "Yakıt Tüketim Raporları",
//                 icon: BootstrapIcons.fuel_pump,
//               ),
//               _buildSubMenuItem(
//                 title: "Otopark & Geçiş Ücretleri",
//                 icon: BootstrapIcons.ticket_detailed,
//               ),
//             ],
//           ),

//           ExpansionTile(
//             controller: controllers[1],
//             expansionAnimationStyle: _smoothAnimation,
//             onExpansionChanged: (value) => _handleExpansion(1, value),
//             leading: const Icon(BootstrapIcons.fork_knife, size: 22),
//             title: const Text(
//               "Yaşam & Giderler",
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: 0.5,
//               ),
//             ),
//             children: [
//               _buildSubMenuItem(
//                 title: "Dışarıda Yemek Harcamaları",
//                 icon: BootstrapIcons.cup_hot,
//               ),
//               _buildSubMenuItem(
//                 title: "Genel Bütçe & Kategoriler",
//                 icon: BootstrapIcons.wallet2,
//               ),
//             ],
//           ),

//           ExpansionTile(
//             controller: controllers[2],
//             expansionAnimationStyle: _smoothAnimation,
//             onExpansionChanged: (value) => _handleExpansion(2, value),
//             leading: const Icon(BootstrapIcons.graph_up, size: 22),
//             title: const Text(
//               "Analiz & Raporlar",
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: 0.5,
//               ),
//             ),
//             children: [
//               _buildSubMenuItem(
//                 title: "Aylık Harcama Özeti",
//                 icon: BootstrapIcons.bar_chart_line,
//               ),
//               _buildSubMenuItem(
//                 title: "Yakıt Maliyet Trendleri",
//                 icon: BootstrapIcons.graph_up_arrow,
//               ),
//             ],
//           ),

//           ExpansionTile(
//             controller: controllers[3],
//             expansionAnimationStyle: _smoothAnimation,
//             onExpansionChanged: (value) => _handleExpansion(3, value),
//             leading: const Icon(BootstrapIcons.gear, size: 22),
//             title: const Text(
//               "Sistem & Ayarlar",
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: 0.5,
//               ),
//             ),
//             children: [
//               _buildSubMenuItem(
//                 title: "Veritabanı / Yedekleme",
//                 icon: BootstrapIcons.database,
//               ),
//               _buildSubMenuItem(
//                 title: "Tema & Görünüm",
//                 icon: BootstrapIcons.palette,
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),
//           const Divider(height: 1, color: textMuted, thickness: 0.1),
//         ],
//       ),
//     );
//   }

//   // --- ALT MENÜLER İÇİN YARDIMCI WIDGET ---
//   // Kod tekrarını önler, tipografiyi tek merkezden yönetir.
//   Widget _buildSubMenuItem({required String title, required IconData icon}) {
//     return ListTile(
//       contentPadding: const EdgeInsets.only(
//         left: 56,
//         right: 16,
//       ), // Ana ikondan biraz daha içeride durması için
//       leading: Icon(
//         icon,
//         size: 18, // Alt ikonlar hiyerarşik olarak bir tık küçük olmalı
//         color: const Color(0xFFF3E8EE).withOpacity(0.7),
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//           letterSpacing: 0.3, // Göz yormayan hafif harf boşluğu
//           color: const Color(0xFFF3E8EE).withOpacity(0.9),
//         ),
//       ),
//       onTap: () {
//         // İlgili sayfaya yönlendirme state'ini buraya yazabilirsin
//       },
//     );
//   }
// }

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:uibudget/components/SummaryPage.dart';
// import 'package:uibudget/pages/CarDetailsAndPastPage.dart'; // Kendi dosya yoluna göre düzeltirsin

class Drawercomponent extends StatefulWidget {
  final String semanticLabel;

  const Drawercomponent({super.key, required this.semanticLabel});

  @override
  State<StatefulWidget> createState() => _DrawercomponentState();
}

class _DrawercomponentState extends State<Drawercomponent> {
  // --- ANİMASYON STİLİ (Sadece Ayarlar için kullanılacak) ---
  final AnimationStyle _smoothAnimation = AnimationStyle(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOutCubic,
  );

  @override
  Widget build(BuildContext context) {
    // --- TASARIM SABİTLERİ (Karanlık Pembe Tema) ---
    const Color bgDark = Color(0xFF181216); // Ana Zemin
    const Color cardDark = Color(0xFF241A21); // Başlık Zemini
    const Color accentPink = Color(0xFFFF7EB3); // Vurgu Pembesi
    const Color textLight = Color(0xFFF3E8EE); // Ana Metin
    const Color textMuted = Color(0xFF8B7382); // Pasif Çizgi/İkon Rengi

    return Drawer(
      backgroundColor: bgDark,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      semanticLabel: widget.semanticLabel,
      child: ListView(
        primary: false,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          // 1. ÜST BAŞLIK ALANI
          Container(
            padding: const EdgeInsets.only(
              left: 24,
              top: 64,
              bottom: 24,
              right: 16,
            ),
            color: cardDark,
            child: const Text(
              "AKILLI YAKIT & MASRAF",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0,
                color: accentPink,
              ),
            ),
          ),
          const Divider(height: 1, color: textMuted, thickness: 0.1),
          const SizedBox(height: 8),

          // --- DİREKT GEÇİŞLİ ANA MENÜLER ---

          // 1. Araç Bilgileri & Geçmiş
          _buildMainMenuTile(
            context,
            title: "Araç Bilgileri & Geçmiş",
            icon: BootstrapIcons.car_front_fill,
            onTap: () {
              Navigator.pop(context); // Çekmeceyi kapat
              // Araç detay sayfasına git
              /*
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cardetailsandpastpage(
                    title: "Şehir Canavarı",
                    name: "Kürşat",
                    brand: "Toyota",
                    model: "Yaris",
                    year: "2017",
                  ),
                ),
              );
              */
            },
          ),

          // 2. Yaşam & Giderler
          _buildMainMenuTile(
            context,
            title: "Yaşam & Giderler",
            icon: BootstrapIcons.fork_knife,
            onTap: () {
              Navigator.pop(context);
              // Yaşam ve giderler sayfasına yönlendir
            },
          ),

          // 3. Raporlar
          _buildMainMenuTile(
            context,
            title: "Raporlar",
            icon: BootstrapIcons.graph_up,
            onTap: () {
              Navigator.pop(context);
              // Raporlar sayfasına yönlendir
            },
          ),

          const SizedBox(height: 8),
          const Divider(height: 1, color: textMuted, thickness: 0.1),
          const SizedBox(height: 8),

          // --- AÇILIR MENÜ (Sadece Sistem & Ayarlar) ---
          ExpansionTile(
            expansionAnimationStyle: _smoothAnimation,
            leading: const Icon(BootstrapIcons.gear, size: 22),
            title: const Text(
              "Sistem & Ayarlar",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            children: [
              _buildSubMenuItem(
                title: "Veritabanı / Yedekleme",
                icon: BootstrapIcons.database,
              ),
              _buildSubMenuItem(
                title: "Tema & Görünüm",
                icon: BootstrapIcons.palette,
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, color: textMuted, thickness: 0.1),
        ],
      ),
    );
  }

  // --- ANA MENÜLER İÇİN YARDIMCI WIDGET ---
  // Ana menü elemanlarının tasarımını standartlaştırır.
  Widget _buildMainMenuTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Icon(
        icon,
        size: 22,
        color: const Color(0xFFF3E8EE),
      ), // textLight
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: Color(0xFFF3E8EE), // textLight
        ),
      ),
      onTap: onTap,
    );
  }

  // --- AYARLAR ALT MENÜSÜ İÇİN YARDIMCI WIDGET ---
  Widget _buildSubMenuItem({required String title, required IconData icon}) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 56, right: 16),
      leading: Icon(
        icon,
        size: 18,
        color: const Color(0xFFF3E8EE).withOpacity(0.7),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.3,
          color: const Color(0xFFF3E8EE).withOpacity(0.9),
        ),
      ),
      onTap: () {
        // İlgili ayarlar sayfasına yönlendirme state'i
      },
    );
  }
}
