# Find Valgrind.
#
#
# Imported targets defined by this module (use these):
#  Valgrind::valgrind - the valgrind executable
#  Valgrind::headers  - include directories (link to this target if you include valgrind/memcheck.h, etc.)
#
#
# Legacy variable defines (don't use these, use imported targets instead):
#  VALGRIND_INCLUDE_DIRS, where to find valgrind/memcheck.h, etc.
#  VALGRIND_PROGRAM, the valgrind executable.
#  VALGRIND_FOUND, If false, do not try to use valgrind.
#
#
# If you have valgrind installed in a non-standard place, you can define
# Valgrind_DIR to tell cmake where it is.

# Find paths, set legacy variable names.
find_path(VALGRIND_INCLUDE_DIRS
	NAMES         memcheck.h
	PATH_SUFFIXES valgrind
	PATHS         "${Valgrind_DIR}"
	              "$ENV{Valgrind_DIR}"
	              "${VALGRIND_PREFIX}"
	              /usr
	              /usr/local
)
mark_as_advanced(FORCE VALGRIND_INCLUDE_DIRS)

find_program(VALGRIND_PROGRAM
	NAMES valgrind
	PATHS "${Valgrind_DIR}/bin"
	      "$ENV{Valgrind_DIR}/bin"
	      "${VALGRIND_PREFIX}/bin"
	      /usr/bin
	      /usr/local/bin
)
mark_as_advanced(FORCE VALGRIND_PROGRAM)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(VALGRIND DEFAULT_MSG
	VALGRIND_INCLUDE_DIRS
	VALGRIND_PROGRAM
)

# Create import libraries.
if (NOT TARGET Valgrind::valgrind AND VALGRIND_FOUND AND VALGRIND_PROGRAM)
	add_executable(Valgrind::valgrind IMPORTED)
	set_target_properties(Valgrind::valgrind PROPERTIES
		IMPORTED_LOCATION "${VALGRIND_PROGRAM}"
	)
endif ()

if (NOT TARGET Valgrind::headers AND VALGRIND_FOUND AND VALGRIND_INCLUDE_DIRS)
	add_library(Valgrind::headers INTERFACE IMPORTED)
	set_target_properties(Valgrind::valgrind PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES "${VALGRIND_INCLUDE_DIRS}"
	)
endif ()
