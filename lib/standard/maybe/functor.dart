import 'package:feng/core/fun.dart';
import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart' as specs;

import 'maybe.dart';

class Functor implements specs.Functor<MaybeK> {
  const Functor();

  @override
  HKP<MaybeK, B> map<A, B>(Fun<A, B> f, HKP<MaybeK, A> ma) =>
      ma.fold(f.then(Maybe.some), Maybe.none);
}
