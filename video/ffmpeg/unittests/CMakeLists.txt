# test #

add_subdirectory(cmake)

set(_artifact_path "${CMAKE_CURRENT_BINARY_DIR}/artifact/")
set(_artifact_inc_path "${_artifact_path}/include/")
set(_artifact_bin_path "${_artifact_path}/bin/")

file(GLOB _header_list "${PROJECT_SOURCE_DIR}/include/pollux/*.h")
foreach(file ${_header_list})
    file(COPY ${file} DESTINATION ${_artifact_inc_path}/pollux)
endforeach()

file(GLOB _test_video "${CMAKE_CURRENT_SOURCE_DIR}/input*.*")
foreach(file ${_test_video})
    file(COPY ${file} DESTINATION ${_artifact_bin_path})
endforeach()

set(_src_dir "${CMAKE_CURRENT_SOURCE_DIR}/src")
file(GLOB _src_list "${_src_dir}/*.cpp" "${_src_dir}/*.c")

foreach(file ${_src_list})
    get_filename_component(file_name ${file} NAME_WE)
    set(_target_name "pollux_${file_name}")

    add_executable(${_target_name} ${file})
    set_target_properties(
        ${_target_name} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${_artifact_bin_path}
    )

    target_include_directories(${_target_name} PRIVATE ${_artifact_inc_path}/pollux)

    target_link_directories(${_target_name} PRIVATE ${USER_TEST_FFMPEG_LIB_DIR})
    target_link_directories(${_target_name} PRIVATE ${USER_TEST_SIRIUS_LIB_DIR})
    target_link_directories(${_target_name} PRIVATE ${TARGET_LIB_DIR})

    target_link_libraries(${_target_name} pollux)
    target_link_libraries(${_target_name} sirius)
    target_link_libraries(
        ${_target_name}
        avformat avcodec avutil swresample swscale
    )
    if (${USER_TEST_INSTRUCTION} MATCHES x86)
        target_link_libraries(
            ${_target_name}
            va z lzma bz2 drm X11 va-drm va-x11
        )
    endif()
    target_link_libraries(${_target_name} pthread m dl)
    
    if (${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang" OR
        ${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
        if (${USER_TEST_PIE_ENABLE})
            target_compile_options(${_target_name} PRIVATE -fPIE)
            target_link_options(${_target_name} PRIVATE -pie)
        else()
            target_link_options(${_target_name} PRIVATE -no-pie)
        endif()
    endif()

    add_test(
        NAME ${_target_name}
        COMMAND ./${_target_name}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/artifact/bin/
    )
endforeach()
