import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/error/something_went_wrong.dart';
import 'package:thitsarparami/models/models.dart';

class AppointmentScreen extends StatefulWidget {
  static const routeName = '/appointment';
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late final ValueNotifier<List<Appointment>> _selectedAppointments;
  static Map<DateTime, List<Appointment>> kEventSource = {};
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedAppointments = ValueNotifier(_getEventsForDay(_selectedDay!));
    _loadAppointments();
  }

  @override
  void dispose() {
    _selectedAppointments.dispose();
    super.dispose();
  }

  _loadAppointments() async {
    BlocProvider.of<AppointmentBloc>(context).add(const GetAppointmentsEvent());
  }

  _getEventSource(List<Appointment> apppintments) {
    for (var apppintment in apppintments) {
      kEventSource[DateTime(
        apppintment.startDate.year,
        apppintment.startDate.month,
        apppintment.startDate.day,
      )] = kEventSource[DateTime(
                apppintment.startDate.year,
                apppintment.startDate.month,
                apppintment.startDate.day,
              )] !=
              null
          ? [
              ...?kEventSource[DateTime(
                apppintment.startDate.year,
                apppintment.startDate.month,
                apppintment.startDate.day,
              )],
              apppintment
            ]
          : [apppintment];
    }
  }

  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  final kEvents = LinkedHashMap<DateTime, List<Appointment>>(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll(kEventSource);

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedAppointments.value = _getEventsForDay(selectedDay);
    }
  }

  List<Appointment> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'ဆွမ်းစားပင့်လျောက်ရန် (စင်ကာပူသီးသန့်)',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const RootScreen()),
            // );
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryIconTheme.color!,
          ),
        ),
      ),
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          if (state is AppointmentError) {
            return const SomethingWentWrongScreen();
          } else if (state is AppointmentLoaded) {
            _getEventSource(state.appointments);
            return Column(
              children: [
                TableCalendar(
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: _getEventsForDay,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  calendarFormat: CalendarFormat.week,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: _onDaySelected,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ValueListenableBuilder<List<Appointment>>(
                      valueListenable: _selectedAppointments,
                      builder: (context, value, _) {
                        return ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            // ignore: avoid_unnecessary_containers
                            return Container(
                              child: Text(value[index].donarName!),
                            );
                          },
                        );
                      }),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
