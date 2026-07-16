// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_submission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthSubmissionState {

 bool get isSubmitting; AuthFailure? get failure;
/// Create a copy of AuthSubmissionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSubmissionStateCopyWith<AuthSubmissionState> get copyWith => _$AuthSubmissionStateCopyWithImpl<AuthSubmissionState>(this as AuthSubmissionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSubmissionState&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isSubmitting,failure);

@override
String toString() {
  return 'AuthSubmissionState(isSubmitting: $isSubmitting, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AuthSubmissionStateCopyWith<$Res>  {
  factory $AuthSubmissionStateCopyWith(AuthSubmissionState value, $Res Function(AuthSubmissionState) _then) = _$AuthSubmissionStateCopyWithImpl;
@useResult
$Res call({
 bool isSubmitting, AuthFailure? failure
});


$AuthFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$AuthSubmissionStateCopyWithImpl<$Res>
    implements $AuthSubmissionStateCopyWith<$Res> {
  _$AuthSubmissionStateCopyWithImpl(this._self, this._then);

  final AuthSubmissionState _self;
  final $Res Function(AuthSubmissionState) _then;

/// Create a copy of AuthSubmissionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSubmitting = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AuthFailure?,
  ));
}
/// Create a copy of AuthSubmissionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $AuthFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthSubmissionState].
extension AuthSubmissionStatePatterns on AuthSubmissionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthSubmissionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthSubmissionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthSubmissionState value)  $default,){
final _that = this;
switch (_that) {
case _AuthSubmissionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthSubmissionState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthSubmissionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSubmitting,  AuthFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthSubmissionState() when $default != null:
return $default(_that.isSubmitting,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSubmitting,  AuthFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _AuthSubmissionState():
return $default(_that.isSubmitting,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSubmitting,  AuthFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _AuthSubmissionState() when $default != null:
return $default(_that.isSubmitting,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _AuthSubmissionState implements AuthSubmissionState {
  const _AuthSubmissionState({this.isSubmitting = false, this.failure});
  

@override@JsonKey() final  bool isSubmitting;
@override final  AuthFailure? failure;

/// Create a copy of AuthSubmissionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthSubmissionStateCopyWith<_AuthSubmissionState> get copyWith => __$AuthSubmissionStateCopyWithImpl<_AuthSubmissionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSubmissionState&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isSubmitting,failure);

@override
String toString() {
  return 'AuthSubmissionState(isSubmitting: $isSubmitting, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$AuthSubmissionStateCopyWith<$Res> implements $AuthSubmissionStateCopyWith<$Res> {
  factory _$AuthSubmissionStateCopyWith(_AuthSubmissionState value, $Res Function(_AuthSubmissionState) _then) = __$AuthSubmissionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSubmitting, AuthFailure? failure
});


@override $AuthFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$AuthSubmissionStateCopyWithImpl<$Res>
    implements _$AuthSubmissionStateCopyWith<$Res> {
  __$AuthSubmissionStateCopyWithImpl(this._self, this._then);

  final _AuthSubmissionState _self;
  final $Res Function(_AuthSubmissionState) _then;

/// Create a copy of AuthSubmissionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSubmitting = null,Object? failure = freezed,}) {
  return _then(_AuthSubmissionState(
isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AuthFailure?,
  ));
}

/// Create a copy of AuthSubmissionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $AuthFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
