// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guardian_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GuardianNotification {

 String get id; String get guardianId; String get guardeeId; GuardianNotificationRiskType get riskType; GuardianNotificationTrigger get trigger; String? get responseEventId; DateTime get sentAt; GuardianNotificationGuardee get guardee;
/// Create a copy of GuardianNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuardianNotificationCopyWith<GuardianNotification> get copyWith => _$GuardianNotificationCopyWithImpl<GuardianNotification>(this as GuardianNotification, _$identity);

  /// Serializes this GuardianNotification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuardianNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.guardianId, guardianId) || other.guardianId == guardianId)&&(identical(other.guardeeId, guardeeId) || other.guardeeId == guardeeId)&&(identical(other.riskType, riskType) || other.riskType == riskType)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.responseEventId, responseEventId) || other.responseEventId == responseEventId)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.guardee, guardee) || other.guardee == guardee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,guardianId,guardeeId,riskType,trigger,responseEventId,sentAt,guardee);

@override
String toString() {
  return 'GuardianNotification(id: $id, guardianId: $guardianId, guardeeId: $guardeeId, riskType: $riskType, trigger: $trigger, responseEventId: $responseEventId, sentAt: $sentAt, guardee: $guardee)';
}


}

/// @nodoc
abstract mixin class $GuardianNotificationCopyWith<$Res>  {
  factory $GuardianNotificationCopyWith(GuardianNotification value, $Res Function(GuardianNotification) _then) = _$GuardianNotificationCopyWithImpl;
@useResult
$Res call({
 String id, String guardianId, String guardeeId, GuardianNotificationRiskType riskType, GuardianNotificationTrigger trigger, String? responseEventId, DateTime sentAt, GuardianNotificationGuardee guardee
});


$GuardianNotificationGuardeeCopyWith<$Res> get guardee;

}
/// @nodoc
class _$GuardianNotificationCopyWithImpl<$Res>
    implements $GuardianNotificationCopyWith<$Res> {
  _$GuardianNotificationCopyWithImpl(this._self, this._then);

  final GuardianNotification _self;
  final $Res Function(GuardianNotification) _then;

/// Create a copy of GuardianNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? guardianId = null,Object? guardeeId = null,Object? riskType = null,Object? trigger = null,Object? responseEventId = freezed,Object? sentAt = null,Object? guardee = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,guardianId: null == guardianId ? _self.guardianId : guardianId // ignore: cast_nullable_to_non_nullable
as String,guardeeId: null == guardeeId ? _self.guardeeId : guardeeId // ignore: cast_nullable_to_non_nullable
as String,riskType: null == riskType ? _self.riskType : riskType // ignore: cast_nullable_to_non_nullable
as GuardianNotificationRiskType,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as GuardianNotificationTrigger,responseEventId: freezed == responseEventId ? _self.responseEventId : responseEventId // ignore: cast_nullable_to_non_nullable
as String?,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,guardee: null == guardee ? _self.guardee : guardee // ignore: cast_nullable_to_non_nullable
as GuardianNotificationGuardee,
  ));
}
/// Create a copy of GuardianNotification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuardianNotificationGuardeeCopyWith<$Res> get guardee {

  return $GuardianNotificationGuardeeCopyWith<$Res>(_self.guardee, (value) {
    return _then(_self.copyWith(guardee: value));
  });
}
}


/// Adds pattern-matching-related methods to [GuardianNotification].
extension GuardianNotificationPatterns on GuardianNotification {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuardianNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuardianNotification() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuardianNotification value)  $default,){
final _that = this;
switch (_that) {
case _GuardianNotification():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuardianNotification value)?  $default,){
final _that = this;
switch (_that) {
case _GuardianNotification() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String guardianId,  String guardeeId,  GuardianNotificationRiskType riskType,  GuardianNotificationTrigger trigger,  String? responseEventId,  DateTime sentAt,  GuardianNotificationGuardee guardee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuardianNotification() when $default != null:
return $default(_that.id,_that.guardianId,_that.guardeeId,_that.riskType,_that.trigger,_that.responseEventId,_that.sentAt,_that.guardee);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String guardianId,  String guardeeId,  GuardianNotificationRiskType riskType,  GuardianNotificationTrigger trigger,  String? responseEventId,  DateTime sentAt,  GuardianNotificationGuardee guardee)  $default,) {final _that = this;
switch (_that) {
case _GuardianNotification():
return $default(_that.id,_that.guardianId,_that.guardeeId,_that.riskType,_that.trigger,_that.responseEventId,_that.sentAt,_that.guardee);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String guardianId,  String guardeeId,  GuardianNotificationRiskType riskType,  GuardianNotificationTrigger trigger,  String? responseEventId,  DateTime sentAt,  GuardianNotificationGuardee guardee)?  $default,) {final _that = this;
switch (_that) {
case _GuardianNotification() when $default != null:
return $default(_that.id,_that.guardianId,_that.guardeeId,_that.riskType,_that.trigger,_that.responseEventId,_that.sentAt,_that.guardee);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GuardianNotification extends GuardianNotification {
  const _GuardianNotification({required this.id, required this.guardianId, required this.guardeeId, required this.riskType, required this.trigger, this.responseEventId, required this.sentAt, required this.guardee}): super._();
  factory _GuardianNotification.fromJson(Map<String, dynamic> json) => _$GuardianNotificationFromJson(json);

@override final  String id;
@override final  String guardianId;
@override final  String guardeeId;
@override final  GuardianNotificationRiskType riskType;
@override final  GuardianNotificationTrigger trigger;
@override final  String? responseEventId;
@override final  DateTime sentAt;
@override final  GuardianNotificationGuardee guardee;

/// Create a copy of GuardianNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuardianNotificationCopyWith<_GuardianNotification> get copyWith => __$GuardianNotificationCopyWithImpl<_GuardianNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GuardianNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuardianNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.guardianId, guardianId) || other.guardianId == guardianId)&&(identical(other.guardeeId, guardeeId) || other.guardeeId == guardeeId)&&(identical(other.riskType, riskType) || other.riskType == riskType)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.responseEventId, responseEventId) || other.responseEventId == responseEventId)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.guardee, guardee) || other.guardee == guardee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,guardianId,guardeeId,riskType,trigger,responseEventId,sentAt,guardee);

@override
String toString() {
  return 'GuardianNotification(id: $id, guardianId: $guardianId, guardeeId: $guardeeId, riskType: $riskType, trigger: $trigger, responseEventId: $responseEventId, sentAt: $sentAt, guardee: $guardee)';
}


}

/// @nodoc
abstract mixin class _$GuardianNotificationCopyWith<$Res> implements $GuardianNotificationCopyWith<$Res> {
  factory _$GuardianNotificationCopyWith(_GuardianNotification value, $Res Function(_GuardianNotification) _then) = __$GuardianNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String guardianId, String guardeeId, GuardianNotificationRiskType riskType, GuardianNotificationTrigger trigger, String? responseEventId, DateTime sentAt, GuardianNotificationGuardee guardee
});


@override $GuardianNotificationGuardeeCopyWith<$Res> get guardee;

}
/// @nodoc
class __$GuardianNotificationCopyWithImpl<$Res>
    implements _$GuardianNotificationCopyWith<$Res> {
  __$GuardianNotificationCopyWithImpl(this._self, this._then);

  final _GuardianNotification _self;
  final $Res Function(_GuardianNotification) _then;

/// Create a copy of GuardianNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? guardianId = null,Object? guardeeId = null,Object? riskType = null,Object? trigger = null,Object? responseEventId = freezed,Object? sentAt = null,Object? guardee = null,}) {
  return _then(_GuardianNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,guardianId: null == guardianId ? _self.guardianId : guardianId // ignore: cast_nullable_to_non_nullable
as String,guardeeId: null == guardeeId ? _self.guardeeId : guardeeId // ignore: cast_nullable_to_non_nullable
as String,riskType: null == riskType ? _self.riskType : riskType // ignore: cast_nullable_to_non_nullable
as GuardianNotificationRiskType,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as GuardianNotificationTrigger,responseEventId: freezed == responseEventId ? _self.responseEventId : responseEventId // ignore: cast_nullable_to_non_nullable
as String?,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,guardee: null == guardee ? _self.guardee : guardee // ignore: cast_nullable_to_non_nullable
as GuardianNotificationGuardee,
  ));
}

/// Create a copy of GuardianNotification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuardianNotificationGuardeeCopyWith<$Res> get guardee {

  return $GuardianNotificationGuardeeCopyWith<$Res>(_self.guardee, (value) {
    return _then(_self.copyWith(guardee: value));
  });
}
}


/// @nodoc
mixin _$GuardianNotificationGuardee {

 String get id; String? get displayName; String? get email;
/// Create a copy of GuardianNotificationGuardee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuardianNotificationGuardeeCopyWith<GuardianNotificationGuardee> get copyWith => _$GuardianNotificationGuardeeCopyWithImpl<GuardianNotificationGuardee>(this as GuardianNotificationGuardee, _$identity);

  /// Serializes this GuardianNotificationGuardee to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuardianNotificationGuardee&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,email);

@override
String toString() {
  return 'GuardianNotificationGuardee(id: $id, displayName: $displayName, email: $email)';
}


}

/// @nodoc
abstract mixin class $GuardianNotificationGuardeeCopyWith<$Res>  {
  factory $GuardianNotificationGuardeeCopyWith(GuardianNotificationGuardee value, $Res Function(GuardianNotificationGuardee) _then) = _$GuardianNotificationGuardeeCopyWithImpl;
@useResult
$Res call({
 String id, String? displayName, String? email
});




}
/// @nodoc
class _$GuardianNotificationGuardeeCopyWithImpl<$Res>
    implements $GuardianNotificationGuardeeCopyWith<$Res> {
  _$GuardianNotificationGuardeeCopyWithImpl(this._self, this._then);

  final GuardianNotificationGuardee _self;
  final $Res Function(GuardianNotificationGuardee) _then;

/// Create a copy of GuardianNotificationGuardee
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = freezed,Object? email = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GuardianNotificationGuardee].
extension GuardianNotificationGuardeePatterns on GuardianNotificationGuardee {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuardianNotificationGuardee value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuardianNotificationGuardee() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuardianNotificationGuardee value)  $default,){
final _that = this;
switch (_that) {
case _GuardianNotificationGuardee():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuardianNotificationGuardee value)?  $default,){
final _that = this;
switch (_that) {
case _GuardianNotificationGuardee() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? displayName,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuardianNotificationGuardee() when $default != null:
return $default(_that.id,_that.displayName,_that.email);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? displayName,  String? email)  $default,) {final _that = this;
switch (_that) {
case _GuardianNotificationGuardee():
return $default(_that.id,_that.displayName,_that.email);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? displayName,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _GuardianNotificationGuardee() when $default != null:
return $default(_that.id,_that.displayName,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GuardianNotificationGuardee implements GuardianNotificationGuardee {
  const _GuardianNotificationGuardee({required this.id, this.displayName, this.email});
  factory _GuardianNotificationGuardee.fromJson(Map<String, dynamic> json) => _$GuardianNotificationGuardeeFromJson(json);

@override final  String id;
@override final  String? displayName;
@override final  String? email;

/// Create a copy of GuardianNotificationGuardee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuardianNotificationGuardeeCopyWith<_GuardianNotificationGuardee> get copyWith => __$GuardianNotificationGuardeeCopyWithImpl<_GuardianNotificationGuardee>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GuardianNotificationGuardeeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuardianNotificationGuardee&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,email);

@override
String toString() {
  return 'GuardianNotificationGuardee(id: $id, displayName: $displayName, email: $email)';
}


}

/// @nodoc
abstract mixin class _$GuardianNotificationGuardeeCopyWith<$Res> implements $GuardianNotificationGuardeeCopyWith<$Res> {
  factory _$GuardianNotificationGuardeeCopyWith(_GuardianNotificationGuardee value, $Res Function(_GuardianNotificationGuardee) _then) = __$GuardianNotificationGuardeeCopyWithImpl;
@override @useResult
$Res call({
 String id, String? displayName, String? email
});




}
/// @nodoc
class __$GuardianNotificationGuardeeCopyWithImpl<$Res>
    implements _$GuardianNotificationGuardeeCopyWith<$Res> {
  __$GuardianNotificationGuardeeCopyWithImpl(this._self, this._then);

  final _GuardianNotificationGuardee _self;
  final $Res Function(_GuardianNotificationGuardee) _then;

/// Create a copy of GuardianNotificationGuardee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = freezed,Object? email = freezed,}) {
  return _then(_GuardianNotificationGuardee(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
