import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_timer/components/buttons.dart';
import 'package:get/get.dart';

import '../controller/theme_controller.dart';
import '../controller/timer_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var themeController = Get.find<ThemeController>();
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    var timerController = Get.find<TimerController>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Timer App", style: textTheme.headline1),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GetBuilder<ThemeController>(
              init: ThemeController(),
              id: 1,
              initState: (_) {},
              builder: (_) {
                return IconButton(
                    onPressed: () {
                      themeController.changeThemeOfButtons();
                      themeController.isDarkMode
                          ? Get.changeThemeMode(ThemeMode.dark)
                          : Get.changeThemeMode(ThemeMode.light);
                    },
                    icon: Icon(
                      themeController.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: iconTheme.color,
                      size: iconTheme.size,
                    ));
              },
            )
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          width: Get.width,
          height: Get.height,
          child: GetBuilder<TimerController>(
              init: TimerController(),
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Center Circle
                    GetBuilder<ThemeController>(
                        id: 1,
                        builder: (context) {
                          return Container(
                            decoration: BoxDecoration(
                              color: themeController.isDarkMode
                                  ? const Color.fromARGB(255, 21, 21, 21)
                                  : Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10.0,
                                    offset: const Offset(5, 5),
                                    color: themeController.isDarkMode
                                        ? Colors.black
                                        : const Color.fromARGB(
                                            109, 144, 144, 144)),
                                BoxShadow(
                                    blurRadius: 10.0,
                                    offset: const Offset(-5, -5),
                                    color: themeController.isDarkMode
                                        ? const Color.fromARGB(255, 27, 27, 27)
                                        : const Color.fromARGB(
                                            255, 243, 243, 243))
                              ],
                            ),
                            width: 300,
                            height: 300,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 12,
                                    valueColor: AlwaysStoppedAnimation(
                                        timerController.seconds == 60
                                            ? Color.fromARGB(255, 88, 154, 199)
                                            : Colors.red),
                                    backgroundColor: themeController.isDarkMode
                                        ? const Color.fromARGB(255, 34, 34, 34)
                                        : const Color.fromARGB(
                                            255, 237, 237, 237),
                                    value: timerController.seconds /
                                        TimerController.maxSeconds,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    timerController.seconds.toString(),
                                    style: TextStyle(
                                      fontSize: 100,
                                      fontWeight: FontWeight.bold,
                                      color: timerController.isCompleted()
                                          ? Color.fromARGB(255, 88, 154, 199)
                                          : const Color.fromARGB(
                                              255, 178, 14, 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 50,
                    ),

                    /// Buttons
                    timerController.isTimerRuning() ||
                            !timerController.isCompleted()
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ButtonWidget(
                                  onTap: () {
                                    timerController.isTimerRuning()
                                        ? timerController.stopTimer(rest: false)
                                        : timerController.startTimer(
                                            rest: false);
                                  },
                                  text: timerController.isTimerRuning()
                                      ? "Pause"
                                      : "Resume",
                                  color: timerController.isTimerRuning()
                                      ? Colors.red
                                      : const Color.fromARGB(255, 88, 154, 199),
                                  fontWeight: FontWeight.w400),
                              ButtonWidget(
                                  onTap: () {
                                    timerController.stopTimer(rest: true);
                                  },
                                  text: "Cancel",
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600)
                            ],
                          )
                        : GetBuilder<ThemeController>(
                            init: ThemeController(),
                            id: 1,
                            initState: (_) {},
                            builder: (_) {
                              return ButtonWidget(
                                onTap: () {
                                  timerController.startTimer();
                                },
                                text: "Start",
                                color: themeController.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w400,
                              );
                            },
                          ),
                  ],
                );
              }),
        ));
  }
}
