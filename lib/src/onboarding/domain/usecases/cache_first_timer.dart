import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CacheFirstTimer extends UsecaseWithoutParams<void, void> {
  const CacheFirstTimer(this._onboardingRepository);
  final OnboardingRepository _onboardingRepository;

  @override
  ResultFuture<void> call() => _onboardingRepository.cacheFirstTimer();
}
