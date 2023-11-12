# Feng

## Monad Example

```dart
final monad = Monad();
 
final ma = monad
      .infix(monad.returns((x) => x + 1))
      .apply(monad.pure(2))
      .map((i) => i.toString())
      .bind((i) => monad.returns("result is $i"));
```
