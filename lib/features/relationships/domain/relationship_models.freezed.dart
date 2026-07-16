// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'relationship_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RelationshipUser {

 String get id; String? get email; String? get phoneNumber; GuardeeLocation? get location;
/// Create a copy of RelationshipUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelationshipUserCopyWith<RelationshipUser> get copyWith => _$RelationshipUserCopyWithImpl<RelationshipUser>(this as RelationshipUser, _$identity);

  /// Serializes this RelationshipUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelationshipUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,phoneNumber,location);

@override
String toString() {
  return 'RelationshipUser(id: $id, email: $email, phoneNumber: $phoneNumber, location: $location)';
}


}

/// @nodoc
abstract mixin class $RelationshipUserCopyWith<$Res>  {
  factory $RelationshipUserCopyWith(RelationshipUser value, $Res Function(RelationshipUser) _then) = _$RelationshipUserCopyWithImpl;
@useResult
$Res call({
 String id, String? email, String? phoneNumber, GuardeeLocation? location
});


$GuardeeLocationCopyWith<$Res>? get location;

}
/// @nodoc
class _$RelationshipUserCopyWithImpl<$Res>
    implements $RelationshipUserCopyWith<$Res> {
  _$RelationshipUserCopyWithImpl(this._self, this._then);

  final RelationshipUser _self;
  final $Res Function(RelationshipUser) _then;

/// Create a copy of RelationshipUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = freezed,Object? phoneNumber = freezed,Object? location = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GuardeeLocation?,
  ));
}
/// Create a copy of RelationshipUser
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuardeeLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $GuardeeLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [RelationshipUser].
extension RelationshipUserPatterns on RelationshipUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelationshipUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelationshipUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelationshipUser value)  $default,){
final _that = this;
switch (_that) {
case _RelationshipUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelationshipUser value)?  $default,){
final _that = this;
switch (_that) {
case _RelationshipUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? email,  String? phoneNumber,  GuardeeLocation? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelationshipUser() when $default != null:
return $default(_that.id,_that.email,_that.phoneNumber,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? email,  String? phoneNumber,  GuardeeLocation? location)  $default,) {final _that = this;
switch (_that) {
case _RelationshipUser():
return $default(_that.id,_that.email,_that.phoneNumber,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? email,  String? phoneNumber,  GuardeeLocation? location)?  $default,) {final _that = this;
switch (_that) {
case _RelationshipUser() when $default != null:
return $default(_that.id,_that.email,_that.phoneNumber,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RelationshipUser implements RelationshipUser {
  const _RelationshipUser({required this.id, this.email, this.phoneNumber, this.location});
  factory _RelationshipUser.fromJson(Map<String, dynamic> json) => _$RelationshipUserFromJson(json);

@override final  String id;
@override final  String? email;
@override final  String? phoneNumber;
@override final  GuardeeLocation? location;

/// Create a copy of RelationshipUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelationshipUserCopyWith<_RelationshipUser> get copyWith => __$RelationshipUserCopyWithImpl<_RelationshipUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RelationshipUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelationshipUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,phoneNumber,location);

@override
String toString() {
  return 'RelationshipUser(id: $id, email: $email, phoneNumber: $phoneNumber, location: $location)';
}


}

/// @nodoc
abstract mixin class _$RelationshipUserCopyWith<$Res> implements $RelationshipUserCopyWith<$Res> {
  factory _$RelationshipUserCopyWith(_RelationshipUser value, $Res Function(_RelationshipUser) _then) = __$RelationshipUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String? email, String? phoneNumber, GuardeeLocation? location
});


@override $GuardeeLocationCopyWith<$Res>? get location;

}
/// @nodoc
class __$RelationshipUserCopyWithImpl<$Res>
    implements _$RelationshipUserCopyWith<$Res> {
  __$RelationshipUserCopyWithImpl(this._self, this._then);

  final _RelationshipUser _self;
  final $Res Function(_RelationshipUser) _then;

/// Create a copy of RelationshipUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = freezed,Object? phoneNumber = freezed,Object? location = freezed,}) {
  return _then(_RelationshipUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GuardeeLocation?,
  ));
}

/// Create a copy of RelationshipUser
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuardeeLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $GuardeeLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$RelationshipRequest {

 RelationshipUser get counterpart;@JsonKey(fromJson: relationshipRequestStatusFromJson, toJson: relationshipRequestStatusToJson) RelationshipRequestStatus get status;@JsonKey(fromJson: requestedByRoleFromJson, toJson: requestedByRoleToJson) RequestedByRole get requestedByRole;
/// Create a copy of RelationshipRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelationshipRequestCopyWith<RelationshipRequest> get copyWith => _$RelationshipRequestCopyWithImpl<RelationshipRequest>(this as RelationshipRequest, _$identity);

  /// Serializes this RelationshipRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelationshipRequest&&(identical(other.counterpart, counterpart) || other.counterpart == counterpart)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestedByRole, requestedByRole) || other.requestedByRole == requestedByRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,counterpart,status,requestedByRole);

@override
String toString() {
  return 'RelationshipRequest(counterpart: $counterpart, status: $status, requestedByRole: $requestedByRole)';
}


}

/// @nodoc
abstract mixin class $RelationshipRequestCopyWith<$Res>  {
  factory $RelationshipRequestCopyWith(RelationshipRequest value, $Res Function(RelationshipRequest) _then) = _$RelationshipRequestCopyWithImpl;
@useResult
$Res call({
 RelationshipUser counterpart,@JsonKey(fromJson: relationshipRequestStatusFromJson, toJson: relationshipRequestStatusToJson) RelationshipRequestStatus status,@JsonKey(fromJson: requestedByRoleFromJson, toJson: requestedByRoleToJson) RequestedByRole requestedByRole
});


$RelationshipUserCopyWith<$Res> get counterpart;

}
/// @nodoc
class _$RelationshipRequestCopyWithImpl<$Res>
    implements $RelationshipRequestCopyWith<$Res> {
  _$RelationshipRequestCopyWithImpl(this._self, this._then);

  final RelationshipRequest _self;
  final $Res Function(RelationshipRequest) _then;

/// Create a copy of RelationshipRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? counterpart = null,Object? status = null,Object? requestedByRole = null,}) {
  return _then(_self.copyWith(
counterpart: null == counterpart ? _self.counterpart : counterpart // ignore: cast_nullable_to_non_nullable
as RelationshipUser,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RelationshipRequestStatus,requestedByRole: null == requestedByRole ? _self.requestedByRole : requestedByRole // ignore: cast_nullable_to_non_nullable
as RequestedByRole,
  ));
}
/// Create a copy of RelationshipRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RelationshipUserCopyWith<$Res> get counterpart {
  
  return $RelationshipUserCopyWith<$Res>(_self.counterpart, (value) {
    return _then(_self.copyWith(counterpart: value));
  });
}
}


/// Adds pattern-matching-related methods to [RelationshipRequest].
extension RelationshipRequestPatterns on RelationshipRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelationshipRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelationshipRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelationshipRequest value)  $default,){
final _that = this;
switch (_that) {
case _RelationshipRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelationshipRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RelationshipRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RelationshipUser counterpart, @JsonKey(fromJson: relationshipRequestStatusFromJson, toJson: relationshipRequestStatusToJson)  RelationshipRequestStatus status, @JsonKey(fromJson: requestedByRoleFromJson, toJson: requestedByRoleToJson)  RequestedByRole requestedByRole)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelationshipRequest() when $default != null:
return $default(_that.counterpart,_that.status,_that.requestedByRole);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RelationshipUser counterpart, @JsonKey(fromJson: relationshipRequestStatusFromJson, toJson: relationshipRequestStatusToJson)  RelationshipRequestStatus status, @JsonKey(fromJson: requestedByRoleFromJson, toJson: requestedByRoleToJson)  RequestedByRole requestedByRole)  $default,) {final _that = this;
switch (_that) {
case _RelationshipRequest():
return $default(_that.counterpart,_that.status,_that.requestedByRole);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RelationshipUser counterpart, @JsonKey(fromJson: relationshipRequestStatusFromJson, toJson: relationshipRequestStatusToJson)  RelationshipRequestStatus status, @JsonKey(fromJson: requestedByRoleFromJson, toJson: requestedByRoleToJson)  RequestedByRole requestedByRole)?  $default,) {final _that = this;
switch (_that) {
case _RelationshipRequest() when $default != null:
return $default(_that.counterpart,_that.status,_that.requestedByRole);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RelationshipRequest extends RelationshipRequest {
  const _RelationshipRequest({required this.counterpart, @JsonKey(fromJson: relationshipRequestStatusFromJson, toJson: relationshipRequestStatusToJson) required this.status, @JsonKey(fromJson: requestedByRoleFromJson, toJson: requestedByRoleToJson) required this.requestedByRole}): super._();
  factory _RelationshipRequest.fromJson(Map<String, dynamic> json) => _$RelationshipRequestFromJson(json);

@override final  RelationshipUser counterpart;
@override@JsonKey(fromJson: relationshipRequestStatusFromJson, toJson: relationshipRequestStatusToJson) final  RelationshipRequestStatus status;
@override@JsonKey(fromJson: requestedByRoleFromJson, toJson: requestedByRoleToJson) final  RequestedByRole requestedByRole;

/// Create a copy of RelationshipRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelationshipRequestCopyWith<_RelationshipRequest> get copyWith => __$RelationshipRequestCopyWithImpl<_RelationshipRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RelationshipRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelationshipRequest&&(identical(other.counterpart, counterpart) || other.counterpart == counterpart)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestedByRole, requestedByRole) || other.requestedByRole == requestedByRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,counterpart,status,requestedByRole);

@override
String toString() {
  return 'RelationshipRequest(counterpart: $counterpart, status: $status, requestedByRole: $requestedByRole)';
}


}

/// @nodoc
abstract mixin class _$RelationshipRequestCopyWith<$Res> implements $RelationshipRequestCopyWith<$Res> {
  factory _$RelationshipRequestCopyWith(_RelationshipRequest value, $Res Function(_RelationshipRequest) _then) = __$RelationshipRequestCopyWithImpl;
@override @useResult
$Res call({
 RelationshipUser counterpart,@JsonKey(fromJson: relationshipRequestStatusFromJson, toJson: relationshipRequestStatusToJson) RelationshipRequestStatus status,@JsonKey(fromJson: requestedByRoleFromJson, toJson: requestedByRoleToJson) RequestedByRole requestedByRole
});


@override $RelationshipUserCopyWith<$Res> get counterpart;

}
/// @nodoc
class __$RelationshipRequestCopyWithImpl<$Res>
    implements _$RelationshipRequestCopyWith<$Res> {
  __$RelationshipRequestCopyWithImpl(this._self, this._then);

  final _RelationshipRequest _self;
  final $Res Function(_RelationshipRequest) _then;

/// Create a copy of RelationshipRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? counterpart = null,Object? status = null,Object? requestedByRole = null,}) {
  return _then(_RelationshipRequest(
counterpart: null == counterpart ? _self.counterpart : counterpart // ignore: cast_nullable_to_non_nullable
as RelationshipUser,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RelationshipRequestStatus,requestedByRole: null == requestedByRole ? _self.requestedByRole : requestedByRole // ignore: cast_nullable_to_non_nullable
as RequestedByRole,
  ));
}

/// Create a copy of RelationshipRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RelationshipUserCopyWith<$Res> get counterpart {
  
  return $RelationshipUserCopyWith<$Res>(_self.counterpart, (value) {
    return _then(_self.copyWith(counterpart: value));
  });
}
}

/// @nodoc
mixin _$RelationshipData {

 List<RelationshipUser> get accepted; List<RelationshipRequest> get requests;
/// Create a copy of RelationshipData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelationshipDataCopyWith<RelationshipData> get copyWith => _$RelationshipDataCopyWithImpl<RelationshipData>(this as RelationshipData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelationshipData&&const DeepCollectionEquality().equals(other.accepted, accepted)&&const DeepCollectionEquality().equals(other.requests, requests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(accepted),const DeepCollectionEquality().hash(requests));

@override
String toString() {
  return 'RelationshipData(accepted: $accepted, requests: $requests)';
}


}

/// @nodoc
abstract mixin class $RelationshipDataCopyWith<$Res>  {
  factory $RelationshipDataCopyWith(RelationshipData value, $Res Function(RelationshipData) _then) = _$RelationshipDataCopyWithImpl;
@useResult
$Res call({
 List<RelationshipUser> accepted, List<RelationshipRequest> requests
});




}
/// @nodoc
class _$RelationshipDataCopyWithImpl<$Res>
    implements $RelationshipDataCopyWith<$Res> {
  _$RelationshipDataCopyWithImpl(this._self, this._then);

  final RelationshipData _self;
  final $Res Function(RelationshipData) _then;

/// Create a copy of RelationshipData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accepted = null,Object? requests = null,}) {
  return _then(_self.copyWith(
accepted: null == accepted ? _self.accepted : accepted // ignore: cast_nullable_to_non_nullable
as List<RelationshipUser>,requests: null == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as List<RelationshipRequest>,
  ));
}

}


/// Adds pattern-matching-related methods to [RelationshipData].
extension RelationshipDataPatterns on RelationshipData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelationshipData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelationshipData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelationshipData value)  $default,){
final _that = this;
switch (_that) {
case _RelationshipData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelationshipData value)?  $default,){
final _that = this;
switch (_that) {
case _RelationshipData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RelationshipUser> accepted,  List<RelationshipRequest> requests)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelationshipData() when $default != null:
return $default(_that.accepted,_that.requests);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RelationshipUser> accepted,  List<RelationshipRequest> requests)  $default,) {final _that = this;
switch (_that) {
case _RelationshipData():
return $default(_that.accepted,_that.requests);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RelationshipUser> accepted,  List<RelationshipRequest> requests)?  $default,) {final _that = this;
switch (_that) {
case _RelationshipData() when $default != null:
return $default(_that.accepted,_that.requests);case _:
  return null;

}
}

}

/// @nodoc


class _RelationshipData implements RelationshipData {
  const _RelationshipData({required final  List<RelationshipUser> accepted, required final  List<RelationshipRequest> requests}): _accepted = accepted,_requests = requests;
  

 final  List<RelationshipUser> _accepted;
@override List<RelationshipUser> get accepted {
  if (_accepted is EqualUnmodifiableListView) return _accepted;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accepted);
}

 final  List<RelationshipRequest> _requests;
@override List<RelationshipRequest> get requests {
  if (_requests is EqualUnmodifiableListView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requests);
}


/// Create a copy of RelationshipData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelationshipDataCopyWith<_RelationshipData> get copyWith => __$RelationshipDataCopyWithImpl<_RelationshipData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelationshipData&&const DeepCollectionEquality().equals(other._accepted, _accepted)&&const DeepCollectionEquality().equals(other._requests, _requests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_accepted),const DeepCollectionEquality().hash(_requests));

@override
String toString() {
  return 'RelationshipData(accepted: $accepted, requests: $requests)';
}


}

/// @nodoc
abstract mixin class _$RelationshipDataCopyWith<$Res> implements $RelationshipDataCopyWith<$Res> {
  factory _$RelationshipDataCopyWith(_RelationshipData value, $Res Function(_RelationshipData) _then) = __$RelationshipDataCopyWithImpl;
@override @useResult
$Res call({
 List<RelationshipUser> accepted, List<RelationshipRequest> requests
});




}
/// @nodoc
class __$RelationshipDataCopyWithImpl<$Res>
    implements _$RelationshipDataCopyWith<$Res> {
  __$RelationshipDataCopyWithImpl(this._self, this._then);

  final _RelationshipData _self;
  final $Res Function(_RelationshipData) _then;

/// Create a copy of RelationshipData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accepted = null,Object? requests = null,}) {
  return _then(_RelationshipData(
accepted: null == accepted ? _self._accepted : accepted // ignore: cast_nullable_to_non_nullable
as List<RelationshipUser>,requests: null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as List<RelationshipRequest>,
  ));
}


}


/// @nodoc
mixin _$GuardeeDetail {

 RelationshipUser get guardee; GuardeeLocation? get location;
/// Create a copy of GuardeeDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuardeeDetailCopyWith<GuardeeDetail> get copyWith => _$GuardeeDetailCopyWithImpl<GuardeeDetail>(this as GuardeeDetail, _$identity);

  /// Serializes this GuardeeDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuardeeDetail&&(identical(other.guardee, guardee) || other.guardee == guardee)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,guardee,location);

@override
String toString() {
  return 'GuardeeDetail(guardee: $guardee, location: $location)';
}


}

/// @nodoc
abstract mixin class $GuardeeDetailCopyWith<$Res>  {
  factory $GuardeeDetailCopyWith(GuardeeDetail value, $Res Function(GuardeeDetail) _then) = _$GuardeeDetailCopyWithImpl;
@useResult
$Res call({
 RelationshipUser guardee, GuardeeLocation? location
});


$RelationshipUserCopyWith<$Res> get guardee;$GuardeeLocationCopyWith<$Res>? get location;

}
/// @nodoc
class _$GuardeeDetailCopyWithImpl<$Res>
    implements $GuardeeDetailCopyWith<$Res> {
  _$GuardeeDetailCopyWithImpl(this._self, this._then);

  final GuardeeDetail _self;
  final $Res Function(GuardeeDetail) _then;

/// Create a copy of GuardeeDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? guardee = null,Object? location = freezed,}) {
  return _then(_self.copyWith(
guardee: null == guardee ? _self.guardee : guardee // ignore: cast_nullable_to_non_nullable
as RelationshipUser,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GuardeeLocation?,
  ));
}
/// Create a copy of GuardeeDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RelationshipUserCopyWith<$Res> get guardee {
  
  return $RelationshipUserCopyWith<$Res>(_self.guardee, (value) {
    return _then(_self.copyWith(guardee: value));
  });
}/// Create a copy of GuardeeDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuardeeLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $GuardeeLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [GuardeeDetail].
extension GuardeeDetailPatterns on GuardeeDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuardeeDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuardeeDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuardeeDetail value)  $default,){
final _that = this;
switch (_that) {
case _GuardeeDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuardeeDetail value)?  $default,){
final _that = this;
switch (_that) {
case _GuardeeDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RelationshipUser guardee,  GuardeeLocation? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuardeeDetail() when $default != null:
return $default(_that.guardee,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RelationshipUser guardee,  GuardeeLocation? location)  $default,) {final _that = this;
switch (_that) {
case _GuardeeDetail():
return $default(_that.guardee,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RelationshipUser guardee,  GuardeeLocation? location)?  $default,) {final _that = this;
switch (_that) {
case _GuardeeDetail() when $default != null:
return $default(_that.guardee,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GuardeeDetail implements GuardeeDetail {
  const _GuardeeDetail({required this.guardee, this.location});
  factory _GuardeeDetail.fromJson(Map<String, dynamic> json) => _$GuardeeDetailFromJson(json);

@override final  RelationshipUser guardee;
@override final  GuardeeLocation? location;

/// Create a copy of GuardeeDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuardeeDetailCopyWith<_GuardeeDetail> get copyWith => __$GuardeeDetailCopyWithImpl<_GuardeeDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GuardeeDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuardeeDetail&&(identical(other.guardee, guardee) || other.guardee == guardee)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,guardee,location);

@override
String toString() {
  return 'GuardeeDetail(guardee: $guardee, location: $location)';
}


}

/// @nodoc
abstract mixin class _$GuardeeDetailCopyWith<$Res> implements $GuardeeDetailCopyWith<$Res> {
  factory _$GuardeeDetailCopyWith(_GuardeeDetail value, $Res Function(_GuardeeDetail) _then) = __$GuardeeDetailCopyWithImpl;
@override @useResult
$Res call({
 RelationshipUser guardee, GuardeeLocation? location
});


@override $RelationshipUserCopyWith<$Res> get guardee;@override $GuardeeLocationCopyWith<$Res>? get location;

}
/// @nodoc
class __$GuardeeDetailCopyWithImpl<$Res>
    implements _$GuardeeDetailCopyWith<$Res> {
  __$GuardeeDetailCopyWithImpl(this._self, this._then);

  final _GuardeeDetail _self;
  final $Res Function(_GuardeeDetail) _then;

/// Create a copy of GuardeeDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? guardee = null,Object? location = freezed,}) {
  return _then(_GuardeeDetail(
guardee: null == guardee ? _self.guardee : guardee // ignore: cast_nullable_to_non_nullable
as RelationshipUser,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GuardeeLocation?,
  ));
}

/// Create a copy of GuardeeDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RelationshipUserCopyWith<$Res> get guardee {
  
  return $RelationshipUserCopyWith<$Res>(_self.guardee, (value) {
    return _then(_self.copyWith(guardee: value));
  });
}/// Create a copy of GuardeeDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuardeeLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $GuardeeLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$GuardeeLocation {

 double? get latitude; double? get longitude; DateTime? get updatedAt;
/// Create a copy of GuardeeLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuardeeLocationCopyWith<GuardeeLocation> get copyWith => _$GuardeeLocationCopyWithImpl<GuardeeLocation>(this as GuardeeLocation, _$identity);

  /// Serializes this GuardeeLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuardeeLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,updatedAt);

@override
String toString() {
  return 'GuardeeLocation(latitude: $latitude, longitude: $longitude, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GuardeeLocationCopyWith<$Res>  {
  factory $GuardeeLocationCopyWith(GuardeeLocation value, $Res Function(GuardeeLocation) _then) = _$GuardeeLocationCopyWithImpl;
@useResult
$Res call({
 double? latitude, double? longitude, DateTime? updatedAt
});




}
/// @nodoc
class _$GuardeeLocationCopyWithImpl<$Res>
    implements $GuardeeLocationCopyWith<$Res> {
  _$GuardeeLocationCopyWithImpl(this._self, this._then);

  final GuardeeLocation _self;
  final $Res Function(GuardeeLocation) _then;

/// Create a copy of GuardeeLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = freezed,Object? longitude = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GuardeeLocation].
extension GuardeeLocationPatterns on GuardeeLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuardeeLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuardeeLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuardeeLocation value)  $default,){
final _that = this;
switch (_that) {
case _GuardeeLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuardeeLocation value)?  $default,){
final _that = this;
switch (_that) {
case _GuardeeLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? latitude,  double? longitude,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuardeeLocation() when $default != null:
return $default(_that.latitude,_that.longitude,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? latitude,  double? longitude,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _GuardeeLocation():
return $default(_that.latitude,_that.longitude,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? latitude,  double? longitude,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _GuardeeLocation() when $default != null:
return $default(_that.latitude,_that.longitude,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GuardeeLocation implements GuardeeLocation {
  const _GuardeeLocation({this.latitude, this.longitude, this.updatedAt});
  factory _GuardeeLocation.fromJson(Map<String, dynamic> json) => _$GuardeeLocationFromJson(json);

@override final  double? latitude;
@override final  double? longitude;
@override final  DateTime? updatedAt;

/// Create a copy of GuardeeLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuardeeLocationCopyWith<_GuardeeLocation> get copyWith => __$GuardeeLocationCopyWithImpl<_GuardeeLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GuardeeLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuardeeLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,updatedAt);

@override
String toString() {
  return 'GuardeeLocation(latitude: $latitude, longitude: $longitude, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GuardeeLocationCopyWith<$Res> implements $GuardeeLocationCopyWith<$Res> {
  factory _$GuardeeLocationCopyWith(_GuardeeLocation value, $Res Function(_GuardeeLocation) _then) = __$GuardeeLocationCopyWithImpl;
@override @useResult
$Res call({
 double? latitude, double? longitude, DateTime? updatedAt
});




}
/// @nodoc
class __$GuardeeLocationCopyWithImpl<$Res>
    implements _$GuardeeLocationCopyWith<$Res> {
  __$GuardeeLocationCopyWithImpl(this._self, this._then);

  final _GuardeeLocation _self;
  final $Res Function(_GuardeeLocation) _then;

/// Create a copy of GuardeeLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = freezed,Object? longitude = freezed,Object? updatedAt = freezed,}) {
  return _then(_GuardeeLocation(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
