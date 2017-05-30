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
./icon/parse.icon.sh
```

All the work is performed in a `<repo-root>/build` directory.

#### Skip the CLAW FORTRAN Compiler step
It is possible to run the test only from the step 2 with the following command:
```bash
./cosmo/parse.icon.sh -s
```

#### Skip the parsing step
It is possible to skip the parsing step the test only from the step 5 with the following command:
```bash
./cosmo/parse.icon.sh -p
```

## Currently known issues
Example
* `information about the error`
  * Type: Bug|Waring
  * Priority: high|medium|low
  * Status: OPEN|FIXED|CLOSED
  * Issue on OMNI Compiler repository: [link to issue](https://github.com/omni-compiler/omni-compiler)
