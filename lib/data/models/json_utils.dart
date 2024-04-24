String? $fromJsonToNullableString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

String $fromJsonToString(dynamic value) {
  if (value == null) return '';
  return value.toString();
}

int? $fromJsonToNullableInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  return int.tryParse(value.toString());
}

int $fromJsonToInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}

double? $fromJsonToNullableDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}

double $fromJsonToDouble(dynamic value) {
  if (value == null) return 0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0;
}

bool $fromJsonToBoolean(dynamic value) {
  if (value is bool) return value;
  return bool.tryParse(value) ?? false;
}

Map<String, String> $fromJsonToMap(dynamic value) {
  if (value == null) return {};
  if (value is List) {
    return {for (final v in value) v['k'].toString(): v['v'].toString()};
  }
  return {};
}

Function? $toNull(_) => null;
