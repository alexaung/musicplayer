import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/repositories/repositories.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRespository appointmentRespository;
  late List<Appointment> appointments;
  AppointmentBloc({required this.appointmentRespository})
      : super(AppointmentInitial()) {
    on<GetAppointmentsEvent>((event, emit) async {
      await _getAppointments(emit);
    });
  }

  Future<void> _getAppointments(Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    try {
      final List<Appointment> appointments =
          await appointmentRespository.fetchAppointments();
      emit(AppointmentLoaded(appointments: appointments));
    } catch (e) {
      emit(AppointmentError(error: (e.toString())));
    }
  }
}
