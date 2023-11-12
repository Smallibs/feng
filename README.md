# Feng

[feng (G. noun. arrow, war arrow)](https://www.elfdict.com/w/arrow%2C_war_arrow?include_old=1)

Feng is a library for [Dart](https://dart.dev) providing some functional programming constructions like:

- Functor,
- Applicative and
- Monad

Some incarnations are available like:

- Maybe,
- Either

## Design approach

TODO

## Monad Example

```dart
void main() {
  final monad = Monad();

  final ma = monad
      .returns((x) => x + 1)
      .using(monad)
      .apply(monad.returns(2))
      .bind((i) => monad.returns((j) => i + j))
      .apply(monad.returns(4))
      .map((i) => i.toString());

  // ...
}
```

# License

MIT License

Copyright (c) 2023 Didier Plaindoux

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:
