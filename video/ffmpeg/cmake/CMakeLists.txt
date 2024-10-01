include(${CMAKE_CURRENT_SOURCE_DIR}/external_option.cmake)

set(TARGET_NAME ${USER_POLLUX_NAME})

include(${CMAKE_CURRENT_SOURCE_DIR}/internal_option.cmake)

install(TARGETS ${TARGET_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

install (DIRECTORY ${PROJECT_SOURCE_DIR}/include/pollux/
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include
    FILES_MATCHING PATTERN "*.h"
    PATTERN "internal" EXCLUDE
)
