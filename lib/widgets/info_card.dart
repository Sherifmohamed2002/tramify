import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final String? footer;
  final Widget? child;

  const InfoCard({
    Key? key,
    required this.title,
    required this.content,
    this.footer,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 640;
    final padding =
        isSmallScreen ? const EdgeInsets.all(24.0) : const EdgeInsets.all(48.0);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40323D5D),
            offset: Offset(0, 13),
            blurRadius: 27,
            spreadRadius: -5,
          ),
          BoxShadow(
            color: Color(0x4D000000),
            offset: Offset(0, 8),
            blurRadius: 16,
            spreadRadius: -8,
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.displayMedium,
              semanticsLabel: title,
            ),
            const SizedBox(height: 24),
            if (content.isNotEmpty)
              Text(content, style: Theme.of(context).textTheme.bodyMedium),
            if (child != null) child!,
            if (footer != null) ...[
              const SizedBox(height: 16),
              Text(
                footer!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF635BFF),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
