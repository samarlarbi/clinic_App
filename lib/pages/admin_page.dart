import 'package:cliniccxc/constant/colorpalet.dart';
import 'package:cliniccxc/utils/MyAppBar.dart';
import 'package:cliniccxc/utils/chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ClinicAdminAppointmentsScreen extends StatefulWidget {
  const ClinicAdminAppointmentsScreen({super.key});

  @override
  State<ClinicAdminAppointmentsScreen> createState() =>
      _ClinicAdminAppointmentsScreenState();
}

class _ClinicAdminAppointmentsScreenState
    extends State<ClinicAdminAppointmentsScreen> {
  List<Map<String, dynamic>> appointments = [
    {
      "id": 1,
      "patientName": "Leorio Paradinight",
      "patientImage": "",
      "treatment": "General Checkup",
      "date": "2026-02-20",
      "startTime": "09:00",
      "endTime": "09:30",
      "status": "scheduled",
    },
    {
      "id": 2,
      "patientName": "Kurapika",
      "patientImage": "",
      "treatment": "Blood Test",
      "date": "2026-02-21",
      "startTime": "10:00",
      "endTime": "10:30",
      "status": "completed",
    },
    {
      "id": 3,
      "patientName": "Gon Freecss",
      "patientImage": "",
      "treatment": "Vaccination",
      "date": "2026-02-22",
      "startTime": "11:00",
      "endTime": "11:15",
      "status": "cancelled",
    },
  ];

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  void updateStatus(int id, String newStatus) {
    setState(() {
      final index = appointments.indexWhere((a) => a["id"] == id);
      if (index != -1) appointments[index]["status"] = newStatus;
    });
  }

  void deleteAppointment(int id) {
    setState(() {
      appointments.removeWhere((a) => a["id"] == id);
    });
  }

  List<Map<String, dynamic>> getWeeklyData() {
    const weekDays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
    Map<String, int> counts = {for (var d in weekDays) d: 0};

    for (var appointment in appointments) {
      if (appointment["date"] != null && appointment["date"].isNotEmpty) {
        DateTime dt = DateTime.parse(appointment["date"]);
        String dayShort = weekDays[dt.weekday - 1];
        counts[dayShort] = (counts[dayShort] ?? 0) + 1;
      }
    }

    return weekDays.map((d) => {"day": d, "count": counts[d] ?? 0}).toList();
  }

  @override
  Widget build(BuildContext context) {
    final weeklyData = getWeeklyData();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: MyAppBar(),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          padding: const EdgeInsets.all(12),
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemCount: appointments.length + 2, // +2: header + chart
          itemBuilder: (context, index) {
            if (index == 0) return const AdminHeader(); // Admin Header
            if (index == 1) return WeeklyBarChart(data: weeklyData); // Chart

            final data = appointments[index - 2];
            final status = data["status"] ?? "scheduled";

            Color statusColor;
            IconData statusIcon;

            switch (status) {
              case "completed":
                statusColor = Colors.green;
                statusIcon = Icons.check_circle;
                break;
              case "cancelled":
                statusColor = Colors.red;
                statusIcon = Icons.cancel;
                break;
              default:
                statusColor = Colors.orange;
                statusIcon = Icons.schedule;
            }

            return Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Patient Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: data["patientImage"] != null &&
                                data["patientImage"].isNotEmpty
                            ? NetworkImage(data["patientImage"])
                            : null,
                        child: data["patientImage"] == null ||
                                data["patientImage"].isEmpty
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          data["patientName"] ?? "Unknown Patient",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(statusIcon, color: statusColor),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    data["treatment"] ?? "No Treatment",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text(data["date"] ?? ""),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16),
                      const SizedBox(width: 8),
                      Text("${data["startTime"] ?? ''} - ${data["endTime"] ?? ''}"),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: status,
                          items: const [
                            DropdownMenuItem(
                                value: "scheduled", child: Text("Scheduled")),
                            DropdownMenuItem(
                                value: "completed", child: Text("Completed")),
                            DropdownMenuItem(
                                value: "cancelled", child: Text("Cancelled")),
                          ],
                          onChanged: (value) {
                            if (value != null) updateStatus(data["id"], value);
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () => deleteAppointment(data["id"]),
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
