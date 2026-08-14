import 'package:flutter/material.dart';
import 'package:uibudget/components/AppbarComponent.dart';
import 'package:uibudget/components/DrawerComponent.dart';
import 'package:uibudget/components/FooterComponent.dart';
import 'package:uibudget/components/SummaryPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bütçe Uygulaması',
      debugShowCheckedModeBanner: false,

      // Temayı buradan 'ThemeMode.light', 'ThemeMode.dark' veya
      // 'ThemeMode.system' yaparak kontrol edebilirsin.
      themeMode: ThemeMode.light,

      // ----------------------------------------------------
      // 1. AYDINLIK PEMBE TEMA (Modern Pastel)
      // ----------------------------------------------------
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(
          0xFFFDF8FA,
        ), // Kırık pembe/beyaz zemin
        // Temel renk şeması
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFF472B6), // Ana pembe (İkonlar, butonlar)
          secondary: Color(0xFFFB7185), // İkincil vurgu rengi
          surface: Color(0xFFFFFFFF), // Kart zeminleri
        ),

        // Drawer ve ExpansionTile için aydınlık tema ayarları
        expansionTileTheme: const ExpansionTileThemeData(
          textColor: Color(0xFFF472B6), // Açıkken başlık rengi (Pembe)
          collapsedTextColor: Color(
            0xFF4A2537,
          ), // Kapalıyken başlık rengi (Koyu mürdüm)
          iconColor: Color(0xFFF472B6),
          collapsedIconColor: Color(
            0xFF9D8493,
          ), // Kapalı ok rengi (Soluk pembe-gri)
          backgroundColor: Color(0xFFFFFFFF), // Açık olduğunda tile arka planı
          collapsedBackgroundColor: Colors.transparent,
          childrenPadding: EdgeInsets.only(left: 16),
        ),
      ),

      // ----------------------------------------------------
      // 2. KARANLIK PEMBE TEMA (Gece & Gül Kurusu)
      // ----------------------------------------------------
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(
          0xFF181216,
        ), // Çok koyu mürdüm zemin
        // Karanlık renk şeması
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF7EB3), // Karanlıkta parlayan pembe
          secondary: Color(0xFFFFB8D1),
          surface: Color(0xFF241A21), // Kart zeminleri (Koyu)
        ),

        // Drawer ve ExpansionTile için karanlık tema ayarları
        expansionTileTheme: const ExpansionTileThemeData(
          textColor: Color(0xFFFF7EB3), // Açıkken başlık rengi (Parlak pembe)
          collapsedTextColor: Color(0xFFF3E8EE), // Kapalıyken (Pembemsi beyaz)
          iconColor: Color(0xFFFF7EB3),
          collapsedIconColor: Color(
            0xFF8B7382,
          ), // Kapalı ok rengi (Muted pembe)
          backgroundColor: Color(0xFF241A21), // Açık olduğunda tile arka planı
          collapsedBackgroundColor: Colors.transparent,
          childrenPadding: EdgeInsets.only(left: 16),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(.infinity, 80),
        child: Appbarcomponent(),
      ),
      drawer: Drawercomponent(
        // backgroundColor: Color.fromRGBO(24, 24, 36, 1),
        semanticLabel: "Kursat",
      ),
      body: Summarypage(userName: "Kursat"),
      bottomNavigationBar: Footercomponent(),
    );
  }
}
