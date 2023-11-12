import 'package:feng/core/types.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/maybe/applicative.dart';
import 'package:feng/standard/maybe/maybe.dart';

class Monad extends specs.Monad<Maybe> {
  final Applicative applicative = Applicative();

  @override
  HKP<Maybe, A> returns<A>(A a) => applicative.pure(a);

  @override
  HKP<Maybe, B> bind<A, B>(HKP<Maybe, A> ma, Fun<A, HKP<Maybe, B>> f) =>
      ma.fold(f, Maybe.none);

  // Delegation

  @override
  HKP<Maybe, B> apply<A, B>(HKP<Maybe, B Function(A)> mf, HKP<Maybe, A> ma) =>
      applicative.apply(mf, ma);

  @override
  HKP<Maybe, B> map<A, B>(Fun<A, B> f, HKP<Maybe, A> ma) =>
      applicative.map(f, ma);

  @override
  HKP<Maybe, A> pure<A>(A a) => applicative.pure(a);
}
