// import 'package:bootstrap_icons/bootstrap_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:uibudget/components/ThemeSettingsPage.dart';

// class Drawercomponent extends StatefulWidget {
//   final String semanticLabel;
//   final Function(int)
//   onItemSelected; // Tıklanan sayfanın index'ini iletmek için

//   const Drawercomponent({
//     super.key,
//     required this.semanticLabel,
//     required this.onItemSelected,
//   });

//   @override
//   State<StatefulWidget> createState() => _DrawercomponentState();
// }

// class _DrawercomponentState extends State<Drawercomponent> {
//   final AnimationStyle _smoothAnimation = AnimationStyle(
//     duration: const Duration(milliseconds: 400),
//     curve: Curves.easeInOutCubic,
//   );

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final ColorScheme colors = theme.colorScheme;

//     return Drawer(
//       backgroundColor: theme.scaffoldBackgroundColor,
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
//             color: colors.surface,
//             child: Text(
//               "AKILLI YAKIT & MASRAF",
//               style: TextStyle(
//                 fontSize: 12.0,
//                 fontWeight: FontWeight.w800,
//                 letterSpacing: 2.0,
//                 color: colors.primary,
//               ),
//             ),
//           ),
//           Divider(
//             height: 1,
//             color: colors.onSurfaceVariant.withOpacity(0.3),
//             thickness: 0.1,
//           ),
//           const SizedBox(height: 8),

//           // --- DİREKT GEÇİŞLİ ANA MENÜLER ---

//           // 0. Ana Sayfa
//           _buildMainMenuTile(
//             context,
//             title: "Ana Sayfa",
//             icon: BootstrapIcons.house_door_fill,
//             onTap: () {
//               Navigator.pop(context); // Çekmeceyi kapat
//               widget.onItemSelected(0); // Index 0: Ana Sayfa
//             },
//           ),

//           // 1. Araç Bilgileri & Geçmiş
//           _buildMainMenuTile(
//             context,
//             title: "Araç Bilgileri & Geçmiş",
//             icon: BootstrapIcons.car_front_fill,
//             onTap: () {
//               Navigator.pop(context);
//               widget.onItemSelected(1); // Index 1: Araç Sayfası
//             },
//           ),

//           // 2. Yaşam & Giderler
//           _buildMainMenuTile(
//             context,
//             title: "Yaşam & Giderler",
//             icon: BootstrapIcons.fork_knife,
//             onTap: () {
//               Navigator.pop(context);
//               widget.onItemSelected(2); // Index 2: Yaşam & Giderler
//             },
//           ),

//           // 3. Raporlar
//           _buildMainMenuTile(
//             context,
//             title: "Raporlar",
//             icon: BootstrapIcons.graph_up,
//             onTap: () {
//               Navigator.pop(context);
//               widget.onItemSelected(3); // Index 3: Raporlar
//             },
//           ),

//           const SizedBox(height: 8),
//           Divider(
//             height: 1,
//             color: colors.onSurfaceVariant.withOpacity(0.3),
//             thickness: 0.1,
//           ),
//           const SizedBox(height: 8),

//           // --- AÇILIR MENÜ (Sistem & Ayarlar) ---
//           Theme(
//             data: theme.copyWith(dividerColor: Colors.transparent),
//             child: ExpansionTile(
//               expansionAnimationStyle: _smoothAnimation,
//               iconColor: colors.primary,
//               collapsedIconColor: colors.onSurfaceVariant,
//               leading: Icon(
//                 BootstrapIcons.gear,
//                 size: 22,
//                 color: colors.onSurfaceVariant,
//               ),
//               title: Text(
//                 "Sistem & Ayarlar",
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0.5,
//                   color: colors.onSurface,
//                 ),
//               ),
//               children: [
//                 _buildSubMenuItem(
//                   context,
//                   title: "Veritabanı / Yedekleme",
//                   icon: BootstrapIcons.database,
//                   onTap: () {
//                     Navigator.pop(context);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: const Text(
//                           "Bu özellik çok yakında hizmetinizde!",
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                         backgroundColor: colors.secondary,
//                         behavior: SnackBarBehavior.floating,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 _buildSubMenuItem(
//                   context,
//                   title: "Tema & Görünüm",
//                   icon: BootstrapIcons.palette,
//                   onTap: () {
//                     Navigator.pop(context);
//                     // Ayarlar sekmesi ana ekranın yapısını bozmamak için üzerine açılır (Navigator.push)
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ThemeSettingsPage(),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 16),
//           Divider(
//             height: 1,
//             color: colors.onSurfaceVariant.withOpacity(0.3),
//             thickness: 0.1,
//           ),
//         ],
//       ),
//     );
//   }

//   // --- ANA MENÜLER İÇİN YARDIMCI WIDGET ---
//   Widget _buildMainMenuTile(
//     BuildContext context, {
//     required String title,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     final colors = Theme.of(context).colorScheme;
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
//       leading: Icon(icon, size: 22, color: colors.onSurface),
//       title: Text(
//         title,
//         style: TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.w600,
//           letterSpacing: 0.5,
//           color: colors.onSurface,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }

//   // --- AYARLAR ALT MENÜSÜ İÇİN YARDIMCI WIDGET ---
//   Widget _buildSubMenuItem(
//     BuildContext context, {
//     required String title,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     final colors = Theme.of(context).colorScheme;
//     return ListTile(
//       contentPadding: const EdgeInsets.only(left: 56, right: 16),
//       leading: Icon(icon, size: 18, color: colors.onSurface.withOpacity(0.7)),
//       title: Text(
//         title,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//           letterSpacing: 0.3,
//           color: colors.onSurface.withOpacity(0.9),
//         ),
//       ),
//       onTap: onTap,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uibudget/components/AuthPage.dart';

class Drawercomponent extends StatelessWidget {
  final String semanticLabel;
  final Function(int) onItemSelected;

  const Drawercomponent({
    super.key,
    required this.semanticLabel,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: Theme.of(context).cardColor,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.05),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 36,
                          color: colors.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Budget App",
                        style: TextStyle(
                          color: colors.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),

                // Menü Öğeleri
                _buildDrawerItem(
                  context,
                  icon: Icons.dashboard_outlined,
                  title: "Ana Sayfa",
                  onTap: () {
                    Navigator.pop(context);
                    onItemSelected(0);
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.directions_car_outlined,
                  title: "Araç Giderleri",
                  onTap: () {
                    Navigator.pop(context);
                    onItemSelected(1);
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.restaurant_menu_outlined,
                  title: "Yaşam Giderleri",
                  onTap: () {
                    Navigator.pop(context);
                    onItemSelected(2);
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.bar_chart_outlined,
                  title: "Raporlar",
                  onTap: () {
                    Navigator.pop(context);
                    onItemSelected(3);
                  },
                ),
              ],
            ),
          ),

          // --- DRAWER ALT KISIM (KULLANICI PROFİLİ VE ÇIKIŞ) ---
          Divider(color: colors.onSurfaceVariant.withOpacity(0.2)),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: colors.primary.withOpacity(0.1),
                child: Icon(Icons.person, color: colors.primary),
              ),
              title: Text(
                semanticLabel, // Kürşat Kılıçarslan vb. main.dart'tan gelen isim
                style: TextStyle(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                "Çıkış Yap",
                style: TextStyle(
                  color: colors.error,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () async {
                // Çıkış yapıldığında verileri temizle ve AuthPage'e yönlendir
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                  (route) => false, // Geri tuşunu tamamen iptal eder
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: colors.onSurfaceVariant),
      title: Text(
        title,
        style: TextStyle(
          color: colors.onSurface,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
