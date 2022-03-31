import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:freecodecamp/models/learn/challenge_model.dart';
import 'package:freecodecamp/ui/views/learn/challenge_editor/test_runner/test_model.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestViewModel extends StatelessWidget {
  const TestViewModel({Key? key, required this.tests, required this.code})
      : super(key: key);

  final List<ChallengeTest> tests;
  final String code;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestModel>.reactive(
        viewModelBuilder: () => TestModel(),
        builder: (context, model, child) => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white)),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            model.retrieveTestResults();
                          },
                          child: const Text('Run tests')),
                    ))
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 1,
                      width: 1,
                      child: WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController controller) {
                          model.setWebviewController = controller;
                          model.setWebViewContent(code, tests);
                        },
                        javascriptChannels: {
                          JavascriptChannel(
                            name: 'Flutter',
                            onMessageReceived: (JavascriptMessage message) {
                              String pageBody = message.message;
                              model.setTestDocument = message.message;
                            },
                          )
                        },
                        onPageFinished: (String url) {
                          model.controller.runJavascript(
                              '(function(){Flutter.postMessage(window.document.body.outerHTML)})();');
                        },
                      ),
                    ),
                  ],
                ),
                testTile(tests, model)
              ],
            ));
  }

  Widget testTile(List<ChallengeTest> tests, TestModel model) {
    return FutureBuilder(
      initialData: tests,
      future: model.pressedTestButton ? model.retrieveTestResults() : null,
      builder: (context, snapshot) {
        return ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: tests.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Html(
                  data: tests[index].instruction,
                  style: {'body': Style(fontSize: FontSize.large)},
                ),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(0x42, 0x42, 0x55, 1),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        model.getCorrectTestIcon(tests[index].testState),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                minVerticalPadding: 16,
                tileColor: index % 2 == 0
                    ? const Color(0xFF0a0a23)
                    : const Color.fromRGBO(0x2A, 0x2A, 0x40, 1),
              );
            });
      },
    );
  }
}
