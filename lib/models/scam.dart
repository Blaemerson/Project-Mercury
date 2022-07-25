class Scam {
  final num overchargeRate;
  final bool doubleCharge;
  final bool randomItem;
  final bool otherOptions;
  final bool delay;
  const Scam({
    this.overchargeRate = 0,
    this.doubleCharge = false,
    this.randomItem = false,
    this.otherOptions = false,
    this.delay = false,
  });
}
