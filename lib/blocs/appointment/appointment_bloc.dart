import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRespository appointmentRespository;
  late List<Appointment> appointments;
  AppointmentBloc({required this.appointmentRespository}) : super(AppointmentInitial());

  @override
  Stream<AppointmentState> mapEventToState(AppointmentEvent event) async* {
    if (event is GetAppointmentsEvent) {
      yield AppointmentLoading();
      try {
        final List<Appointment> appointments = await appointmentRespository.fetchAppointments();
        yield AppointmentLoaded(appointments: appointments);
      } catch (e) {
        yield AppointmentError(error: (e.toString()));
      }
    }
  }
}
