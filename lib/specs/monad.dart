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
  const MonadWithPureAndApply();

  @override
  HKP<M, A> returns<A>(A a) => pure(a);

  @override
  HKP<M, A> join<A>(HKP<M, HKP<M, A>> mma) => bind(mma, id);
}

extension BindExtension<E extends Monad<M>, M, A> on (E, HKP<M, A>) {
  (E, HKP<M, B>) bind<B>(Fun<A, HKP<M, B>> f) => ($1, $1.bind($2, f));
}
