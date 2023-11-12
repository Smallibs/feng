import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/standard/maybe/functor.dart';
import 'package:feng/standard/maybe/maybe.dart';

class Applicative extends specs.ApplicativeWithMap<MaybeK> {
  final Functor functor = Functor();

  @override
  HKP<MaybeK, A> pure<A>(A a) => Maybe.some(a);

  @override
  HKP<MaybeK, B> apply<A, B>(
          HKP<MaybeK, B Function(A)> mf, HKP<MaybeK, A> ma) =>
      mf.fold((f) => ma.fold((a) => Maybe.some(f(a)), Maybe.none), Maybe.none);
}
