

import 'package:evently/src/presentations/create_events/create_event_state.dart';
import 'package:evently/src/presentations/my_events/my_event_state.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> myStateList = [
   ChangeNotifierProvider(create: (_)=> CreateEventState()..init()),
   ChangeNotifierProvider(create: (_)=> MyEventState())
];