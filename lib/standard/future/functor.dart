import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/standard/future/future.dart';

class Functor<E> implements specs.Functor<FutureK> {
  const Functor();

  // This solution do not use `.then(...)` since it's not safe in Dart!
  @override
  HKP<FutureK, B> map<A, B>(Fun<A, B> f, HKP<FutureK, A> ma) =>
      FutureK.of(_map(f, ma.fix()));

  Future<B> _map<A, B>(Fun<A, B> f, Future<A> ma) async {
    final a = await ma;
    final b = f(a);
    return b;
  }
}
