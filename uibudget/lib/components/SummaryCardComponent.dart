import 'package:flutter/material.dart';

class SummaryCardComponent extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final bool isPrimary; // Kartın vurgulu olup olmayacağını belirler

  const SummaryCardComponent({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF241A21), // cardDark
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        // Ana kart ise belirgin pembe çerçeve, değilse çok silik çerçeve
        side: BorderSide(
          color: isPrimary
              ? const Color(0xFFFF7EB3).withOpacity(0.5)
              : const Color(0xFF8B7382).withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 28,
              color: isPrimary
                  ? const Color(0xFFFF7EB3)
                  : const Color(0xFF8B7382),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8B7382), // textMuted
                    letterSpacing: 0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isPrimary
                        ? const Color(0xFFFF7EB3)
                        : const Color(0xFFF3E8EE), // Vurgulu kartta tutar pembe
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
