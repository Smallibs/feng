import 'package:feng/core/fun.dart';
import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart';

mixin Monad<M> on Applicative<M> {
  HKP<M, A> returns<A>(A a);

  HKP<M, A> join<A>(HKP<M, HKP<M, A>> mma);

  HKP<M, B> bind<A, B>(HKP<M, A> ma, Fun<A, HKP<M, B>> f);
}

abstract class MonadWithPureAndApply<M> extends ApplicativeWithPureAndApply<M>
    implements Monad<M> {
  final Applicative<M> applicative;

  const MonadWithPureAndApply(this.applicative);

  @override
  HKP<M, A> returns<A>(A a) => pure(a);

  @override
  HKP<M, A> join<A>(HKP<M, HKP<M, A>> mma) => bind(mma, id);

  // Delegation to Applicative

  @override
  HKP<M, A> pure<A>(A a) => applicative.pure(a);

  @override
  HKP<M, B> apply<A, B>(HKP<M, Fun<A, B>> mf, HKP<M, A> ma) =>
      applicative.apply(mf, ma);
}

extension MonadBind<E extends Monad<M>, M, A> on (E, HKP<M, A>) {
  (E, HKP<M, B>) bind<B>(Fun<A, HKP<M, B>> f) => ($1, $1.bind($2, f));
}
