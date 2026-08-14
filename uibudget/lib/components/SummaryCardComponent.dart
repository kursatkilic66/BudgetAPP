// import 'package:flutter/material.dart';

// class SummaryCardComponent extends StatelessWidget {
//   const SummaryCardComponent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Card(
//       elevation: 4,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         spacing: 8,
//         children: [
//           Icon(Icons.wallet),
//           Text("Toplam Harcama"),
//           Text("234342432 USD"),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SummaryCardComponent extends StatelessWidget {
  const SummaryCardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Çok yüksek gölge göz yorar, 2 idealdir
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Köşeleri yumuşattık
      ),
      // Kartın içine doğrudan Column koymak yerine Padding ekliyoruz
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Sola dayalı
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // İçeriği yukarı ve aşağı dağıt
          children: [
            const Icon(
              Icons.account_balance_wallet_outlined,
              size: 32,
              // color: Color(0xFF00ADB5), // Temandaki petrol yeşili rengin
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Toplam Harcama",
                  // style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  "₺ 3.145,20",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
