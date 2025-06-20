import 'package:flutter/rendering.dart';

/**
 * Transfer units. 
 * include : match unit type ,contain source unit and target unit.
 * support : accroding to source value and source unit , transfer to target unit.
 */

class Transfer {
  UnitType unitType;
  int sourceUnit;
  int targetUnit;

  Transfer({
    required this.unitType,
    required this.sourceUnit,
    required this.targetUnit,
  });

  void setUnitType(UnitType unitType) {
    this.unitType = unitType;
    sourceUnit = 1;
    targetUnit = 2;
  }

  void setSourceUnit(int sourceUnit) {
    this.sourceUnit = sourceUnit;
  }

  void setTargetUnit(int targetUnit) {
    this.targetUnit = targetUnit;
  }

  double transfer(double sourceValue, {String? newTargetUnit}) {
    debugPrint('targetUnit: $targetUnit');
    debugPrint('sourceUnit: $sourceUnit');

    int _targetUnit = targetUnit;

    double targetValue = 0;

    switch (unitType) {
      case UnitType.distance:
        if (newTargetUnit != null) {
          _targetUnit = DistanceUnit.values.indexOf(
            DistanceUnit.values.firstWhere(
              (element) => element.name == newTargetUnit,
            ),
          );
        }
        targetValue =
            sourceValue *
            distanceUnitMap[DistanceUnit.values[_targetUnit]]! /
            distanceUnitMap[DistanceUnit.values[sourceUnit]]!;
        break;
      case UnitType.weight:
        if (newTargetUnit != null) {
          _targetUnit = WeightUnit.values.indexOf(
            WeightUnit.values.firstWhere(
              (element) => element.name == newTargetUnit,
            ),
          );
        }
        targetValue =
            sourceValue *
            weightUnitMap[WeightUnit.values[_targetUnit]]! /
            weightUnitMap[WeightUnit.values[sourceUnit]]!;
        break;
      case UnitType.temperature:
        if (newTargetUnit != null) {
          _targetUnit = TemperatureUnit.values.indexOf(
            TemperatureUnit.values.firstWhere(
              (element) => element.name == newTargetUnit,
            ),
          );
        }
        targetValue =
            sourceValue *
            temperatureUnitMap[TemperatureUnit.values[_targetUnit]]! /
            temperatureUnitMap[TemperatureUnit.values[sourceUnit]]!;
        break;
    }
    return targetValue;
  }
}

enum UnitType { distance, weight, temperature }

enum DistanceUnit { km, meter, centimeter, millimeter, mile, yard, feet }

enum WeightUnit { kg, gram, milligram, pound, ounce, ton }

enum TemperatureUnit { celsius, fahrenheit, kelvin }

Map<DistanceUnit, double> distanceUnitMap = {
  DistanceUnit.km: 1,
  DistanceUnit.meter: 1000,
  DistanceUnit.centimeter: 100000,
  DistanceUnit.millimeter: 1000000,
  DistanceUnit.mile: 0.621371,
  DistanceUnit.yard: 1093.61,
  DistanceUnit.feet: 3280.84,
};

Map<WeightUnit, double> weightUnitMap = {
  WeightUnit.kg: 1,
  WeightUnit.gram: 1000,
  WeightUnit.milligram: 1000000,
  WeightUnit.pound: 2.20462,
  WeightUnit.ounce: 35.274,
  WeightUnit.ton: 0.00110231,
};

Map<TemperatureUnit, double> temperatureUnitMap = {
  TemperatureUnit.celsius: 1,
  TemperatureUnit.fahrenheit: 1.8,
  TemperatureUnit.kelvin: 1.8 + 32,
};
