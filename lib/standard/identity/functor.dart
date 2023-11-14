import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/standard/identity/identity.dart';

class Functor implements specs.Functor<IdentityK> {
  const Functor();

  @override
  HKP<IdentityK, B> map<A, B>(Fun<A, B> f, HKP<IdentityK, A> ma) =>
      Api.id(ma.fold(f));
}
