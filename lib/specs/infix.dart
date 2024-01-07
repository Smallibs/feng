import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart';

// This is a first attempt to have a dedicated DSL

extension UsingExtension<M, A> on HKP<M, A> {
  (E, HKP<M, A>) using<E extends Functor<M>>(E e) => (e, this);
}

extension EndExtension<E extends Functor<M>, M, A> on (E, HKP<M, A>) {
  HKP<M, A> end() => $2;
}
