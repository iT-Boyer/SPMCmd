###  失败原因
使用SPM集成Quick和Nimble，出现编译错误，QuickObjCRuntime
```
Undefined symbols for architecture x86_64:
  "_OBJC_CLASS_$_XCTestCase", referenced from:
      _OBJC_CLASS_$__QuickSpecBase in QuickSpecBase.o
  "_OBJC_METACLASS_$_XCTestCase", referenced from:
      _OBJC_METACLASS_$__QuickSpecBase in QuickSpecBase.o
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)

```
