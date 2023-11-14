import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/standard/maybe/maybe.dart';

class Applicative extends specs.ApplicativeWithPureAndApply<MaybeK> {
  const Applicative();

  @override
  HKP<MaybeK, A> pure<A>(A a) => Api.some(a);

  @override
  HKP<MaybeK, B> apply<A, B>(
          HKP<MaybeK, B Function(A)> mf, HKP<MaybeK, A> ma) =>
      mf.fold((f) => ma.fold((a) => Api.some(f(a)), Api.none), Api.none);
}
