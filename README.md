# Feng

[feng (G. noun. arrow, war arrow)](https://www.elfdict.com/w/arrow%2C_war_arrow?include_old=1)

Feng is a library for [Dart](https://dart.dev) providing some functional programming constructions like:

- Functor,
- Applicative and
- Monad

Some incarnations are available like:

- Identity,
- Maybe,
- Try,
- Either, 
- Future,
- Reader

## Design approach

In Dart, we can specify Higher-Kinded Polymorphism (HKP for short) is denoted by the type `HKP` and it came from the 
[Lightweight higher-kinded polymorphism](https://www.cl.cam.ac.uk/~jdy22/papers/lightweight-higher-kinded-polymorphism.pdf) 
paper.

### 

## Monad Example

A program can be designed using a monad for instance.

```dart
HKP<M, String> example<M>(Monad<M> monad, HKP<M, int> ma) =>
    monad
        .returns((x) => x + 1)
        .using(monad)
        .apply(ma)
        .bind((i) => monad.returns((j) => i + j))
        .apply(monad.returns(4))
        .map((i) => i.toString())
        .end();
```

Then this program can be executed with a chosen effect has illustrated in the next code fragment.

```dart
import 'package:feng/standard/future/future.dart';

Future<void> main() async {
  final result = await Api.future(example(Api.monad, Api.success(2)));
  // ...
}
```

# License

MIT License

Copyright (c) 2023-2024 Didier Plaindoux

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:
