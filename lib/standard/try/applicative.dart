import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/standard/try/try.dart';

class Applicative extends specs.ApplicativeWithPureAndApply<TryK> {
  const Applicative();

  @override
  HKP<TryK, A> pure<A>(A a) => Try.success(a);

  @override
  HKP<TryK, B> apply<A, B>(HKP<TryK, B Function(A)> mf, HKP<TryK, A> ma) => mf
      .fold((f) => ma.fold((a) => Try.success(f(a)), Try.failure), Try.failure);
}
