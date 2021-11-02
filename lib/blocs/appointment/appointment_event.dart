part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();
}

class GetAppointmentsEvent extends AppointmentEvent {
  const GetAppointmentsEvent();
  @override
  List<Object> get props => [];
}
