import '../../main.dart' as runner;
import '../flavors.dart';

Future<void> main() async {
  Flavor.appFlavor = FlavorType.production;
  await runner.main();
}
