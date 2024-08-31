import '../../main.dart' as runner;
import '../flavors.dart';

Future<void> main() async {
  Flavor.appFlavor = FlavorType.prod;
  await runner.main();
}
