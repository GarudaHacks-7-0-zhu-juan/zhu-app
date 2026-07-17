// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guardian_notification_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GuardianNotificationPage {

 List<GuardianNotification> get items; String? get nextCursor; bool get isLoadingMore;
/// Create a copy of GuardianNotificationPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuardianNotificationPageCopyWith<GuardianNotificationPage> get copyWith => _$GuardianNotificationPageCopyWithImpl<GuardianNotificationPage>(this as GuardianNotificationPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuardianNotificationPage&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextCursor,isLoadingMore);

@override
String toString() {
  return 'GuardianNotificationPage(items: $items, nextCursor: $nextCursor, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $GuardianNotificationPageCopyWith<$Res>  {
  factory $GuardianNotificationPageCopyWith(GuardianNotificationPage value, $Res Function(GuardianNotificationPage) _then) = _$GuardianNotificationPageCopyWithImpl;
@useResult
$Res call({
 List<GuardianNotification> items, String? nextCursor, bool isLoadingMore
});




}
/// @nodoc
class _$GuardianNotificationPageCopyWithImpl<$Res>
    implements $GuardianNotificationPageCopyWith<$Res> {
  _$GuardianNotificationPageCopyWithImpl(this._self, this._then);

  final GuardianNotificationPage _self;
  final $Res Function(GuardianNotificationPage) _then;

/// Create a copy of GuardianNotificationPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,Object? isLoadingMore = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<GuardianNotification>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GuardianNotificationPage].
extension GuardianNotificationPagePatterns on GuardianNotificationPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuardianNotificationPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuardianNotificationPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuardianNotificationPage value)  $default,){
final _that = this;
switch (_that) {
case _GuardianNotificationPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuardianNotificationPage value)?  $default,){
final _that = this;
switch (_that) {
case _GuardianNotificationPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GuardianNotification> items,  String? nextCursor,  bool isLoadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuardianNotificationPage() when $default != null:
return $default(_that.items,_that.nextCursor,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GuardianNotification> items,  String? nextCursor,  bool isLoadingMore)  $default,) {final _that = this;
switch (_that) {
case _GuardianNotificationPage():
return $default(_that.items,_that.nextCursor,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GuardianNotification> items,  String? nextCursor,  bool isLoadingMore)?  $default,) {final _that = this;
switch (_that) {
case _GuardianNotificationPage() when $default != null:
return $default(_that.items,_that.nextCursor,_that.isLoadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _GuardianNotificationPage implements GuardianNotificationPage {
  const _GuardianNotificationPage({required final  List<GuardianNotification> items, this.nextCursor, this.isLoadingMore = false}): _items = items;


 final  List<GuardianNotification> _items;
@override List<GuardianNotification> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;
@override@JsonKey() final  bool isLoadingMore;

/// Create a copy of GuardianNotificationPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuardianNotificationPageCopyWith<_GuardianNotificationPage> get copyWith => __$GuardianNotificationPageCopyWithImpl<_GuardianNotificationPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuardianNotificationPage&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor,isLoadingMore);

@override
String toString() {
  return 'GuardianNotificationPage(items: $items, nextCursor: $nextCursor, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$GuardianNotificationPageCopyWith<$Res> implements $GuardianNotificationPageCopyWith<$Res> {
  factory _$GuardianNotificationPageCopyWith(_GuardianNotificationPage value, $Res Function(_GuardianNotificationPage) _then) = __$GuardianNotificationPageCopyWithImpl;
@override @useResult
$Res call({
 List<GuardianNotification> items, String? nextCursor, bool isLoadingMore
});




}
/// @nodoc
class __$GuardianNotificationPageCopyWithImpl<$Res>
    implements _$GuardianNotificationPageCopyWith<$Res> {
  __$GuardianNotificationPageCopyWithImpl(this._self, this._then);

  final _GuardianNotificationPage _self;
  final $Res Function(_GuardianNotificationPage) _then;

/// Create a copy of GuardianNotificationPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,Object? isLoadingMore = null,}) {
  return _then(_GuardianNotificationPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GuardianNotification>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
