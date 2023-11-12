import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart';
import 'package:feng/specs/functor.dart';

mixin Monad<M> on Applicative<M> {
  HKP<M, A> returns<A>(A a);

  HKP<M, B> bind<A, B>(HKP<M, A> ma, Fun<A, HKP<M, B>> f);
}

extension BindExtension<E extends Monad<M>, M, A> on (E, HKP<M, A>) {
  (E, HKP<M, B>) bind<B>(Fun<A, HKP<M, B>> f) => ($1, $1.bind($2, f));
}
