// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure()';
}


}

/// @nodoc
class $AuthFailureCopyWith<$Res>  {
$AuthFailureCopyWith(AuthFailure _, $Res Function(AuthFailure) __);
}


/// Adds pattern-matching-related methods to [AuthFailure].
extension AuthFailurePatterns on AuthFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ValidationAuthFailure value)?  validation,TResult Function( InvalidCredentialsAuthFailure value)?  invalidCredentials,TResult Function( AccountAlreadyRegisteredAuthFailure value)?  accountAlreadyRegistered,TResult Function( UnauthorizedSessionAuthFailure value)?  unauthorizedSession,TResult Function( NetworkAuthFailure value)?  network,TResult Function( TimeoutAuthFailure value)?  timeout,TResult Function( UnexpectedAuthFailure value)?  unexpected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ValidationAuthFailure() when validation != null:
return validation(_that);case InvalidCredentialsAuthFailure() when invalidCredentials != null:
return invalidCredentials(_that);case AccountAlreadyRegisteredAuthFailure() when accountAlreadyRegistered != null:
return accountAlreadyRegistered(_that);case UnauthorizedSessionAuthFailure() when unauthorizedSession != null:
return unauthorizedSession(_that);case NetworkAuthFailure() when network != null:
return network(_that);case TimeoutAuthFailure() when timeout != null:
return timeout(_that);case UnexpectedAuthFailure() when unexpected != null:
return unexpected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ValidationAuthFailure value)  validation,required TResult Function( InvalidCredentialsAuthFailure value)  invalidCredentials,required TResult Function( AccountAlreadyRegisteredAuthFailure value)  accountAlreadyRegistered,required TResult Function( UnauthorizedSessionAuthFailure value)  unauthorizedSession,required TResult Function( NetworkAuthFailure value)  network,required TResult Function( TimeoutAuthFailure value)  timeout,required TResult Function( UnexpectedAuthFailure value)  unexpected,}){
final _that = this;
switch (_that) {
case ValidationAuthFailure():
return validation(_that);case InvalidCredentialsAuthFailure():
return invalidCredentials(_that);case AccountAlreadyRegisteredAuthFailure():
return accountAlreadyRegistered(_that);case UnauthorizedSessionAuthFailure():
return unauthorizedSession(_that);case NetworkAuthFailure():
return network(_that);case TimeoutAuthFailure():
return timeout(_that);case UnexpectedAuthFailure():
return unexpected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ValidationAuthFailure value)?  validation,TResult? Function( InvalidCredentialsAuthFailure value)?  invalidCredentials,TResult? Function( AccountAlreadyRegisteredAuthFailure value)?  accountAlreadyRegistered,TResult? Function( UnauthorizedSessionAuthFailure value)?  unauthorizedSession,TResult? Function( NetworkAuthFailure value)?  network,TResult? Function( TimeoutAuthFailure value)?  timeout,TResult? Function( UnexpectedAuthFailure value)?  unexpected,}){
final _that = this;
switch (_that) {
case ValidationAuthFailure() when validation != null:
return validation(_that);case InvalidCredentialsAuthFailure() when invalidCredentials != null:
return invalidCredentials(_that);case AccountAlreadyRegisteredAuthFailure() when accountAlreadyRegistered != null:
return accountAlreadyRegistered(_that);case UnauthorizedSessionAuthFailure() when unauthorizedSession != null:
return unauthorizedSession(_that);case NetworkAuthFailure() when network != null:
return network(_that);case TimeoutAuthFailure() when timeout != null:
return timeout(_that);case UnexpectedAuthFailure() when unexpected != null:
return unexpected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  validation,TResult Function()?  invalidCredentials,TResult Function()?  accountAlreadyRegistered,TResult Function()?  unauthorizedSession,TResult Function()?  network,TResult Function()?  timeout,TResult Function()?  unexpected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ValidationAuthFailure() when validation != null:
return validation();case InvalidCredentialsAuthFailure() when invalidCredentials != null:
return invalidCredentials();case AccountAlreadyRegisteredAuthFailure() when accountAlreadyRegistered != null:
return accountAlreadyRegistered();case UnauthorizedSessionAuthFailure() when unauthorizedSession != null:
return unauthorizedSession();case NetworkAuthFailure() when network != null:
return network();case TimeoutAuthFailure() when timeout != null:
return timeout();case UnexpectedAuthFailure() when unexpected != null:
return unexpected();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  validation,required TResult Function()  invalidCredentials,required TResult Function()  accountAlreadyRegistered,required TResult Function()  unauthorizedSession,required TResult Function()  network,required TResult Function()  timeout,required TResult Function()  unexpected,}) {final _that = this;
switch (_that) {
case ValidationAuthFailure():
return validation();case InvalidCredentialsAuthFailure():
return invalidCredentials();case AccountAlreadyRegisteredAuthFailure():
return accountAlreadyRegistered();case UnauthorizedSessionAuthFailure():
return unauthorizedSession();case NetworkAuthFailure():
return network();case TimeoutAuthFailure():
return timeout();case UnexpectedAuthFailure():
return unexpected();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  validation,TResult? Function()?  invalidCredentials,TResult? Function()?  accountAlreadyRegistered,TResult? Function()?  unauthorizedSession,TResult? Function()?  network,TResult? Function()?  timeout,TResult? Function()?  unexpected,}) {final _that = this;
switch (_that) {
case ValidationAuthFailure() when validation != null:
return validation();case InvalidCredentialsAuthFailure() when invalidCredentials != null:
return invalidCredentials();case AccountAlreadyRegisteredAuthFailure() when accountAlreadyRegistered != null:
return accountAlreadyRegistered();case UnauthorizedSessionAuthFailure() when unauthorizedSession != null:
return unauthorizedSession();case NetworkAuthFailure() when network != null:
return network();case TimeoutAuthFailure() when timeout != null:
return timeout();case UnexpectedAuthFailure() when unexpected != null:
return unexpected();case _:
  return null;

}
}

}

/// @nodoc


class ValidationAuthFailure implements AuthFailure {
  const ValidationAuthFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationAuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.validation()';
}


}




/// @nodoc


class InvalidCredentialsAuthFailure implements AuthFailure {
  const InvalidCredentialsAuthFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidCredentialsAuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.invalidCredentials()';
}


}




/// @nodoc


class AccountAlreadyRegisteredAuthFailure implements AuthFailure {
  const AccountAlreadyRegisteredAuthFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountAlreadyRegisteredAuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.accountAlreadyRegistered()';
}


}




/// @nodoc


class UnauthorizedSessionAuthFailure implements AuthFailure {
  const UnauthorizedSessionAuthFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedSessionAuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.unauthorizedSession()';
}


}




/// @nodoc


class NetworkAuthFailure implements AuthFailure {
  const NetworkAuthFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkAuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.network()';
}


}




/// @nodoc


class TimeoutAuthFailure implements AuthFailure {
  const TimeoutAuthFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeoutAuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.timeout()';
}


}




/// @nodoc


class UnexpectedAuthFailure implements AuthFailure {
  const UnexpectedAuthFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnexpectedAuthFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure.unexpected()';
}


}




// dart format on
