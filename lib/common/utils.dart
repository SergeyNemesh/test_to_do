import 'dart:math';

Future<bool> getErrorWithDelay() async {
  await getDelay();

  Random random = Random();
  bool result = random.nextDouble() <= 0.3;
  return result;
}

Future<void> getDelay() async {
  Random random = Random();
  int randomDelay = random.nextInt(1500) + 500;
  await Future.delayed(Duration(milliseconds: randomDelay));
}
