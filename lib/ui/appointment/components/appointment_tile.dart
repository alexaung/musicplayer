import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thitsarparami/helper/enum.dart';
import 'package:thitsarparami/models/models.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
   const AppointmentTile(this.appointment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: appointment.type == AppointmentType.breakfast
              ? Colors.yellow[900]
              : Colors.cyan,
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.donarName,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${DateFormat.yMMMMd().format(appointment.startDate) } - ${DateFormat.yMMMMd().format(appointment.endDate)}",
                      style: TextStyle(fontSize: 13, color: Colors.grey[100]),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  appointment.note,
                  style: TextStyle(fontSize: 15, color: Colors.grey[100]),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              appointment.type == AppointmentType.breakfast
                  ? "အရုဏ်ဆွမ်း"
                  : "နေ့ဆွမ်း",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
