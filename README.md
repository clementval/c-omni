# OMNI Parsing tests
Test repository to parse complex code with the OMNI Compiler and report bugs or
missing features

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
TODO

## COSMO parsing test
To run the COSMO parsing test, execute the following command:

```bash
./cosmo/parse.cosmo.sh
```

For more information, see the COSMO full parsing test [README](./cosmo/README.md).
