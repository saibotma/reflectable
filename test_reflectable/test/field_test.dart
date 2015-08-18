// Copyright (c) 2015, the Dart Team. All rights reserved. Use of this
// source code is governed by a BSD-style license that can be found in
// the LICENSE file.

// File being transformed by the reflectable transformer.
// Accesses the types of instance fields and static fields.

library test_reflectable.test.field_test;

import 'package:reflectable/reflectable.dart';
import 'package:unittest/unittest.dart';

class FieldReflector extends Reflectable {
  const FieldReflector()
      : super(typeCapability, invokingCapability, declarationsCapability,
            metadataCapability);
}

const fieldReflector = const FieldReflector();

class NoFieldReflector extends Reflectable {
  const NoFieldReflector()
      : super(typeCapability, invokingCapability, metadataCapability);
}

const noFieldReflector = const NoFieldReflector();

@fieldReflector
@noFieldReflector
class A {
  int f1;
  final String f2 = "f2";
  static A f3;
  static final List f4 = <num>[1];
  static const f5 = "42!";
}

main() {
  ClassMirror classMirror = fieldReflector.reflectType(A);
  test("instance field properties", () {
    VariableMirror f1Mirror = classMirror.declarations["f1"];
    expect(f1Mirror.simpleName, "f1");
    expect(f1Mirror.qualifiedName, "test_reflectable.test.field_test.A.f1");
    expect(f1Mirror.owner, classMirror);
    expect(f1Mirror.isPrivate, isFalse);
    expect(f1Mirror.isTopLevel, isFalse);
    expect(f1Mirror.metadata, <Object>[]);
    expect(f1Mirror.isStatic, isFalse);
    expect(f1Mirror.isFinal, isFalse);
    expect(f1Mirror.isConst, isFalse);
    expect(f1Mirror.type.reflectedType, int);

    VariableMirror f2Mirror = classMirror.declarations["f2"];
    expect(f2Mirror.simpleName, "f2");
    expect(f2Mirror.qualifiedName, "test_reflectable.test.field_test.A.f2");
    expect(f2Mirror.owner, classMirror);
    expect(f2Mirror.isPrivate, isFalse);
    expect(f2Mirror.isTopLevel, isFalse);
    expect(f2Mirror.metadata, <Object>[]);
    expect(f2Mirror.isStatic, isFalse);
    expect(f2Mirror.isFinal, isTrue);
    expect(f2Mirror.isConst, isFalse);
    expect(f2Mirror.type.reflectedType, String);
  });

  test("static field properties", () {
    VariableMirror f3Mirror = classMirror.declarations["f3"];
    expect(f3Mirror.simpleName, "f3");
    expect(f3Mirror.qualifiedName, "test_reflectable.test.field_test.A.f3");
    expect(f3Mirror.owner, classMirror);
    expect(f3Mirror.isPrivate, isFalse);
    expect(f3Mirror.isTopLevel, isFalse);
    expect(f3Mirror.metadata, <Object>[]);
    expect(f3Mirror.isStatic, isTrue);
    expect(f3Mirror.isFinal, isFalse);
    expect(f3Mirror.isConst, isFalse);
    expect(f3Mirror.type.reflectedType, A);

    VariableMirror f4Mirror = classMirror.declarations["f4"];
    expect(f4Mirror.simpleName, "f4");
    expect(f4Mirror.qualifiedName, "test_reflectable.test.field_test.A.f4");
    expect(f4Mirror.owner, classMirror);
    expect(f4Mirror.isPrivate, isFalse);
    expect(f4Mirror.isTopLevel, isFalse);
    expect(f4Mirror.metadata, <Object>[]);
    expect(f4Mirror.isStatic, isTrue);
    expect(f4Mirror.isFinal, isTrue);
    expect(f4Mirror.isConst, isFalse);
    expect(f4Mirror.type.reflectedType, List);

    VariableMirror f5Mirror = classMirror.declarations["f5"];
    expect(f5Mirror.simpleName, "f5");
    expect(f5Mirror.qualifiedName, "test_reflectable.test.field_test.A.f5");
    expect(f5Mirror.owner, classMirror);
    expect(f5Mirror.isPrivate, isFalse);
    expect(f5Mirror.isTopLevel, isFalse);
    expect(f5Mirror.metadata, <Object>[]);
    expect(f5Mirror.isStatic, isTrue);
    expect(f5Mirror.isFinal, isTrue); // Yes, a const member `isFinal`, too.
    expect(f5Mirror.isConst, isTrue);
    expect(f5Mirror.type.reflectedType, dynamic);
  });

  test("no field capability", () {
    ClassMirror classMirror = noFieldReflector.reflectType(A);
    expect(() => classMirror.declarations,
        throwsA(const isInstanceOf<NoSuchCapabilityError>()));
  });
}