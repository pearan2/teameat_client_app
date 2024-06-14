import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class _DefaultLoadingWidget extends StatelessWidget {
  final Widget child;
  const _DefaultLoadingWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: AbsorbPointer(
        absorbing: true,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(4)),
          child: child,
        ),
      ),
    );
  }
}

class _DefaultFailureWidget extends StatelessWidget {
  final String failureString;
  final Widget child;
  const _DefaultFailureWidget(
      {required this.failureString, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
            child: Container(color: Colors.grey, child: const Placeholder()))
      ],
    );
  }
}

enum _ValueStatus { loading, failure, success }

class RxWrapper<F, T> {
  static Widget Function(Widget child) defaultLoadingBuilder =
      (child) => _DefaultLoadingWidget(child: child);
  static Widget Function(String failureString, Widget child)
      defaultFailureBuilder = (failureString, child) =>
          _DefaultFailureWidget(failureString: failureString, child: child);

  final Rx<_ValueStatus> _status = _ValueStatus.loading.obs;
  T _value;
  final T _emptyValue;
  F? failure;
  final Future<Either<F, T>> Function() loader;

  T get value => _value;
  set value(T newValue) {
    _status.value = _ValueStatus.loading;
    _value = newValue;
    _status.value = _ValueStatus.success;
  }

  RxWrapper({
    required T emptyValue,
    required this.loader,
    bool initLoad = true,
  })  : _emptyValue = emptyValue,
        _value = emptyValue {
    if (initLoad) {
      load();
    } else {
      _status.value = _ValueStatus.success;
    }
  }

  Future<Either<F, T>> load() async {
    _status.value = _ValueStatus.loading;
    final ret = await loader();
    ret.fold((f) {
      failure = f;
      _status.value = _ValueStatus.failure;
    }, (r) {
      _value = r;
      _status.value = _ValueStatus.success;
    });
    return ret;
  }

  Widget obx(
    Widget Function(T) builder, {
    final Widget Function(Widget child)? loadingBuilder,
    final Widget Function(String failureString, Widget child)? failureBuilder,
  }) {
    return Obx(() {
      switch (_status.value) {
        case _ValueStatus.loading:
          {
            final currentLoadingBuilder =
                loadingBuilder ?? defaultLoadingBuilder;
            return currentLoadingBuilder(builder(_emptyValue));
          }
        case _ValueStatus.failure:
          {
            final currentFailureBuilder =
                failureBuilder ?? defaultFailureBuilder;
            return currentFailureBuilder(
                failure!.toString(), builder(_emptyValue));
          }
        case _ValueStatus.success:
          return builder(_value);
        default:
          {
            throw "Invalid value detected";
          }
      }
    });
  }
}

extension RxExtension<T> on T {
  RxWrapper<F, T> wrap<F>(
    Future<Either<F, T>> Function() loader, {
    bool autoStartLoad = true,
    Widget Function(Widget child)? loadingBuilder,
    Widget Function(String failureString, Widget child)? failureBuilder,
  }) {
    return RxWrapper(
      emptyValue: this,
      loader: loader,
      initLoad: autoStartLoad,
    );
  }
}

extension GetViewExtension<T> on GetView<T> {
  T get c => controller;
}
