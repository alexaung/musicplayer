import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/services/services.dart';

class AppointmentRespository {
  AppointmentApiProvider appointmentApiProvider;
  // ignore: unnecessary_null_comparison
  AppointmentRespository(this.appointmentApiProvider) : assert(AppointmentApiProvider != null);

  Future<List<Appointment>> fetchAppointments() async {
    return await appointmentApiProvider.fetchAppointments();
  }
}