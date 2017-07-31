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
./cosmo/parse.cosmo.sh
```

All the work is performed in a `<repo-root>/build` directory.

#### Skip the CLAW FORTRAN Compiler step
It is possible to run the test only from the step 2 with the following command:
```bash
./cosmo/parse.cosmo.sh -s
```

#### Skip the parsing step
It is possible to skip the parsing step the test only from the step 2 with the following command:
```bash
./cosmo/parse.cosmo.sh -p
```

## Currently known issues
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
