import '../../../../../../uikit/assets/app_assets.dart';
import '../../../../../../uikit/strings/app_strings.dart';
import 'master.dart';

class MasterData {
  static const Master pavel = Master(
    id: '1',
    name: "Pavel",
    position: AppStrings.topMaster,
    description: "(8 лет опыта • Мастер международного класса.)",
    imagePath: AppAssets.pavelImg,
  );

  static const List<Master> allMasters = [pavel];
}
