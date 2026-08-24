// import 'package:flutter/material.dart';
// import 'package:uibudget/components/AddExpensePage.dart';
// import 'package:uibudget/components/CarDetailsandPastPage.dart';
// import 'package:uibudget/components/DrawerComponent.dart';
// import 'package:uibudget/components/LifeAndExpensesPage.dart';
// import 'package:uibudget/components/ReportsPage.dart';
// import 'package:uibudget/components/SummaryPage.dart';
// import 'package:uibudget/components/FooterComponent.dart';

// // --- UYGULAMA GENELİ TEMA YÖNETİCİSİ ---
// final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // --- AYDINLIK TEMA (Light - Modern Pastel) ---
//     final ThemeData lightTheme = ThemeData(
//       brightness: Brightness.light,
//       scaffoldBackgroundColor: const Color(0xFFFDF8FA),
//       cardColor: const Color(0xFFFFFFFF),
//       dividerColor: const Color(0xFF9D8493).withOpacity(0.2),
//       appBarTheme: const AppBarTheme(
//         backgroundColor: Color(0xFFFDF8FA),
//         elevation: 0,
//         centerTitle: true,
//         iconTheme: IconThemeData(color: Color(0xFFF472B6)),
//         titleTextStyle: TextStyle(
//           color: Color(0xFF4A2537),
//           fontSize: 20,
//           fontWeight: FontWeight.w600,
//           letterSpacing: 1.0,
//         ),
//       ),
//       colorScheme: const ColorScheme.light(
//         primary: Color(0xFFF472B6), // accentPink
//         secondary: Color(0xFFFB7185),
//         surface: Color(0xFFFFFFFF), // cardDark karşılığı
//         onSurface: Color(0xFF4A2537), // textLight karşılığı (Koyu metin)
//         onSurfaceVariant: Color(0xFF9D8493), // textMuted karşılığı
//       ),
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//         backgroundColor: Color(0xFFFFFFFF),
//         selectedItemColor: Color(0xFFF472B6),
//         unselectedItemColor: Color(0xFF9D8493),
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//         elevation: 8,
//       ),
//     );

//     // --- KARANLIK TEMA (Dark - Gece & Gül Kurusu) ---
//     final ThemeData darkTheme = ThemeData(
//       brightness: Brightness.dark,
//       scaffoldBackgroundColor: const Color(0xFF181216),
//       cardColor: const Color(0xFF241A21),
//       dividerColor: const Color(0xFF8B7382).withOpacity(0.2),
//       appBarTheme: const AppBarTheme(
//         backgroundColor: Color(0xFF181216),
//         elevation: 0,
//         centerTitle: true,
//         iconTheme: IconThemeData(color: Color(0xFFFF7EB3)),
//         titleTextStyle: TextStyle(
//           color: Color(0xFFF3E8EE),
//           fontSize: 20,
//           fontWeight: FontWeight.w600,
//           letterSpacing: 1.0,
//         ),
//       ),
//       colorScheme: const ColorScheme.dark(
//         primary: Color(0xFFFF7EB3), // accentPink
//         secondary: Color(0xFFFFB8D1),
//         surface: Color(0xFF241A21), // cardDark
//         onSurface: Color(0xFFF3E8EE), // textLight
//         onSurfaceVariant: Color(0xFF8B7382), // textMuted
//       ),
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//         backgroundColor: Color(0xFF241A21),
//         selectedItemColor: Color(0xFFFF7EB3),
//         unselectedItemColor: Color(0xFF8B7382),
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//         elevation: 8,
//       ),
//     );

//     return ValueListenableBuilder<ThemeMode>(
//       valueListenable: themeNotifier,
//       builder: (_, ThemeMode currentMode, __) {
//         return MaterialApp(
//           title: 'Budget App',
//           debugShowCheckedModeBanner: false,
//           themeMode: currentMode,
//           theme: lightTheme,
//           darkTheme: darkTheme,
//           home: const MyHomePage(title: 'Bütçe Özeti'),
//         );
//       },
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;

//   // --- BİLDİRİM STATE'LERİ ---
//   int _unreadNotifications = 2;
//   final List<String> _notifications = [
//     "Yakıt alımı başarıyla kaydedildi.",
//     "Aylık gıda bütçenizin %80'ine ulaştınız!",
//   ];

//   final List<Widget> _pages = [
//     const Summarypage(userName: "Kürşat"),
//     const Cardetailsandpastpage(
//       title: "Sally",
//       name: "Kürşat",
//       brand: "Toyota",
//       model: "Yaris",
//       year: "2017",
//     ),
//     const LifeAndExpensesPage(),
//     const ReportsPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _showAddBottomSheet() {
//     final colors = Theme.of(context).colorScheme;

//     // Kullanıcının bulunduğu sayfaya göre formda hangi kategorinin seçili geleceğini belirliyoruz
//     String initialCategory = "Diğer";
//     if (_selectedIndex == 1)
//       initialCategory = "Yakıt"; // Araç sayfasındaysa Yakıt
//     if (_selectedIndex == 2)
//       initialCategory = "Yemek"; // Yaşam sayfasındaysa Yemek

//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Theme.of(context).cardColor,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             left: 20,
//             right: 20,
//             top: 16,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: colors.onSurfaceVariant.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.add_circle_outline,
//                     color: colors.primary,
//                     size: 24,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     "Yeni Harcama Ekle",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: colors.onSurface,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               // FİŞ / FATURA OKU (Yakında)
//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: colors.primary.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.qr_code_scanner, color: colors.primary),
//                 ),
//                 title: Text(
//                   "Fiş / Fatura Oku",
//                   style: TextStyle(
//                     color: colors.onSurface,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 subtitle: Text(
//                   "Kamera ile otomatik tara",
//                   style: TextStyle(
//                     color: colors.onSurfaceVariant,
//                     fontSize: 12,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context); // Bottom sheet'i kapat
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: const Text(
//                         "Yapay Zeka ile Fiş Tarama çok yakında hizmetinizde!",
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       backgroundColor: colors.secondary,
//                       behavior: SnackBarBehavior.floating,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 8),

//               // MANUEL GİRİŞ YAP
//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: colors.secondary.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.edit_note, color: colors.secondary),
//                 ),
//                 title: Text(
//                   "Manuel Giriş Yap",
//                   style: TextStyle(
//                     color: colors.onSurface,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 subtitle: Text(
//                   "Harcama detaylarını kendin gir",
//                   style: TextStyle(
//                     color: colors.onSurfaceVariant,
//                     fontSize: 12,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context); // Bottom sheet'i kapat
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           AddExpensePage(initialCategory: initialCategory),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 32),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         actions: [
//           PopupMenuButton<String>(
//             offset: const Offset(0, 50),
//             color: Theme.of(context).cardColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             onOpened: () {
//               setState(() {
//                 _unreadNotifications = 0;
//               });
//             },
//             icon: Badge(
//               isLabelVisible: _unreadNotifications > 0,
//               label: Text('$_unreadNotifications'),
//               backgroundColor: colors.secondary, // Kırmızımsı pembe
//               child: Icon(
//                 Icons.notifications_none,
//                 color: colors.onSurfaceVariant,
//               ),
//             ),
//             itemBuilder: (BuildContext context) {
//               if (_notifications.isEmpty) {
//                 return [
//                   PopupMenuItem<String>(
//                     enabled: false,
//                     child: Center(
//                       child: Text(
//                         "Bildirim Yok",
//                         style: TextStyle(color: colors.onSurfaceVariant),
//                       ),
//                     ),
//                   ),
//                 ];
//               }
//               return _notifications.map((String notice) {
//                 return PopupMenuItem<String>(
//                   value: notice,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         notice,
//                         style: TextStyle(color: colors.onSurface, fontSize: 13),
//                       ),
//                       const SizedBox(height: 4),
//                       Divider(color: colors.onSurfaceVariant.withOpacity(0.2)),
//                     ],
//                   ),
//                 );
//               }).toList();
//             },
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),
//       drawer: Drawercomponent(
//         semanticLabel: "Kürşat",
//         onItemSelected: _onItemTapped,
//       ),
//       body: _pages[_selectedIndex],

//       // --- AKILLI EKLE BUTONU (FAB) ---
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddBottomSheet,
//         backgroundColor: colors.primary, // Pembe buton
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         child: const Icon(Icons.add, color: Colors.white, size: 28),
//       ),
//       // FAB'ı tam alt menünün ortasına oturtur
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//       bottomNavigationBar: Footercomponent(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:uibudget/components/AddExpensePage.dart';
import 'package:uibudget/components/CarDetailsandPastPage.dart';
import 'package:uibudget/components/DrawerComponent.dart';
import 'package:uibudget/components/LifeAndExpensesPage.dart';
import 'package:uibudget/components/ReportsPage.dart';
import 'package:uibudget/components/SummaryPage.dart';
import 'package:uibudget/components/FooterComponent.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // --- AYDINLIK TEMA ---
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFDF8FA),
      cardColor: const Color(0xFFFFFFFF),
      dividerColor: const Color(0xFF9D8493).withOpacity(0.2),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFDF8FA),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFFF472B6)),
        titleTextStyle: TextStyle(
          color: Color(0xFF4A2537),
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFF472B6),
        secondary: Color(0xFFFB7185),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF4A2537),
        onSurfaceVariant: Color(0xFF9D8493),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFFFFFF),
        selectedItemColor: Color(0xFFF472B6),
        unselectedItemColor: Color(0xFF9D8493),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );

    // --- KARANLIK TEMA ---
    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF181216),
      cardColor: const Color(0xFF241A21),
      dividerColor: const Color(0xFF8B7382).withOpacity(0.2),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF181216),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFFFF7EB3)),
        titleTextStyle: TextStyle(
          color: Color(0xFFF3E8EE),
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFF7EB3),
        secondary: Color(0xFFFFB8D1),
        surface: Color(0xFF241A21),
        onSurface: Color(0xFFF3E8EE),
        onSurfaceVariant: Color(0xFF8B7382),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF241A21),
        selectedItemColor: Color(0xFFFF7EB3),
        unselectedItemColor: Color(0xFF8B7382),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Budget App',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: const MyHomePage(title: 'Bütçe Özeti'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  int _unreadNotifications = 2;
  final List<String> _notifications = [
    "Yakıt alımı başarıyla kaydedildi.",
    "Aylık gıda bütçenizin %80'ine ulaştınız!",
  ];

  // final List<Widget> _pages = [
  //   const Summarypage(userName: "Kürşat"),
  //   const Cardetailsandpastpage(
  //     title: "Sally",
  //     name: "Kürşat",
  //     brand: "Toyota",
  //     model: "Yaris",
  //     year: "2017",
  //   ),
  //   const LifeAndExpensesPage(),
  //   const ReportsPage(),
  // ];

  final List<Widget> _pages = [
    const Summarypage(userName: "Kürşat"),
    const Cardetailsandpastpage(), // <-- Sabit parametreler buradan silindi
    const LifeAndExpensesPage(),
    const ReportsPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showAddBottomSheet() {
    final colors = Theme.of(context).colorScheme;

    String initialCategory = "Diğer";
    if (_selectedIndex == 1) initialCategory = "Yakıt";
    if (_selectedIndex == 2) initialCategory = "Yemek";

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.onSurfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: colors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Yeni Harcama Ekle",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.qr_code_scanner, color: colors.primary),
                ),
                title: Text(
                  "Fiş / Fatura Oku",
                  style: TextStyle(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "Kamera ile otomatik tara",
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Yapay Zeka ile Fiş Tarama çok yakında hizmetinizde!",
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
              const SizedBox(height: 8),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colors.secondary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.edit_note, color: colors.secondary),
                ),
                title: Text(
                  "Manuel Giriş Yap",
                  style: TextStyle(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "Harcama detaylarını kendin gir",
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddExpensePage(initialCategory: initialCategory),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton<String>(
            offset: const Offset(0, 50),
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onOpened: () {
              setState(() {
                _unreadNotifications = 0;
              });
            },
            // Menüden dışarı tıklanıp iptal edilince bildirimleri temizle
            onCanceled: () {
              setState(() {
                _notifications.clear();
              });
            },
            // Bildirimlerden birine tıklanınca temizle
            onSelected: (value) {
              setState(() {
                _notifications.clear();
              });
            },
            icon: Badge(
              isLabelVisible: _unreadNotifications > 0,
              label: Text('$_unreadNotifications'),
              backgroundColor: colors.secondary,
              child: Icon(
                Icons.notifications_none,
                color: colors.onSurfaceVariant,
              ),
            ),
            itemBuilder: (BuildContext context) {
              if (_notifications.isEmpty) {
                return [
                  PopupMenuItem<String>(
                    enabled: false,
                    child: Center(
                      child: Text(
                        "Bildirim Yok",
                        style: TextStyle(color: colors.onSurfaceVariant),
                      ),
                    ),
                  ),
                ];
              }
              return _notifications.map((String notice) {
                return PopupMenuItem<String>(
                  value: notice,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notice,
                        style: TextStyle(color: colors.onSurface, fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Divider(color: colors.onSurfaceVariant.withOpacity(0.2)),
                    ],
                  ),
                );
              }).toList();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawercomponent(
        semanticLabel: "Kürşat",
        onItemSelected: _onItemTapped,
      ),
      body: _pages[_selectedIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBottomSheet,
        backgroundColor: colors.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Footercomponent(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
