import 'package:flutter/material.dart';
import 'package:freecodecamp/models/learn/curriculum_model.dart';
import 'package:freecodecamp/ui/views/learn/learn-builders/challenge-builder/challenge_builder_model.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class ChallengeBuilderView extends StatelessWidget {
  final Block block;

  const ChallengeBuilderView({
    Key? key,
    required this.block,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChallengeBuilderModel>.reactive(
        viewModelBuilder: () => ChallengeBuilderModel(),
        builder: (context, model, child) => Container(
              color: const Color(0xFF0a0a23),
              child: Stepper(
                  onStepTapped: (value) => {model.setCurrentStep = value},
                  controlsBuilder: (context, details) =>
                      Row(children: const []),
                  currentStep: model.currentStep,
                  physics: const ClampingScrollPhysics(),
                  steps: [
                    for (int i = 0; i < block.challenges.length; i++)
                      Step(
                          title: Text(
                            block.challenges[i].name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          content: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(0x2A, 0x2A, 0x40, 1)),
                            onPressed: () {
                              String challenge = block.challenges[i].name
                                  .toLowerCase()
                                  .replaceAll(' ', '-');
                              String url = 'https://freecodecamp.dev/learn';

                              launch(
                                  '$url/${block.superBlock}/${block.dashedName}/$challenge');
                            },
                            child: const Text('GO TO CHALLENGE'),
                          ))
                  ]),
            ));
  }
}
