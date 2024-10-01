set (
    USER_TEST_INSTRUCTION
    "x86" CACHE STRING "instruction set"
)

if (${USER_TEST_INSTRUCTION} MATCHES x86 OR
    ${USER_TEST_INSTRUCTION} MATCHES arm)
else()
    message(FATAL_ERROR "invalud instruction set")
endif()

set (
    USER_TEST_FFMPEG_LIB_DIR
    "/home/${USERNAME}/.local/x86/ffmpeg-7.1/lib/"
    CACHE STRING "ffmpeg library directory"
)

set (
    USER_TEST_SIRIUS_LIB_DIR
    "/home/${USERNAME}/.local/x86/user/sirius/lib/"
    CACHE STRING "sirius library directory"
)

option(USER_TEST_PIE_ENABLE "position independent" OFF)
