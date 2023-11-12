import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as applicative;
import 'package:feng/specs/functor.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/maybe/applicative.dart';
import 'package:feng/standard/maybe/maybe.dart';

class Monad implements specs.Monad<MaybeK> {
  final Applicative applicative = Applicative();

  @override
  HKP<MaybeK, A> returns<A>(A a) => applicative.pure(a);

  @override
  HKP<MaybeK, B> bind<A, B>(HKP<MaybeK, A> ma, Fun<A, HKP<MaybeK, B>> f) =>
      ma.fold(f, Maybe.none);

  // Delegation

  @override
  HKP<MaybeK, B> apply<A, B>(
          HKP<MaybeK, B Function(A)> mf, HKP<MaybeK, A> ma) =>
      applicative.apply(mf, ma);

  @override
  HKP<MaybeK, B> map<A, B>(Fun<A, B> f, HKP<MaybeK, A> ma) =>
      applicative.map(f, ma);

  @override
  HKP<MaybeK, A> pure<A>(A a) => applicative.pure(a);
}
