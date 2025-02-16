import 'package:appainter/button_theme/button_theme.dart';
import 'package:appainter/color_theme/color_theme.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils.dart';
import 'mocks.dart';

void main() {
  const buttonStyle = ButtonStyle();
  final colorScheme = ThemeData().colorScheme;

  late Color color;
  late ColorThemeCubit colorThemeCubit;
  late TestButtonStyleCubit sut;

  setUp(() {
    color = getRandomColor();
    colorThemeCubit = MockColorThemeCubit();

    when(() => colorThemeCubit.state).thenReturn(ColorThemeState());

    sut = TestButtonStyleCubit(colorThemeCubit: colorThemeCubit);
  });

  blocTest<TestButtonStyleCubit, ButtonStyleState>(
    'emit style',
    build: () => sut,
    act: (cubit) => cubit.styleChanged(buttonStyle),
    expect: () => [const ButtonStyleState(style: buttonStyle)],
  );

  blocTest<TestButtonStyleCubit, ButtonStyleState>(
    'emit null style',
    build: () => sut,
    act: (cubit) => cubit.styleChanged(null),
    expect: () => [const ButtonStyleState(style: null)],
  );

  blocTest<TestButtonStyleCubit, ButtonStyleState>(
    'emit foreground default color',
    build: () => sut,
    act: (cubit) => cubit.foregroundDefaultColorChanged(color),
    verify: (cubit) {
      final props = {
        null: color,
        MaterialState.disabled: colorScheme.onSurface.withOpacity(0.38),
      };

      verifyMaterialPropertyByMap(
        cubit.state.style!.foregroundColor!,
        props,
      );
    },
  );

  blocTest<TestButtonStyleCubit, ButtonStyleState>(
    'emit foreground disabled color',
    build: () => sut,
    act: (cubit) => cubit.foregroundDisabledColorChanged(color),
    verify: (cubit) {
      final props = {
        null: colorScheme.onPrimary,
        MaterialState.disabled: color,
      };

      verifyMaterialPropertyByMap(
        cubit.state.style!.foregroundColor!,
        props,
      );
    },
  );

  blocTest<TestButtonStyleCubit, ButtonStyleState>(
    'emit overlay hovered color',
    build: () => sut,
    act: (cubit) => cubit.overlayHoveredColorChanged(color),
    verify: (cubit) {
      final props = {
        MaterialState.hovered: color,
        MaterialState.focused: colorScheme.onPrimary.withOpacity(0.24),
        MaterialState.pressed: colorScheme.onPrimary.withOpacity(0.24),
      };

      verifyMaterialPropertyByMap(
        cubit.state.style!.overlayColor!,
        props,
      );
    },
  );

  blocTest<TestButtonStyleCubit, ButtonStyleState>(
    'emit overlay focused color',
    build: () => sut,
    act: (cubit) => cubit.overlayFocusedColorChanged(color),
    verify: (cubit) {
      final props = {
        MaterialState.hovered: colorScheme.onPrimary.withOpacity(0.08),
        MaterialState.focused: color,
        MaterialState.pressed: colorScheme.onPrimary.withOpacity(0.24),
      };

      verifyMaterialPropertyByMap(
        cubit.state.style!.overlayColor!,
        props,
      );
    },
  );

  blocTest<TestButtonStyleCubit, ButtonStyleState>(
    'emit elevated button overlay pressed color',
    build: () => sut,
    act: (cubit) => cubit.overlayPressedColorChanged(color),
    verify: (cubit) {
      final props = {
        MaterialState.hovered: colorScheme.onPrimary.withOpacity(0.08),
        MaterialState.focused: colorScheme.onPrimary.withOpacity(0.24),
        MaterialState.pressed: color,
      };

      verifyMaterialPropertyByMap(
        cubit.state.style!.overlayColor!,
        props,
      );
    },
  );

  blocTest<TestButtonStyleCubit, ButtonStyleState>(
    'emit elevated button shadow color',
    build: () => sut,
    act: (cubit) => cubit.shadowColorChanged(color),
    verify: (cubit) {
      final props = {null: color};

      verifyMaterialPropertyByMap(
        cubit.state.style!.shadowColor!,
        props,
      );
    },
  );
}
