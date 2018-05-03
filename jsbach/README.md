# JSBACH full parsing tests
The script in this directory helps to perform a full parsing on the JSBACH
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
./jsbach/parse
```

All the work is performed in a `<repo-root>/build` directory.

#### Skip the CLAW FORTRAN Compiler step
It is possible to run the test only from the step 2 with the following command:
```bash
./jsbach/parse -s
```

#### Skip the parsing step
It is possible to skip the parsing step the test only from the step 2 with the following command:
```bash
./jsbach/parse -p
```

## Known issues
Fixed bugs are strikethrough.

TODO Check weird behavior of OMNI when __SX__ is not used on src/atm_phy_echam/mo_echam_convect_tables.f90 in icon-eniac

**Bugs**
Any bugs found during parsing tests that should be/has been addressed.

**Warnings**
  Any warning found during parsing tests that should be/has been addressed.
