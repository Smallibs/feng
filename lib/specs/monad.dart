import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart';
import 'package:feng/specs/functor.dart';

abstract class Monad<M> extends Applicative<M> {
  HKP<M, A> returns<A>(A a);

  HKP<M, B> bind<A, B>(HKP<M, A> ma, Fun<A, HKP<M, B>> f);

  @override
  (Monad<M>, HKP<M, A>) infix<A>(HKP<M, A> ma) => (this, ma);
}

extension MonadExtension<M, A, B> on (Monad<M>, HKP<M, A>) {
  (Applicative<M>, HKP<M, B>) bind(Fun<A, HKP<M, B>> f) => ($1, $1.bind($2, f));
}
