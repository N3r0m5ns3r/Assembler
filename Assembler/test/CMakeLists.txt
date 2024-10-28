cmake_minimum_required(VERSION 3.14)

project(AssemblerTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(Assembler REQUIRED)
  enable_testing()
endif()

find_package(Catch2 REQUIRED)
include(Catch)

# ---- Tests ----

add_executable(Assembler_test source/Assembler_test.cpp)
target_link_libraries(
    Assembler_test PRIVATE
    Assembler::Assembler
    Catch2::Catch2WithMain
)
target_compile_features(Assembler_test PRIVATE cxx_std_17)

catch_discover_tests(Assembler_test)

# ---- End-of-file commands ----

add_folders(Test)
