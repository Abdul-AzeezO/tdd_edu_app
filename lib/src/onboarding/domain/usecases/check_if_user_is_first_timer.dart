import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool, void> {
  CheckIfUserIsFirstTimer(this._onboardingRepository);

  final OnboardingRepository _onboardingRepository;
  @override
  ResultFuture<bool> call() => _onboardingRepository.checkIfUserIsFirstTimer();
}
