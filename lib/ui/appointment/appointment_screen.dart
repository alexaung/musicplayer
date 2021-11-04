import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thitsarparami/blocs/bloc.dart';
import 'package:thitsarparami/error/something_went_wrong.dart';
import 'package:thitsarparami/helper/enum.dart';
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/ui/appointment/components/appointment_tile.dart';

class AppointmentScreen extends StatefulWidget {
  static const routeName = '/appointment';
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  ValueNotifier<List<Appointment>>? _selectedAppointments;
  static Map<DateTime, List<Appointment>> kEventSource = {};
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
    _selectedDay = _focusedDay;
    _selectedAppointments = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedAppointments!.dispose();
    super.dispose();
  }

  _loadAppointments() async {
    BlocProvider.of<AppointmentBloc>(context).add(const GetAppointmentsEvent());
  }

  _getEventSource(List<Appointment> apppintments) {
    kEventSource.clear();
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

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(
        () {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          _selectedAppointments!.value = _getEventsForDay(selectedDay);
        },
      );
    }
  }

  List<Appointment> _getEventsForDay(DateTime day) {
    // Implementation example
    var result = kEventSource[DateTime(
          day.year,
          day.month,
          day.day,
        )] ??
        [];
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    //final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Theme.of(context).backgroundColor,
      //   elevation: 0,
      //   title: Text(
      //     'ဆွမ်းစားပင့်လျောက်ရန် (စင်ကာပူသီးသန့်)',
      //     style: Theme.of(context).appBarTheme.titleTextStyle,
      //   ),
      //   leading: IconButton(
      //     onPressed: () {
      //       // Navigator.push(
      //       //   context,
      //       //   MaterialPageRoute(builder: (context) => const RootScreen()),
      //       // );
      //       Navigator.pop(context);
      //     },
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: Theme.of(context).primaryIconTheme.color!,
      //     ),
      //   ),
      // ),
      body: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          if (state is AppointmentError) {
            return const SomethingWentWrongScreen();
          } else if (state is AppointmentLoaded) {
            _getEventSource(state.appointments);
            _selectedAppointments!.value = _getEventsForDay(_selectedDay!);
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: screenHeight / 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColorDark,
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColorLight,
                        ],
                        stops: const [
                          0.0,
                          0.5,
                          0.7,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  // height: screenHeight / 3,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(
                      'ဆွမ်းစားပင့်လျောက်ရန် (စင်ကာပူသီးသန့်)',
                      style: Theme.of(context).textTheme.headline2,
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
                        color: Theme.of(context).iconTheme.color!,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 70,
                    left: 0,
                    right: 0,
                    // height: screenHeight / 3,
                    child: _appointmentCalendar()),
                Positioned(
                  left: 0,
                  right: 0,
                  top: screenHeight * 0.3,
                  height: screenHeight * 0.50,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(40)),
                    child: Expanded(
                      child: ValueListenableBuilder<List<Appointment>>(
                        valueListenable: _selectedAppointments!,
                        builder: (context, value, _) {
                          return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              Appointment appointment = value[index];
                              // ignore: avoid_unnecessary_containers
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                child: SlideAnimation(
                                  child: FadeInAnimation(
                                    child: Row(
                                      children: [
                                        AppointmentTile(appointment)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
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

  Widget _appointmentCalendar() {
    return TableCalendar(
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      eventLoader: _getEventsForDay,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      calendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      onDaySelected: _onDaySelected,
      rowHeight: 70,
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        formatButtonDecoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20.0),
        ),
        formatButtonTextStyle: const TextStyle(color: Colors.white),
        formatButtonShowsNext: false,
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        weekendStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      calendarStyle: const CalendarStyle(
        defaultTextStyle: TextStyle(color: Colors.white),
        weekendTextStyle: TextStyle(color: Colors.red),
        outsideTextStyle: TextStyle(color: Colors.white),
        // todayDecoration: BoxDecoration(
        //   color: Theme.of(context).primaryColorLight,
        //   //borderRadius: BorderRadius.circular(10.0),
        //   shape: BoxShape.rectangle,
        // ),
        // selectedDecoration: BoxDecoration(
        //   color: Theme.of(context).primaryColorDark,
        //   //borderRadius: BorderRadius.circular(10.0),
        //   shape: BoxShape.rectangle,
        // ),
      ),
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, date, focusedDate) {
          return Container(
              margin: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                date.day.toString(),
                style: const TextStyle(color: Colors.white),
              ));
        },
        selectedBuilder: (context, date, focusedDate) {
          return Container(
              margin: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                date.day.toString(),
                style: const TextStyle(color: Colors.white),
              ));
        },
        singleMarkerBuilder: (context, date, Appointment appointment) {
          return Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appointment.type == AppointmentType.breakfast
                    ? Colors.yellow[900]
                    : Colors.cyan), //Change color
            width: 10.0,
            height: 10.0,
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
          );
        },
      ),
    );
  }
}
