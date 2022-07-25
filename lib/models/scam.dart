import 'package:projectmercury/models/store_item.dart';

class Scam {
  final num overchargeRate;
  final bool doubleCharge;
  final StoreItem? wrongItem;
  final bool fakeSeller;
  final bool delay;
  const Scam({
    this.overchargeRate = 0,
    this.doubleCharge = false,
    this.wrongItem,
    this.fakeSeller = false,
    this.delay = false,
  });
}
