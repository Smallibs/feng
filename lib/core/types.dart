import '../specs/functor.dart';

typedef Fun<A, B> = B Function(A);
typedef Fun2<A, B, C> = C Function(A, B);
typedef Supplier<B> = B Function();

abstract class HKP<M, A> {}
