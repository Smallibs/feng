import 'package:feng/core/types.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/either/either.dart';
import 'package:feng/standard/either/applicative.dart';

class Monad<E> extends specs.MonadWithPureAndApply<EitherK<E>> {
  final Applicative<E> applicative = Applicative();

  @override
  HKP<EitherK<E>, B> bind<A, B>(
          HKP<EitherK<E>, A> ma, Fun<A, HKP<EitherK<E>, B>> f) =>
      ma.fold(Either.left, f);

  // Delegation for pure and apply

  @override
  HKP<EitherK<E>, A> pure<A>(A a) => applicative.pure(a);

  @override
  HKP<EitherK<E>, B> apply<A, B>(
          HKP<EitherK<E>, Fun<A, B>> mf, HKP<EitherK<E>, A> ma) =>
      applicative.apply(mf, ma);
}
