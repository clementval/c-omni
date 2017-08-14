# IFS full parsing tests
The script in this directory helps to perform a full parsing on the IFS
code using the OMNI Compiler embedded in the CLAW FORTRAN Compiler.

## How to run the test
The test is designed to be executed from the root directory of this repository.

Without any option, the test will execute the following actions:
1) Fetch and compile the CLAW FORTRAN Compiler.
2) Fetch the code of IFS (need to provide a location with read access).
3) Generate a dependencies list of the IFS code.
4) Parse each file using the CLAW FORTRAN Compiler.
5) Control all the resulting files and report any issues.

```bash
./ifs/parse.ifs
```

All the work is performed in a `<repo-root>/build` directory.

#### Skip the CLAW FORTRAN Compiler step
It is possible to run the test only from the step 2 with the following command:
```bash
./ifs/parse.ifs -s
```

#### Skip the parsing step
It is possible to skip the parsing step the test only from the step 2 with the following command:
```bash
./ifs/parse.ifs -p
```

## Known issues
Fixed bugs are strikethrough.

**Bugs**
  Any bugs found during parsing tests that should be/has been addressed.
* ~~`Skeleton`~~
  * Type: Bug/Warning
  * Priority: high/medium/low
  * Status: OPEN/FIXED, ISSUE CLOSED/PR MERGED, ISSUE CLOSED
  * Issue on OMNI Compiler repository: [omni-compiler:#00](https://github.com/omni-compiler/omni-compiler/issues/00)

**Warnings**
  Any warning found during parsing tests that should be/has been addressed.