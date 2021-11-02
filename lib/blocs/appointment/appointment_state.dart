part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentEmpty extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final List<Appointment> appointments;
  const AppointmentLoaded({required this.appointments});
}

class AppointmentError extends AppointmentState {
  final String error;
  const AppointmentError({required this.error});
}
