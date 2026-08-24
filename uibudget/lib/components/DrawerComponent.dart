// import 'package:bootstrap_icons/bootstrap_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:uibudget/components/SummaryPage.dart';
// // import 'package:uibudget/pages/CarDetailsAndPastPage.dart'; // Kendi dosya yoluna göre düzeltirsin

// class Drawercomponent extends StatefulWidget {
//   final String semanticLabel;

//   const Drawercomponent({super.key, required this.semanticLabel});

//   @override
//   State<StatefulWidget> createState() => _DrawercomponentState();
// }

// class _DrawercomponentState extends State<Drawercomponent> {
//   // --- ANİMASYON STİLİ (Sadece Ayarlar için kullanılacak) ---
//   final AnimationStyle _smoothAnimation = AnimationStyle(
//     duration: const Duration(milliseconds: 400),
//     curve: Curves.easeInOutCubic,
//   );

//   @override
//   Widget build(BuildContext context) {
//     // --- TASARIM SABİTLERİ (Karanlık Pembe Tema) ---
//     const Color bgDark = Color(0xFF181216); // Ana Zemin
//     const Color cardDark = Color(0xFF241A21); // Başlık Zemini
//     const Color accentPink = Color(0xFFFF7EB3); // Vurgu Pembesi
//     const Color textLight = Color(0xFFF3E8EE); // Ana Metin
//     const Color textMuted = Color(0xFF8B7382); // Pasif Çizgi/İkon Rengi

//     return Drawer(
//       backgroundColor: bgDark,
//       elevation: 0,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//       semanticLabel: widget.semanticLabel,
//       child: ListView(
//         primary: false,
//         physics: const BouncingScrollPhysics(),
//         padding: EdgeInsets.zero,
//         children: [
//           // 1. ÜST BAŞLIK ALANI
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
//                 letterSpacing: 2.0,
//                 color: accentPink,
//               ),
//             ),
//           ),
//           const Divider(height: 1, color: textMuted, thickness: 0.1),
//           const SizedBox(height: 8),

//           // --- DİREKT GEÇİŞLİ ANA MENÜLER ---

//           // 1. Araç Bilgileri & Geçmiş
//           _buildMainMenuTile(
//             context,
//             title: "Araç Bilgileri & Geçmiş",
//             icon: BootstrapIcons.car_front_fill,
//             onTap: () {
//               Navigator.pop(context); // Çekmeceyi kapat
//               // Araç detay sayfasına git
//               /*
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const Cardetailsandpastpage(
//                     title: "Şehir Canavarı",
//                     name: "Kürşat",
//                     brand: "Toyota",
//                     model: "Yaris",
//                     year: "2017",
//                   ),
//                 ),
//               );
//               */
//             },
//           ),

//           // 2. Yaşam & Giderler
//           _buildMainMenuTile(
//             context,
//             title: "Yaşam & Giderler",
//             icon: BootstrapIcons.fork_knife,
//             onTap: () {
//               Navigator.pop(context);
//               // Yaşam ve giderler sayfasına yönlendir
//             },
//           ),

//           // 3. Raporlar
//           _buildMainMenuTile(
//             context,
//             title: "Raporlar",
//             icon: BootstrapIcons.graph_up,
//             onTap: () {
//               Navigator.pop(context);
//               // Raporlar sayfasına yönlendir
//             },
//           ),

//           const SizedBox(height: 8),
//           const Divider(height: 1, color: textMuted, thickness: 0.1),
//           const SizedBox(height: 8),

//           // --- AÇILIR MENÜ (Sadece Sistem & Ayarlar) ---
//           ExpansionTile(
//             expansionAnimationStyle: _smoothAnimation,
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

//   // --- ANA MENÜLER İÇİN YARDIMCI WIDGET ---
//   // Ana menü elemanlarının tasarımını standartlaştırır.
//   Widget _buildMainMenuTile(
//     BuildContext context, {
//     required String title,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
//       leading: Icon(
//         icon,
//         size: 22,
//         color: const Color(0xFFF3E8EE),
//       ), // textLight
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w600,
//           letterSpacing: 0.5,
//           color: Color(0xFFF3E8EE), // textLight
//         ),
//       ),
//       onTap: onTap,
//     );
//   }

//   // --- AYARLAR ALT MENÜSÜ İÇİN YARDIMCI WIDGET ---
//   Widget _buildSubMenuItem({required String title, required IconData icon}) {
//     return ListTile(
//       contentPadding: const EdgeInsets.only(left: 56, right: 16),
//       leading: Icon(
//         icon,
//         size: 18,
//         color: const Color(0xFFF3E8EE).withOpacity(0.7),
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//           letterSpacing: 0.3,
//           color: const Color(0xFFF3E8EE).withOpacity(0.9),
//         ),
//       ),
//       onTap: () {
//         // İlgili ayarlar sayfasına yönlendirme state'i
//       },
//     );
//   }
// }

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:uibudget/components/ThemeSettingsPage.dart';

class Drawercomponent extends StatefulWidget {
  final String semanticLabel;
  final Function(int)
  onItemSelected; // Tıklanan sayfanın index'ini iletmek için

  const Drawercomponent({
    super.key,
    required this.semanticLabel,
    required this.onItemSelected,
  });

  @override
  State<StatefulWidget> createState() => _DrawercomponentState();
}

class _DrawercomponentState extends State<Drawercomponent> {
  final AnimationStyle _smoothAnimation = AnimationStyle(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOutCubic,
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
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
            color: colors.surface,
            child: Text(
              "AKILLI YAKIT & MASRAF",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0,
                color: colors.primary,
              ),
            ),
          ),
          Divider(
            height: 1,
            color: colors.onSurfaceVariant.withOpacity(0.3),
            thickness: 0.1,
          ),
          const SizedBox(height: 8),

          // --- DİREKT GEÇİŞLİ ANA MENÜLER ---

          // 0. Ana Sayfa
          _buildMainMenuTile(
            context,
            title: "Ana Sayfa",
            icon: BootstrapIcons.house_door_fill,
            onTap: () {
              Navigator.pop(context); // Çekmeceyi kapat
              widget.onItemSelected(0); // Index 0: Ana Sayfa
            },
          ),

          // 1. Araç Bilgileri & Geçmiş
          _buildMainMenuTile(
            context,
            title: "Araç Bilgileri & Geçmiş",
            icon: BootstrapIcons.car_front_fill,
            onTap: () {
              Navigator.pop(context);
              widget.onItemSelected(1); // Index 1: Araç Sayfası
            },
          ),

          // 2. Yaşam & Giderler
          _buildMainMenuTile(
            context,
            title: "Yaşam & Giderler",
            icon: BootstrapIcons.fork_knife,
            onTap: () {
              Navigator.pop(context);
              widget.onItemSelected(2); // Index 2: Yaşam & Giderler
            },
          ),

          // 3. Raporlar
          _buildMainMenuTile(
            context,
            title: "Raporlar",
            icon: BootstrapIcons.graph_up,
            onTap: () {
              Navigator.pop(context);
              widget.onItemSelected(3); // Index 3: Raporlar
            },
          ),

          const SizedBox(height: 8),
          Divider(
            height: 1,
            color: colors.onSurfaceVariant.withOpacity(0.3),
            thickness: 0.1,
          ),
          const SizedBox(height: 8),

          // --- AÇILIR MENÜ (Sistem & Ayarlar) ---
          Theme(
            data: theme.copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              expansionAnimationStyle: _smoothAnimation,
              iconColor: colors.primary,
              collapsedIconColor: colors.onSurfaceVariant,
              leading: Icon(
                BootstrapIcons.gear,
                size: 22,
                color: colors.onSurfaceVariant,
              ),
              title: Text(
                "Sistem & Ayarlar",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: colors.onSurface,
                ),
              ),
              children: [
                _buildSubMenuItem(
                  context,
                  title: "Veritabanı / Yedekleme",
                  icon: BootstrapIcons.database,
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Bu özellik çok yakında hizmetinizde!",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        backgroundColor: colors.secondary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
                _buildSubMenuItem(
                  context,
                  title: "Tema & Görünüm",
                  icon: BootstrapIcons.palette,
                  onTap: () {
                    Navigator.pop(context);
                    // Ayarlar sekmesi ana ekranın yapısını bozmamak için üzerine açılır (Navigator.push)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThemeSettingsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Divider(
            height: 1,
            color: colors.onSurfaceVariant.withOpacity(0.3),
            thickness: 0.1,
          ),
        ],
      ),
    );
  }

  // --- ANA MENÜLER İÇİN YARDIMCI WIDGET ---
  Widget _buildMainMenuTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Icon(icon, size: 22, color: colors.onSurface),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: colors.onSurface,
        ),
      ),
      onTap: onTap,
    );
  }

  // --- AYARLAR ALT MENÜSÜ İÇİN YARDIMCI WIDGET ---
  Widget _buildSubMenuItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 56, right: 16),
      leading: Icon(icon, size: 18, color: colors.onSurface.withOpacity(0.7)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.3,
          color: colors.onSurface.withOpacity(0.9),
        ),
      ),
      onTap: onTap,
    );
  }
}
