import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/standard/future/future.dart';

class Functor<E> implements specs.Functor<FutureK> {
  const Functor();

  @override
  HKP<FutureK, B> map<A, B>(Fun<A, B> f, HKP<FutureK, A> ma) =>
      FutureK.of(FutureK.fix(ma).then((value) async => f(value)));
}
