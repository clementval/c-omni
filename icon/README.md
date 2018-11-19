# ICON full parsing tests
The script in this directory helps to perform a full parsing on the ICON
code using the OMNI Compiler embedded in the CLAW FORTRAN Compiler.

## How to run the test
The test is designed to be executed from the root directory of this repository.

Without any option, the test will execute the following actions:
1) Fetch and compile the CLAW FORTRAN Compiler.
2) Fetch the code of ICON (need read access).
3) Generate a dependencies list of the ICON code.
4) Parse each file using the CLAW FORTRAN Compiler.
5) Control all the resulting files and report any issues.

```bash
./icon/parse
```

All the work is performed in a `<repo-root>/build` directory.

#### Skip the CLAW FORTRAN Compiler step
It is possible to run the test only from the step 2 with the following command:
```bash
./icon/parse -s
```

#### Skip the parsing step
It is possible to skip the parsing step the test only from the step 5 with the following command:
```bash
./icon/parse -p
```

## Currently known issues

**Bugs**
* ~~`Failed to import module with GENERIC type-bound procedure`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED [PR#237](https://github.com/omni-compiler/omni-compiler/pull/237)
  * Issue on OMNI Compiler repository: [omni-compiler:#234](https://github.com/omni-compiler/omni-compiler/issues/234)
* ~~`TARGET attribute compatibility with INTENT`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED [PR#233](https://github.com/omni-compiler/omni-compiler/pull/233)
  * Issue on OMNI Compiler repository: [omni-compiler:#232](https://github.com/omni-compiler/omni-compiler/issues/232)
* ~~`Type declaration doesn't accept ABSTRACT and PUBLIC attribute specifier`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED [PR#231](https://github.com/omni-compiler/omni-compiler/pull/231)
  * Issue on OMNI Compiler repository: [omni-compiler:#230](https://github.com/omni-compiler/omni-compiler/issues/230)
* ~~`Declaration doesn't accept BIND name`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MRGED, ISSUE CLOSED [PR#229](https://github.com/omni-compiler/omni-compiler/pull/229)
  * Issue on OMNI Compiler repository: [omni-compiler:#228](https://github.com/omni-compiler/omni-compiler/issues/228)
* ~~`Declaration of procedure pointer fails`~~
  * Type: Missing feature
  * Priority: medium
  * Status: ISSUE RESOLVED AND CLOSED
  * Issue on OMNI Compiler repository: [omni-compiler:#227](https://github.com/omni-compiler/omni-compiler/issues/227)
* ~~`BIND attribute fails compatibility with some other ATTRIBUTE`~~
  * Type: Bug
  * Priority: medium
  * Status: PR MERGED, ISSUE CLOSED [PR#226](https://github.com/omni-compiler/omni-compiler/pull/226)
  * Issue on OMNI Compiler repository: [omni-compiler:#225](https://github.com/omni-compiler/omni-compiler/issues/225)
* ~~`Cannot find procedure subroutine defined later in the translation unit`~~
  * Type: Bug
  * Priority: medium
  * Status: PRE MERGED, ISSUE CLOSED [PR#532](https://github.com/omni-compiler/omni-compiler/pull/532)
  * Issue on OMNI Compiler repository: [omni-compiler:#531](https://github.com/omni-compiler/omni-compiler/issues/531)
