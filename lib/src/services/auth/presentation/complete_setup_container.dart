import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:schedulenus/src/services/auth/data/auth_repository.dart';

class CompleteSetupContainer extends ConsumerStatefulWidget {
  const CompleteSetupContainer({super.key});

  @override
  ConsumerState<CompleteSetupContainer> createState() =>
      _CompleteSetupContainerState();
}

class _CompleteSetupContainerState
    extends ConsumerState<CompleteSetupContainer> {
  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = ref.watch(authRepositoryProvider);

    // If the user has not verified his email, he has only completed 50% of his
    // verification process.
    if (!authRepository.currentUser!.emailVerified) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromRGBO(255, 197, 197, 0.6),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Text(
                "You have almost completed your signup! Click here to verify your email",
                overflow: TextOverflow.clip,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              LinearPercentIndicator(
                progressColor: const Color.fromRGBO(112, 113, 232, 1),
                percent: 0.5,
                barRadius: const Radius.circular(8),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
