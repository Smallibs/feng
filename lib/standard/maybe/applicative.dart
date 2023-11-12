import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/standard/maybe/functor.dart';
import 'package:feng/standard/maybe/maybe.dart';

class Applicative extends specs.ApplicativeWithMap<Maybe> {
  final Functor functor = Functor();

  @override
  HKP<Maybe, A> pure<A>(A a) => Maybe.some(a);

  @override
  HKP<Maybe, B> apply<A, B>(HKP<Maybe, B Function(A)> mf, HKP<Maybe, A> ma) =>
      mf.fold((f) => ma.fold((a) => Maybe.some(f(a)), Maybe.none), Maybe.none);
}
