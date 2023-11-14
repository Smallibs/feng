import 'package:feng/core/types.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/either/either.dart';
import 'package:feng/standard/either/applicative.dart';

class Monad<E> extends specs.MonadWithPureAndApply<EitherK<E>> {
  Monad() : super(Api.applicative());

  @override
  HKP<EitherK<E>, B> bind<A, B>(
          HKP<EitherK<E>, A> ma, Fun<A, HKP<EitherK<E>, B>> f) =>
      ma.fold(Api.left, f);
}
