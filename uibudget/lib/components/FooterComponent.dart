// import 'package:flutter/material.dart';

// class Footercomponent extends StatelessWidget {
//   const Footercomponent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       items: [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: "Anasayfa"),
//         // BottomNavigationBarItem(
//         //   icon: Icon(Icons.stacked_line_chart),
//         //   label: "İstatistik",
//         // ),
//         BottomNavigationBarItem(icon: Icon(Icons.add), label: "Ekle"),
//         BottomNavigationBarItem(icon: Icon(Icons.account_box), label: "Profil"),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class Footercomponent extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Footercomponent({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex, // Hangi sayfanın aktif olduğunu bilir
      onTap: onTap, // Tıklanan index'i main.dart'a iletir
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "Ana Sayfa",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car_outlined),
          activeIcon: Icon(Icons.directions_car),
          label: "Araç",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          activeIcon: Icon(Icons.account_balance_wallet),
          label: "Yaşam",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          activeIcon: Icon(Icons.bar_chart),
          label: "Raporlar",
        ),
      ],
    );
  }
}
