import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imgUrl = 'assets/4.jpg';
  double initX = 0.0, initY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<GyroscopeEvent>(
              stream: SensorsPlatform.instance.gyroscopeEvents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.y.abs() > 0.0)
                    initX = initX + (snapshot.data!.y);
                  if (snapshot.data!.x.abs() > 0.0)
                    initY = initY + (snapshot.data!.x);
                }
                return Positioned(
                  left: 10 - initX,
                  right: 10 + initX,
                  top: 10 - initY,
                  bottom: 10 + initY,
                  child: Center(
                    child: Container(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              width: 230,
                              height: 330,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    isAntiAlias: true,
                                    opacity: 0.8,
                                    image: AssetImage(imgUrl),
                                    colorFilter: new ColorFilter.mode(
                                        Colors.white.withOpacity(.1),
                                        BlendMode.srcOver),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                child: Container(
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          Positioned(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
            child: Center(
              child: Container(
                width: 250,
                height: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: .1),
                  image: DecorationImage(
                      image: AssetImage(imgUrl), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
