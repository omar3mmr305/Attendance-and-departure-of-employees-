import 'package:flutter/material.dart';
import 'package:workapp/admin/map_screen.dart';
import 'package:workapp/screens/chat_screen.dart';
import 'package:workapp/widgets/costum_container.dart';
import '../employee/score.dart';

class ServiceScreen extends StatelessWidget {
  final String title;
  const ServiceScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: screenHeight / 4,
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Color(0xFF2B4865),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80),
                  ),
                ),
              ),
            ),
            Positioned(
                top: screenHeight * 0.1,
                child: Container(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  width: screenWidth,
                  height: screenHeight / 1.5,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CostumContainer(
                          icon: const Icon(
                            Icons.gps_fixed,
                            size: 64,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MapScreen(
                                  longitude: 39.8166,
                                  latitude: 21.4166,
                                ),
                              ),
                            );
                          },
                          serviceName: 'تحديد الموقع',
                        ),
                        CostumContainer(
                          icon: const Icon(
                            Icons.chat,
                            size: 64,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const ChatScreen()),
                            );
                          },
                          serviceName: 'دردشة',
                        ),
                        CostumContainer(
                          icon: const Icon(
                            Icons.login,
                            size: 64,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const Score()),
                            );
                          },
                          serviceName: 'الحضور و الانصراف',
                        ),
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
