# OMNI Compiler FORTRAN Parsing Tests

[![Build Status](https://travis-ci.org/claw-project/omni-parse-tests.svg?branch=master)](https://travis-ci.org/claw-project/omni-parse-tests)

Test repository to parse complex code with the OMNI Compiler FORTRAN front-end
and report bugs or missing features. The scripts use the CLAW Compiler without
transformation.

## How to parse large code base with the FORTRAN front-end of OMNI Compiler

### About OMNI Compiler
OMNI Compiler is a set of programs and libraries to build source-to-source
compilers for C and FORTRAN via an XcodeML high-level intermediate
representation. In our case, we are interested to see if our code base can be
entirely parse by the compiler.

#### Module file
Any FORTRAN compiler is producing and using module files in order to process
the dependencies between them. OMNI Compiler is also using this mechanism and
its module file have the `.xmod` extension.

### Parsing your code
All files passed through the OMNI Compiler must have been preprocessed before.
To ease this process, it is easier to use the OMNI Compiler driver such as
`xmpf90` or the CLAW FORTRAN Compiler driver `clawfc`.

#### Internal dependencies
The code base must be parsed according to the dependencies between the modules.

With the two modules below, we have to process `mod2` before `mod1` as it
depends on it.

```fortran
MODULE mod1
  USE mod2
END MODULE mod1
```

```fortran
MODULE mod2
END MODULE mod2
```

Using the `clawfc` driver, it could look like the following commands:
```bash
clawfc -J xmod_files --force -o parsed/mod2.f90 mod2.f90
clawfc -J xmod_files --force -o parsed/mod1.f90 mod1.f90
```

The `-J <dir>` option defined where the `.xmod` file will be placed/searched.
The `--force` option force the parsing/tranformation using the CLAW FORTRAN
Compiler.
In this example, the first command will parse `mod2.f90` and produce a new
version of it as well as a `.xmod` file. The second command will read the
`.xmod` file, parse the `mod1.f90` and produce a new version of it.


#### External dependencies
For external dependency, please refer to the CLAW Compiler repository.


#### Specific tests
For each specific test, the user needs appropriate access to the private
repository of each model.


##### COSMO parsing test
To run the COSMO parsing test, execute the following command:

```bash
./cosmo/parse
```
For more information, see the COSMO full parsing test
[README](./cosmo/README.md).

##### ICON parsing test
To run the ICON parsing test, execute the following command:

```bash
./icon/parse
```
For more information, see the ICON full parsing test
[README](./icon/README.md).

##### IFS parsing test
To run the IFS parsing test, execute the following command:

```bash
./ifs/parse
```
For more information, see the IFS full parsing test
[README](./ifs/README.md).
