# internal options

# source files
set(_src_dir ${PROJECT_SOURCE_DIR}/src)
aux_source_directory(${_src_dir} _src_list)
aux_source_directory(${_src_dir}/internal _src_list_internal)
list(APPEND _src_list ${_src_list_internal})

# result files
set(LIBRARY_OUTPUT_PATH ${TARGET_LIB_DIR})
if(BUILD_SHARED_LIBS)
    add_library(${TARGET_NAME} SHARED ${_src_list})
    target_compile_options(${TARGET_NAME} PUBLIC -fPIC -fPIE)
else()
    add_library(${TARGET_NAME} STATIC ${_src_list})
endif()

# compile options
target_compile_definitions(
    ${TARGET_NAME} PRIVATE -DLOG_MODULE_NAME="lib-pollux"
)
target_compile_definitions(
    ${TARGET_NAME} PRIVATE -DLOG_PRNT_BUF_SIZE=1024
)

# asan
if(USER_ASAN)
    target_compile_options(
        ${TARGET_NAME} PUBLIC
        -fsanitize=address -fno-omit-frame-pointer -fsanitize-recover=address
    )
    target_link_options(
        ${TARGET_NAME} PUBLIC -fsanitize=address
    )
endif()

# gcov
if(USER_GCOV)
    target_compile_options(${TARGET_NAME} PUBLIC --coverage)
    target_link_options(${TARGET_NAME} PUBLIC --coverage)
endif()

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(${TARGET_NAME} PRIVATE /W4 /WX)
else()
    target_compile_options(${TARGET_NAME} PRIVATE -Wall -Werror)
endif()

# header files
target_include_directories(
    ${TARGET_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/include/ffmpeg
)
target_include_directories(
    ${TARGET_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/include/pollux
)
target_include_directories(
    ${TARGET_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/include/sirius
)
