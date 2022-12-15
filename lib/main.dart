
import 'package:chat_app/app.dart';
import 'package:chat_app/screens/screens.dart';
import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

void main(){
  final client = StreamChatClient(streamKey);
  runApp(MyApp(appTheme: AppTheme(),client: client));}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.appTheme,
    required this.client,
  }) : super(key: key);


  final AppTheme appTheme;
  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      title: 'Chatter',
      builder: (context, child){
        return StreamChatCore(
          client: client,
          child: child!);
      },
      home: HomeScreen(),
    );
  }
}
