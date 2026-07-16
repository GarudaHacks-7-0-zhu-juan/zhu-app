// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthSessionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSessionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthSessionState()';
}


}

/// @nodoc
class $AuthSessionStateCopyWith<$Res>  {
$AuthSessionStateCopyWith(AuthSessionState _, $Res Function(AuthSessionState) __);
}


/// Adds pattern-matching-related methods to [AuthSessionState].
extension AuthSessionStatePatterns on AuthSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitializingAuthSessionState value)?  initializing,TResult Function( UnauthenticatedAuthSessionState value)?  unauthenticated,TResult Function( UnavailableAuthSessionState value)?  unavailable,TResult Function( AuthenticatedAuthSessionState value)?  authenticated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitializingAuthSessionState() when initializing != null:
return initializing(_that);case UnauthenticatedAuthSessionState() when unauthenticated != null:
return unauthenticated(_that);case UnavailableAuthSessionState() when unavailable != null:
return unavailable(_that);case AuthenticatedAuthSessionState() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitializingAuthSessionState value)  initializing,required TResult Function( UnauthenticatedAuthSessionState value)  unauthenticated,required TResult Function( UnavailableAuthSessionState value)  unavailable,required TResult Function( AuthenticatedAuthSessionState value)  authenticated,}){
final _that = this;
switch (_that) {
case InitializingAuthSessionState():
return initializing(_that);case UnauthenticatedAuthSessionState():
return unauthenticated(_that);case UnavailableAuthSessionState():
return unavailable(_that);case AuthenticatedAuthSessionState():
return authenticated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitializingAuthSessionState value)?  initializing,TResult? Function( UnauthenticatedAuthSessionState value)?  unauthenticated,TResult? Function( UnavailableAuthSessionState value)?  unavailable,TResult? Function( AuthenticatedAuthSessionState value)?  authenticated,}){
final _that = this;
switch (_that) {
case InitializingAuthSessionState() when initializing != null:
return initializing(_that);case UnauthenticatedAuthSessionState() when unauthenticated != null:
return unauthenticated(_that);case UnavailableAuthSessionState() when unavailable != null:
return unavailable(_that);case AuthenticatedAuthSessionState() when authenticated != null:
return authenticated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initializing,TResult Function( String? notice)?  unauthenticated,TResult Function( AuthFailure failure)?  unavailable,TResult Function( AuthUser user)?  authenticated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitializingAuthSessionState() when initializing != null:
return initializing();case UnauthenticatedAuthSessionState() when unauthenticated != null:
return unauthenticated(_that.notice);case UnavailableAuthSessionState() when unavailable != null:
return unavailable(_that.failure);case AuthenticatedAuthSessionState() when authenticated != null:
return authenticated(_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initializing,required TResult Function( String? notice)  unauthenticated,required TResult Function( AuthFailure failure)  unavailable,required TResult Function( AuthUser user)  authenticated,}) {final _that = this;
switch (_that) {
case InitializingAuthSessionState():
return initializing();case UnauthenticatedAuthSessionState():
return unauthenticated(_that.notice);case UnavailableAuthSessionState():
return unavailable(_that.failure);case AuthenticatedAuthSessionState():
return authenticated(_that.user);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initializing,TResult? Function( String? notice)?  unauthenticated,TResult? Function( AuthFailure failure)?  unavailable,TResult? Function( AuthUser user)?  authenticated,}) {final _that = this;
switch (_that) {
case InitializingAuthSessionState() when initializing != null:
return initializing();case UnauthenticatedAuthSessionState() when unauthenticated != null:
return unauthenticated(_that.notice);case UnavailableAuthSessionState() when unavailable != null:
return unavailable(_that.failure);case AuthenticatedAuthSessionState() when authenticated != null:
return authenticated(_that.user);case _:
  return null;

}
}

}

/// @nodoc


class InitializingAuthSessionState implements AuthSessionState {
  const InitializingAuthSessionState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitializingAuthSessionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthSessionState.initializing()';
}


}




/// @nodoc


class UnauthenticatedAuthSessionState implements AuthSessionState {
  const UnauthenticatedAuthSessionState({this.notice});
  

 final  String? notice;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnauthenticatedAuthSessionStateCopyWith<UnauthenticatedAuthSessionState> get copyWith => _$UnauthenticatedAuthSessionStateCopyWithImpl<UnauthenticatedAuthSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthenticatedAuthSessionState&&(identical(other.notice, notice) || other.notice == notice));
}


@override
int get hashCode => Object.hash(runtimeType,notice);

@override
String toString() {
  return 'AuthSessionState.unauthenticated(notice: $notice)';
}


}

/// @nodoc
abstract mixin class $UnauthenticatedAuthSessionStateCopyWith<$Res> implements $AuthSessionStateCopyWith<$Res> {
  factory $UnauthenticatedAuthSessionStateCopyWith(UnauthenticatedAuthSessionState value, $Res Function(UnauthenticatedAuthSessionState) _then) = _$UnauthenticatedAuthSessionStateCopyWithImpl;
@useResult
$Res call({
 String? notice
});




}
/// @nodoc
class _$UnauthenticatedAuthSessionStateCopyWithImpl<$Res>
    implements $UnauthenticatedAuthSessionStateCopyWith<$Res> {
  _$UnauthenticatedAuthSessionStateCopyWithImpl(this._self, this._then);

  final UnauthenticatedAuthSessionState _self;
  final $Res Function(UnauthenticatedAuthSessionState) _then;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notice = freezed,}) {
  return _then(UnauthenticatedAuthSessionState(
notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UnavailableAuthSessionState implements AuthSessionState {
  const UnavailableAuthSessionState(this.failure);
  

 final  AuthFailure failure;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnavailableAuthSessionStateCopyWith<UnavailableAuthSessionState> get copyWith => _$UnavailableAuthSessionStateCopyWithImpl<UnavailableAuthSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnavailableAuthSessionState&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'AuthSessionState.unavailable(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $UnavailableAuthSessionStateCopyWith<$Res> implements $AuthSessionStateCopyWith<$Res> {
  factory $UnavailableAuthSessionStateCopyWith(UnavailableAuthSessionState value, $Res Function(UnavailableAuthSessionState) _then) = _$UnavailableAuthSessionStateCopyWithImpl;
@useResult
$Res call({
 AuthFailure failure
});


$AuthFailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$UnavailableAuthSessionStateCopyWithImpl<$Res>
    implements $UnavailableAuthSessionStateCopyWith<$Res> {
  _$UnavailableAuthSessionStateCopyWithImpl(this._self, this._then);

  final UnavailableAuthSessionState _self;
  final $Res Function(UnavailableAuthSessionState) _then;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(UnavailableAuthSessionState(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AuthFailure,
  ));
}

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<$Res> get failure {
  
  return $AuthFailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc


class AuthenticatedAuthSessionState implements AuthSessionState {
  const AuthenticatedAuthSessionState(this.user);
  

 final  AuthUser user;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticatedAuthSessionStateCopyWith<AuthenticatedAuthSessionState> get copyWith => _$AuthenticatedAuthSessionStateCopyWithImpl<AuthenticatedAuthSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticatedAuthSessionState&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthSessionState.authenticated(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthenticatedAuthSessionStateCopyWith<$Res> implements $AuthSessionStateCopyWith<$Res> {
  factory $AuthenticatedAuthSessionStateCopyWith(AuthenticatedAuthSessionState value, $Res Function(AuthenticatedAuthSessionState) _then) = _$AuthenticatedAuthSessionStateCopyWithImpl;
@useResult
$Res call({
 AuthUser user
});


$AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthenticatedAuthSessionStateCopyWithImpl<$Res>
    implements $AuthenticatedAuthSessionStateCopyWith<$Res> {
  _$AuthenticatedAuthSessionStateCopyWithImpl(this._self, this._then);

  final AuthenticatedAuthSessionState _self;
  final $Res Function(AuthenticatedAuthSessionState) _then;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(AuthenticatedAuthSessionState(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,
  ));
}

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
