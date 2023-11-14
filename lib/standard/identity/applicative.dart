import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/standard/identity/identity.dart';

class Applicative extends specs.ApplicativeWithPureAndApply<IdentityK> {
  const Applicative();

  @override
  HKP<IdentityK, A> pure<A>(A a) => Identity.id(a);

  @override
  HKP<IdentityK, B> apply<A, B>(
          HKP<IdentityK, B Function(A)> mf, HKP<IdentityK, A> ma) =>
      mf.fold((f) => ma.fold((a) => pure(f(a))));
}
