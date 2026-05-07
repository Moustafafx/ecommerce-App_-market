

import 'package:flutter_application_1/features/brands/data/brand_model.dart';

abstract class BrandState {}

class Brandinitial extends BrandState {}

class Brandloading extends BrandState {}

class Brandsuccess extends BrandState {
  final List<BrandModel> brands;

  Brandsuccess(this.brands);
}

class Brandfailer extends BrandState {
  final String errormessag;

  Brandfailer(this.errormessag);
}