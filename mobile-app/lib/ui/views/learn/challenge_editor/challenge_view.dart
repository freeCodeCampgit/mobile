import 'package:flutter/material.dart';
import 'package:flutter_code_editor/controller/editor_view_controller.dart';
import 'package:flutter_code_editor/models/editor_options.dart';
import 'package:flutter_code_editor/models/file_model.dart';
import 'package:freecodecamp/models/learn/challenge_model.dart';
import 'package:freecodecamp/ui/views/learn/challenge_editor/challenge_model.dart';
import 'package:freecodecamp/ui/views/learn/challenge_editor/description/description_view.dart';
import 'package:stacked/stacked.dart';
import 'dart:developer' as dev;

class ChallengeView extends StatelessWidget {
  const ChallengeView({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChallengeModel>.reactive(
        viewModelBuilder: () => ChallengeModel(),
        builder: (context, model, child) => Scaffold(
                body: FutureBuilder(
              future: model.initChallenge(url),
              builder: (context, snapshot) {
                Challenge? challenge = snapshot.data as Challenge?;

                dev.log(url);

                if (snapshot.hasData) {
                  EditorViewController controller = EditorViewController(
                    options:
                        EditorOptions(useFileExplorer: false, importScripts: [
                      '<script src="https://unpkg.com/chai/chai.js"></script>',
                      '<script src="https://unpkg.com/mocha/mocha.js"></script>',
                      '<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>'
                    ], bodyScripts: [
                      '<div id="mocha"></div>',
                      '''
                          <script class="mocha-init">
                            mocha.setup("bdd");
                            mocha.growl();
                            mocha.checkLeaks();
                          </script>
                      ''',
                      '''
                          <script class="mocha-exec">
                            const assert = chai.assert;

                            it('should equal', () => {
                              ${model.challengeTestToJs(challenge!.tests)}
                            })
                            mocha.run();
                          </script>
                     '''
                    ], customViewNames: [
                      const Text('description'),
                    ], customViews: [
                      DescriptionView(
                        description: challenge.description,
                        instructions: challenge.instructions,
                        tests: challenge.tests,
                      )
                    ]),
                    file: FileIDE(
                        fileExplorer: null,
                        fileName: challenge.files[0].fileName,
                        filePath: '',
                        fileContent: challenge.files[0].fileContents,
                        parentDirectory: ''),
                  );

                  controller.consoleStream.stream.listen((event) {
                    dev.log(event);
                    dev.log('from listener :)');
                  });

                  return controller;
                }

                return const Center(child: CircularProgressIndicator());
              },
            )));
  }
}
