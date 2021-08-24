class ServiceProviderOffer {
  final int? id;
  final String? image;
  final String? title;
  final String? desc;
  final String? priceB;
  final String? priceA;
  final double? rate;

  ServiceProviderOffer(
      {this.image,
      this.id,
      this.desc,
      this.priceA,
      this.priceB,
      this.title,
      this.rate});
}
