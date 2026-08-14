// import 'package:flutter/material.dart';
// import 'package:uibudget/components/SummaryCardComponent.dart';

// class Summarypage extends StatefulWidget {
//   final String userName;

//   const Summarypage({super.key, required this.userName});

//   @override
//   State<StatefulWidget> createState() => _SummarypageState();
// }

// class _SummarypageState extends State<Summarypage> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Padding(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         // mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "Merhaba ${widget.userName}",
//             style: TextStyle(
//               fontSize: 26,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 1.2,
//               wordSpacing: 1.2,
//             ),
//           ),
//           Text(
//             "Aylık Durumun",
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 1.2,
//               wordSpacing: 1.2,
//             ),
//           ),
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: 2,
//               // padding: EdgeInsets.all(12),
//               children: [
//                 SummaryCardComponent(),
//                 SummaryCardComponent(),
//                 SummaryCardComponent(),
//                 SummaryCardComponent(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
      padding: const EdgeInsets.all(16),
      child: Column(
        // mainAxisSize: MainAxisSize.min BURADAN KALDIRILDI! (Varsayılan olarak .max kalmalı)
        mainAxisAlignment: MainAxisAlignment.start, // Yukarıdan başla
        crossAxisAlignment: CrossAxisAlignment
            .start, // Yazıları sola daya (Dashboard görünümü için)
        children: [
          Text(
            "Merhaba ${widget.userName}",
            style: const TextStyle(
              fontSize: 18, // Biraz küçülttük ki kurumsal dursun
              // color: Colors.grey, // Alt başlık hissiyatı
            ),
          ),
          SizedBox(height: 24),
          const SizedBox(height: 4),
          const Text(
            "Aylık Durumun",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 24), // Başlık ile kartlar arasına boşluk

          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16, // Kartlar arası yatay boşluk
              mainAxisSpacing: 16, // Kartlar arası dikey boşluk
              childAspectRatio:
                  1.1, // Kartların kare değil, hafif dikdörtgen olmasını sağlar
              children: const [
                SummaryCardComponent(),
                SummaryCardComponent(),
                SummaryCardComponent(),
                SummaryCardComponent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
