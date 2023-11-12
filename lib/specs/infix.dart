import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart';

extension InfixExtension<E extends Functor<M>, M> on E {
  (E, HKP<M, A>) infix<A>(HKP<M, A> ma) => (this, ma);
}

extension UsingExtension<M, A> on HKP<M, A> {
  (E, HKP<M, A>) using<E extends Functor<M>>(E e) => (e, this);
}
