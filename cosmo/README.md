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
./cosmo/parse.cosmo.sh -s
```

## Currently known issues
* ~~`bad constant expression in PARAMETER statement`~~ (Status: FIXED): [omni-compiler:#131](https://github.com/omni-compiler/omni-compiler/issues/131)
* `length specification must be positive` (Status: OPEN):
[omni-compiler:#138](https://github.com/omni-compiler/omni-compiler/issues/138)
* `argument(s) mismatch for an intrinsic 'ishftc()'`: (Status: OPEN):
[omni-compiler:#139](https://github.com/omni-compiler/omni-compiler/issues/139)
* `only function/subroutine statement are allowed in contains top level` (Status: OPEN):
[omni-compiler:#142](https://github.com/omni-compiler/omni-compiler/issues/142)
