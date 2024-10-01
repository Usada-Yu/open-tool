cmake_minimum_required(VERSION 3.13)

project(
    PROJECT-POLLUX
    VERSION "1.0.0"
    DESCRIPTION "pollux"
    LANGUAGES "C" "CXX"
)

if (WIN32)
    if (DEFINED ENV{USERNAME})
        set(USERNAME $ENV{USERNAME})
    endif()
else()
    if (DEFINED ENV{USER})
        set(USERNAME $ENV{USER})
    endif()
endif()

# target path
set(TARGET_DIR ${PROJECT_BINARY_DIR}/artifact/)
set(TARGET_LIB_DIR ${TARGET_DIR}/lib)

add_subdirectory(cmake)

option(USER_TEST_ENABLE "test enable" OFF)
if (USER_TEST_ENABLE)
    enable_testing()
    add_subdirectory(unittests)
endif()
