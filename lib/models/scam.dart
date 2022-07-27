class Scam {
  final num overchargeRate;
  final bool doubleCharge;
  final bool wrongSlotItem;
  final bool wrongRandomItem;
  final bool scamStore;
  final bool scamStoreDuplicate;
  final bool delay;
  const Scam({
    this.overchargeRate = 0,
    this.doubleCharge = false,
    this.wrongSlotItem = false,
    this.wrongRandomItem = false,
    this.scamStore = false,
    this.scamStoreDuplicate = false,
    this.delay = false,
  });
}
