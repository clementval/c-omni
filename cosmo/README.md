# COSMO full parsing tests
The script in this directory helps to perform a full parsing on the COSMO-POMPA
code using the OMNI Compiler embedded in the CLAW FORTRAN Compiler.

## How to run the test
The test is designed to be executed from the root directory of this repository.

Without any option, the test will execute the following actions:
1) Fetch and compile the CLAW FORTRAN Compiler.
2) Fetch the code of COSMO-POMPA (need read access).
3) Generate a dependencies list of the COSMO-POMPA code.
4) Parse each file using the CLAW FORTRAN Compiler.
5) Control all the resulting files and report any issues.

```bash
./cosmo/parse
```

All the work is performed in a `<repo-root>/build` directory.

#### Skip the CLAW FORTRAN Compiler step
It is possible to run the test only from the step 2 with the following command:
```bash
./cosmo/parse -s
```

#### Skip the parsing step
It is possible to skip the parsing step the test only from the step 2 with the following command:
```bash
./cosmo/parse -p
```

#### Test with NetCDF enabled
```bash
./cosmo/parse -n
```

## Known issues
Fixed bugs are strikethrough.

**Bugs**
* ~~`bad constant expression in PARAMETER statement`~~
  * Type: Bug
  * Priority: high
  * Status: FIXED, ISSUE CLOSED
  * Issue on OMNI Compiler repository: [omni-compiler:#131](https://github.com/omni-compiler/omni-compiler/issues/131)
* ~~`length specification must be positive`~~
  * Type: Bug
  * Priority: high
  * Status: PR MERGED, ISSUE CLOSED ([PR#145](https://github.com/omni-compiler/omni-compiler/pull/145))
  * Issue on OMNI Compiler repository: [omni-compiler:#138](https://github.com/omni-compiler/omni-compiler/issues/138)
* ~~`argument(s) mismatch for an intrinsic 'ishftc()'`~~
  * Type: Bug
  * Priority: high
  * Status: FIXED, ISSUE CLOSED
  * Issue on OMNI Compiler repository: [omni-compiler:#139](https://github.com/omni-compiler/omni-compiler/issues/139)
* ~~`only function/subroutine statement are allowed in contains top level`~~
  * Type: Bug
  * Priority: high
  * Status: PR MERGED, ISSUE CLOSED ([PR#149](https://github.com/omni-compiler/omni-compiler/pull/149))
  * Issue on OMNI Compiler repository: [omni-compiler:#142](https://github.com/omni-compiler/omni-compiler/issues/142)
* ~~`unknown node/failed to import module`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED ([PR#150](https://github.com/omni-compiler/omni-compiler/pull/150))
  * Issue on OMNI Compiler repository: [omni-compiler#31](https://github.com/omni-compiler/omni-compiler/issues/31)
* ~~`not allowed statement in the FORALL construct`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED ([PR#166](https://github.com/omni-compiler/omni-compiler/pull/166))
  * Issue on OMNI Compiler repository: [omni-compiler#164](https://github.com/omni-compiler/omni-compiler/issues/164)
* ~~`argument(s) mismatch for an intrinsic 'reshape()'`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED ([PR#189](https://github.com/omni-compiler/omni-compiler/pull/189))
  * Issue on OMNI Compiler repository: [omni-compiler#167](https://github.com/omni-compiler/omni-compiler/issues/167)
* ~~`incompatible dimension for the operation`~~
  * Type: Bug
  * Priority: high
  * Status: PR MERGED, ISSUE CLOSED ([PR#169](https://github.com/omni-compiler/omni-compiler/pull/169))
  * Issue on OMNI Compiler repository: [omni-compiler#168](https://github.com/omni-compiler/omni-compiler/issues/168)
* ~~`failed to import module 'ieee_arithmetic'`~~
  * Type: Bug
  * Priority: High
  * Status: PR MERGED, ISSUE CLOSED ([PR#180](https://github.com/omni-compiler/omni-compiler/pull/180))
  * Issue on OMNI Compiler repository: None (missing feature)
* ~~`declaration among executables` (DATA statement)~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED ([PR#196](https://github.com/omni-compiler/omni-compiler/pull/196))
  * Issue on OMNI Compiler repository: [omni-compiler#190](https://github.com/omni-compiler/omni-compiler/issues/190)
* ~~`syntax error` (function name with fortran keyword)~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED ([PR#195](https://github.com/omni-compiler/omni-compiler/pull/195))
  * Issue on OMNI Compiler repository: [omni-compiler#191](https://github.com/omni-compiler/omni-compiler/issues/191)
* ~~`syntax error/parameter value not specified, un-terminated Hollerith constant`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED ([PR#193](https://github.com/omni-compiler/omni-compiler/pull/193))
  * Issue on OMNI Compiler repository: [omni-compiler#192](https://github.com/omni-compiler/omni-compiler/issues/191)
* ~~`warning: array has allocatable`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED ([PR#203](https://github.com/omni-compiler/omni-compiler/pull/203))
  * Issue on OMNI Compiler repository: [omni-compiler#202](https://github.com/omni-compiler/omni-compiler/issues/202)
* ~~`is not found for`~~
  * Type: Bug
  * Priority: medium
  * Status: ISSUE CLOSED via dae5374388ee8c8842e3a16ee3b7acc64658aa31
  * Issue on OMNI Compiler repository: [omni-compiler#204](https://github.com/omni-compiler/omni-compiler/issues/204)
* ~~`if-where syntax error`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED  ([PR#206](https://github.com/omni-compiler/omni-compiler/pull/206))
  * Issue on OMNI Compiler repository: [omni-compiler#205](https://github.com/omni-compiler/omni-compiler/issues/205)
* ~~`Attempt to use undefined type variable`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED ([PR#210](https://github.com/omni-compiler/omni-compiler/pull/210))
  * Issue on OMNI Compiler repository: [omni-compiler#207](https://github.com/omni-compiler/omni-compiler/issues/207)
* ~~`Invalid left operand for '%'`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED  ([PR#212](https://github.com/omni-compiler/omni-compiler/pull/212))
  * Issue on OMNI Compiler repository: [omni-compiler#208](https://github.com/omni-compiler/omni-compiler/issues/208)
* `only function/subroutine statement are allowed in contains top level` (Pragma in top-level)
  * Type: Bug
  * Priority: medium
  * Status: OPEN
  * Issue on OMNI Compiler repository: [omni-compiler#213](https://github.com/omni-compiler/omni-compiler/issues/213)
* ~~`syntax error` (Function suffix)~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED  ([PR#215](https://github.com/omni-compiler/omni-compiler/pull/215))
  * Issue on OMNI Compiler repository: [omni-compiler#214](https://github.com/omni-compiler/omni-compiler/issues/214)
* ~~`bad char &(0x26)`~~ (lexer mess up with ! and &)
  * Type: Bug
  * Priority: high
  * Status: PR MERGED, ISSUE CLOSED ([PR#254](https://github.com/omni-compiler/omni-compiler/pull/254))
  * Issue on OMNI Compiler repository: [omni-compiler#253](https://github.com/omni-compiler/omni-compiler/issues/253)
* ~~`identifier 'selected_real_kind' is used as a function`~~
  * Type: Bug
  * Priority: high
  * Status: PR MERGED, ISSUE CLOSED ([PR#257](https://github.com/omni-compiler/omni-compiler/pull/257))
  * Issue on OMNI Compiler repository: [omni-compiler#255](https://github.com/omni-compiler/omni-compiler/issues/255)
* `varDecl from external module in interface declaration`
  * Type: Bug
  * Priority: high
  * Status: PR WAITING TO BE MERGED, ISSUE OPEN ([PR#275](https://github.com/omni-compiler/omni-compiler/pull/275))
  * Issue on OMNI Compiler repository: [omni-compiler#274](https://github.com/omni-compiler/omni-compiler/issues/274)
* `TYPE name from external module is not reachable in decompiler`
  * Type: Bug
  * Priority: high
  * Status: PR MERGED, ISSUE CLOSE ([PR#281](https://github.com/omni-compiler/omni-compiler/pull/281))
  * Issue on OMNI Compiler repository: [omni-compiler#276](https://github.com/omni-compiler/omni-compiler/issues/276)
* `Reference type of 'function definition' is defined as 'FbasicType', but it must be 'FfunctionType'`
  * Type: Bug
  * Priority: high
  * Status: PR WAITING TO BE MERGED, ISSUE OPEN ([PR#280](https://github.com/omni-compiler/omni-compiler/pull/280))
  * Issue on OMNI Compiler repository: [omni-compiler#279](https://github.com/omni-compiler/omni-compiler/issues/279)

**Warnings**
* `can't determine a function to be actually called for a generic interface function call`
  * Type: Warning
  * Priority: low
  * Status: OPEN
  * Issue on OMNI Compiler repository: [omni-compiler:#143](https://github.com/omni-compiler/omni-compiler/issues/143)
* `implicitly declared and used, should be declared explicitly as a parameter`
  * Type: Warning
  * Priority: low
  * Status: OPEN
  * Issue on OMNI Compiler repository: [omni-compiler:#144](https://github.com/omni-compiler/omni-compiler/issues/144)
