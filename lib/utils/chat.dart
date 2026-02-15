import 'package:cliniccxc/constant/colorpalet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const WeeklyBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    const weekDays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
    String todayShort = weekDays[DateTime.now().weekday - 1];

    List<Map<String, dynamic>> orderedData = weekDays.map((day) {
      final match = data.firstWhere(
        (e) => (e["day"] ?? "").toString().toUpperCase() == day,
        orElse: () => <String, Object>{"day": day, "count": 0},
      );
      return {
        "day": match["day"] ?? day,
        "count": match["count"] ?? 0,
      };
    }).toList();

    int maxCount =
        orderedData.map((e) => e["count"] as int).fold(0, (a, b) => a > b ? a : b);
    if (maxCount == 0) maxCount = 1;

    double maxBarHeight = 120;

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Weekly Reservations",
              style: TextStyle(
                  color: Mycolors.green, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(orderedData.length, (index) {
                  final day = orderedData[index]["day"] as String;
                  final count = orderedData[index]["count"] as int;
                  final barHeight = maxBarHeight * (count / maxCount);
                  final isToday = day == todayShort;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 25,
                          height: maxBarHeight,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 238, 238, 238),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                              height: barHeight,
                              decoration: BoxDecoration(
                                color: isToday
                                    ? Mycolors.green
                                    : Mycolors.green.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          day,
                          style: const TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final date = DateFormat('EEE, dd MMM').format(now);
    final String greeting = "Good day,";
    final String subText = "Here’s your schedule & summary";

    final int todayCount = 3;
    final int totalCount = 25;
    final double revenue = 120.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Mycolors.green.withOpacity(0.12), Mycolors.green.withOpacity(0.03)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Mycolors.green.withOpacity(0.14)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(date.toUpperCase(),
                        style: TextStyle(color: Mycolors.green, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(greeting,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text(subText, style: TextStyle(color: Colors.grey[700])),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 24,
                backgroundColor: Mycolors.green.withOpacity(0.2),
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatCard("Today's reservations", todayCount.toString(), Colors.orange),
            _buildStatCard("Revenue", "\$${revenue.toStringAsFixed(2)}", Colors.green),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color accent) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(colors: [Colors.white, Colors.white]),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
          border: Border.all(color: const Color.fromARGB(30, 0, 0, 0)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.bar_chart, color: accent, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(title, style: const TextStyle(fontSize: 13))),
              ],
            ),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
