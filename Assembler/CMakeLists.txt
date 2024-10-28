cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    Assembler
    VERSION 0.1.0
    DESCRIPTION "Implementing my own Assembler"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    Assembler_Assembler
    source/Assembler.cpp
)
add_library(Assembler::Assembler ALIAS Assembler_Assembler)

include(GenerateExportHeader)
generate_export_header(
    Assembler_Assembler
    BASE_NAME Assembler
    EXPORT_FILE_NAME export/Assembler/Assembler_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(Assembler_Assembler PUBLIC ASSEMBLER_STATIC_DEFINE)
endif()

set_target_properties(
    Assembler_Assembler PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME Assembler
    OUTPUT_NAME Assembler
)

target_include_directories(
    Assembler_Assembler ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    Assembler_Assembler SYSTEM
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(Assembler_Assembler PUBLIC cxx_std_17)

find_package(fmt REQUIRED)
target_link_libraries(Assembler_Assembler PRIVATE fmt::fmt)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${Assembler_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT Assembler_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of Assembler"
  )
endif()

include(cmake/dev-mode.cmake)
