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

#### Internal dependencies

#### External dependencies



## COSMO parsing test
To run the COSMO parsing test, execute the following command:

```bash
./cosmo/parse.cosmo.sh
```

For more information, see the COSMO full parsing test [README](./cosmo/README.md).
