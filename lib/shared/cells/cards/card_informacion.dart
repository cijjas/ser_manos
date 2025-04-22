import 'package:flutter/material.dart';

class CardInformacion extends StatelessWidget {
  final String title;
  final String label1;
  final String content1;
  final String label2;
  final String content2;

  const CardInformacion({
    super.key,
    required this.title,
    required this.label1,
    required this.content1,
    required this.label2,
    required this.content2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      height: 136,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFCAE5FB),
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 24 / 16,
                letterSpacing: 0.15,
                color: Colors.black,
              ),
            ),
          ),

          // Info items container
          Container(
            width: double.infinity,
            height: 96,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFFAFAFA),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoItem(label1, content1),
                _InfoItem(label2, content2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label encima
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            fontSize: 10,
            height: 16 / 10,
            letterSpacing: 1.5,
            color: Color(0xFF666666),
          ),
        ),
        // Content justo debajo, sin espacio extra
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 20 / 14,
            letterSpacing: 0.25,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}