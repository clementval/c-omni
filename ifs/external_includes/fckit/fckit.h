#if 0
(C) Copyright 2013 ECMWF.

This software is licensed under the terms of the Apache Licence Version 2.0
which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
In applying this licence, ECMWF does not waive the privileges and immunities
granted to it by virtue of its status as an intergovernmental organisation nor
does it submit to any jurisdiction.
#endif

#ifndef FCKIT_H
#define FCKIT_H

#define FCKIT_GIT_SHA1      "f24ca8f91572ea240588216749f545c3a9afa1ff"
#define FCKIT_VERSION       "0.5.1"

#define FCKIT_HAVE_ECKIT                           1
#define FCKIT_HAVE_FINAL                           1
#define FCKIT_FINAL_FUNCTION_RESULT                0
#define FCKIT_FINAL_UNINITIALIZED_LOCAL            0
#define FCKIT_FINAL_UNINITIALIZED_INTENT_OUT       1
#define FCKIT_FINAL_UNINITIALIZED_INTENT_INOUT     0
#define FCKIT_FINAL_NOT_PROPAGATING                0
#define FCKIT_FINAL_NOT_INHERITING                 0
#define FCKIT_FINAL_BROKEN_FOR_ALLOCATABLE_ARRAY   1
#define FCKIT_FINAL_BROKEN_FOR_AUTOMATIC_ARRAY     1

#define FCKIT_FINAL_DEBUGGING 0

#define FCKIT_SUPPRESS_UNUSED( X ) \
associate( unused_ => X ); \
end associate

#endif
