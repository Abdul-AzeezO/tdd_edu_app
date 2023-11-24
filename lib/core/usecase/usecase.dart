import 'package:education_app/core/utils/typedefs.dart';

abstract class UsecaseWithoutParams<Type, Param> {
  const UsecaseWithoutParams();
  ResultFuture<Type> call();
}

abstract class UsecaseWithParams<Type, Param> {
  const UsecaseWithParams();
  ResultFuture<Type> call(Param params);
}
