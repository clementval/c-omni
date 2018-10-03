# Known compilation issues after OMNI Compiler processing

Issues reported here will be removed when they are fixed in the OMNI Compiler
master branch.

#### #52 Undefined function used as argument might disappear
This issues is reported at omni-compiler/xcodeml-tools#52
* Files impacted:
  * `src/shared/mo_zaxis_type.f90`
  * `src/shared/mo_storage.f90`

Fix available: [PR#93](https://github.com/omni-compiler/xcodeml-tools/pull/93)

#### #66 Duplicated PUBLIC :: <id> statement
This issues is reported at omni-compiler/xcodeml-tools#66
* Files impacted:
  * `src/io/shared/mo_read_netcdf_broadcast_2.f90`
  * `jsbach/mo_sse_interface_dsl4jsb.f90` (seems to be the same problem
    duplicated `PRIVATE :: create_task_soil_temperature`)
