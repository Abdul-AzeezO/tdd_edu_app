// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:education_app/core/services/dependency_injection/app_module.dart'
    as _i10;
import 'package:education_app/src/onboarding/data/datasources/onboarding_local_data_source.dart'
    as _i4;
import 'package:education_app/src/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i6;
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart'
    as _i5;
import 'package:education_app/src/onboarding/domain/usecases/cache_first_timer.dart'
    as _i7;
import 'package:education_app/src/onboarding/domain/usecases/check_if_user_is_first_timer.dart'
    as _i8;
import 'package:education_app/src/onboarding/view/cubit/onboarding_cubit.dart'
    as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i4.OnboardingLocalDataSource>(
        () => _i4.OnboardingLocalDataSourceImpl(gh<_i3.SharedPreferences>()));
    gh.lazySingleton<_i5.OnboardingRepository>(() =>
        _i6.OnboardingRepositoryImpl(gh<_i4.OnboardingLocalDataSource>()));
    gh.lazySingleton<_i7.CacheFirstTimer>(
        () => _i7.CacheFirstTimer(gh<_i5.OnboardingRepository>()));
    gh.lazySingleton<_i8.CheckIfUserIsFirstTimer>(
        () => _i8.CheckIfUserIsFirstTimer(gh<_i5.OnboardingRepository>()));
    gh.factory<_i9.OnboardingCubit>(() => _i9.OnboardingCubit(
          cacheFirstTimer: gh<_i7.CacheFirstTimer>(),
          checkIfUserIsFirstTimer: gh<_i8.CheckIfUserIsFirstTimer>(),
        ));
    return this;
  }
}

class _$AppModule extends _i10.AppModule {}
