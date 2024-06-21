import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SundayaOne',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFE11F26),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 30,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      runSpacing: 30,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'images/sundayalogo.svg',
                        ),
                        const Padding(padding: EdgeInsets.only(left: 30)),
                        SvgPicture.asset(
                          'images/textsundaya.svg',
                          color: Colors.white,
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    Wrap(
                      spacing: 30,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      runSpacing: 30,
                      children: [
                        InkWell(
                          onTap: () {
                            goToURL(
                                'https://play.google.com/store/apps/details?id=com.sundaya.sundayaapps');
                          },
                          child: IntrinsicWidth(
                            child: SvgPicture.asset(
                              'images/googleplay.svg',
                              width: 250,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            goToURL(
                                'https://apps.apple.com/us/app/sundaya-app/id6472682861');
                          },
                          child: SvgPicture.asset(
                            'images/appstore.svg',
                            width: 250,
                          ),
                        ),
                        IntrinsicWidth(
                          child: ElevatedButton(
                            onPressed: () {
                              goToURL(
                                  'https://apps.sundaya.com/downloader/SundayaOne.zip');
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.desktop_windows_outlined),
                                  Padding(padding: EdgeInsets.only(left: 20)),
                                  Text(
                                    "Download for Windows (Beta)",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // IntrinsicWidth(
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       goToURL(
                        //           'https://apps.apple.com/us/app/sundaya-desktop/id6476724740');
                        //     },
                        //     child: const Padding(
                        //       padding: EdgeInsets.all(8.0),
                        //       child: Row(
                        //         children: [
                        //           Icon(Icons.apple_rounded),
                        //           Padding(padding: EdgeInsets.only(left: 20)),
                        //           Expanded(
                        //             child: Text(
                        //               "Download for Mac OS (Beta)",
                        //               style: TextStyle(fontSize: 20),
                        //               overflow: TextOverflow.ellipsis,
                        //               textWidthBasis:
                        //                   TextWidthBasis.longestLine,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> goToURL(String url) async {
    if (!await launchUrl(
      mode: LaunchMode.platformDefault,
      Uri.parse(url),
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
