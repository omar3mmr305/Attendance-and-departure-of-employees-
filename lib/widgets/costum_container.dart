import 'package:flutter/material.dart';

class CostumContainer extends StatelessWidget {
  final Function()? onTap;
  final Icon icon;
  final String serviceName;

  const CostumContainer({
    super.key,
    required this.onTap,
    required this.icon,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130,
        width: 240,
        decoration: BoxDecoration(
            color: const Color(0xFF256D85),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                offset: const Offset(5, 6),
                blurRadius: 8,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon,
            Text(
              serviceName,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
