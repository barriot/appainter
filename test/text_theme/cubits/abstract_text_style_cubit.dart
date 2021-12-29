import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theme/common/common.dart';
import 'package:flutter_theme/models/models.dart';
import 'package:flutter_theme/services/services.dart';
import 'package:flutter_theme/text_theme/text_theme.dart';

import '../../utils.dart';

typedef CubitInitializer<T> = T Function();

class AbstractTextStyleCubitTest<T extends AbstractTextStyleCubit> {
  final CubitInitializer<T> initializer;
  final TextStyle style;

  AbstractTextStyleCubitTest({required this.initializer, required this.style});

  void runAllTests() {
    late T cubit;
    late Color color;
    late double doubleValue;

    setUp(() {
      cubit = initializer();
      color = getRandomColor();
      doubleValue = Random().nextDouble();
    });

    blocTest<T, TextStyleState>(
      'should emit style',
      build: () => cubit,
      act: (cubit) => cubit.styleChanged(style),
      expect: () => [TextStyleState(style: style)],
    );

    blocTest<T, TextStyleState>(
      'should emit color',
      build: () => cubit,
      act: (cubit) => cubit.colorChanged(color),
      expect: () => [TextStyleState(style: style.copyWith(color: color))],
    );

    blocTest<T, TextStyleState>(
      'should emit background color',
      build: () => cubit,
      act: (cubit) => cubit.backgroundColorChanged(color),
      expect: () => [
        TextStyleState(style: style.copyWith(backgroundColor: color)),
      ],
    );

    blocTest<T, TextStyleState>(
      'should emit font size',
      build: () => cubit,
      act: (cubit) => cubit.fontSizeChanged(doubleValue.toString()),
      expect: () => [
        TextStyleState(style: style.copyWith(fontSize: doubleValue)),
      ],
    );

    group('test font weights', () {
      for (var weight in MyFontWeight().values) {
        blocTest<T, TextStyleState>(
          'should emit $weight',
          build: () => cubit,
          act: (cubit) {
            cubit.fontWeightChanged(MyFontWeight().stringFromEnum(weight)!);
          },
          expect: () => [
            TextStyleState(style: style.copyWith(fontWeight: weight)),
          ],
        );
      }
    });

    group('test font styles', () {
      for (var fontStyle in FontStyle.values) {
        blocTest<T, TextStyleState>(
          'should emit $fontStyle',
          build: () => cubit,
          act: (cubit) {
            cubit.fontStyleChanged(UtilService.enumToString(fontStyle));
          },
          expect: () => [
            TextStyleState(style: style.copyWith(fontStyle: fontStyle)),
          ],
        );
      }
    });

    blocTest<T, TextStyleState>(
      'should emit letter spacing',
      build: () => cubit,
      act: (cubit) => cubit.letterSpacingChanged(doubleValue.toString()),
      expect: () => [
        TextStyleState(style: style.copyWith(letterSpacing: doubleValue)),
      ],
    );

    blocTest<T, TextStyleState>(
      'should emit word spacing',
      build: () => cubit,
      act: (cubit) => cubit.wordSpacingChanged(doubleValue.toString()),
      expect: () => [
        TextStyleState(style: style.copyWith(wordSpacing: doubleValue)),
      ],
    );

    group('test text baselines', () {
      for (var baseline in TextBaseline.values) {
        blocTest<T, TextStyleState>(
          'should emit $baseline',
          build: () => cubit,
          act: (cubit) {
            cubit.textBaselineChanged(UtilService.enumToString(baseline));
          },
          expect: () => [
            TextStyleState(style: style.copyWith(textBaseline: baseline)),
          ],
        );
      }
    });

    blocTest<T, TextStyleState>(
      'should emit height',
      build: () => cubit,
      act: (cubit) => cubit.heightChanged(doubleValue.toString()),
      expect: () => [
        TextStyleState(style: style.copyWith(height: doubleValue)),
      ],
    );

    group('test leading distributions', () {
      for (var dist in TextLeadingDistribution.values) {
        blocTest<T, TextStyleState>(
          'should emit $dist',
          build: () => cubit,
          act: (cubit) {
            cubit.leadingDistributionChanged(UtilService.enumToString(dist));
          },
          expect: () => [
            TextStyleState(style: style.copyWith(leadingDistribution: dist)),
          ],
        );
      }
    });

    group('test decorations', () {
      for (var decoration in MyTextDecoration().values) {
        blocTest<T, TextStyleState>(
          'should emit $decoration',
          build: () => cubit,
          act: (cubit) {
            cubit.decorationChanged(
              MyTextDecoration().stringFromEnum(decoration)!,
            );
          },
          expect: () => [
            TextStyleState(style: style.copyWith(decoration: decoration)),
          ],
        );
      }
    });

    blocTest<T, TextStyleState>(
      'should emit decoration color',
      build: () => cubit,
      act: (cubit) => cubit.decorationColorChanged(color),
      expect: () => [
        TextStyleState(style: style.copyWith(decorationColor: color)),
      ],
    );

    group('text decoration styles', () {
      blocTest<T, TextStyleState>(
        'should emit null',
        build: () => cubit,
        act: (cubit) => cubit.decorationStyleChanged(kNone),
        expect: () => [
          TextStyleState(style: style.copyWithNull(decorationStyle: true)),
        ],
      );

      for (var decorationStyle in TextDecorationStyle.values) {
        blocTest<T, TextStyleState>(
          'should emit $decorationStyle',
          build: () => cubit,
          act: (cubit) {
            cubit.decorationStyleChanged(
              UtilService.enumToString(decorationStyle),
            );
          },
          expect: () => [
            TextStyleState(
              style: style.copyWith(decorationStyle: decorationStyle),
            ),
          ],
        );
      }
    });

    blocTest<T, TextStyleState>(
      'should emit decoration thickness',
      build: () => cubit,
      act: (cubit) => cubit.decorationThicknessChanged(doubleValue.toString()),
      expect: () => [
        TextStyleState(style: style.copyWith(decorationThickness: doubleValue)),
      ],
    );
  }
}