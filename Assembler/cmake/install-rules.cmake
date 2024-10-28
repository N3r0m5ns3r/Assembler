if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/Assembler-${PROJECT_VERSION}"
      CACHE STRING ""
  )
  set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package Assembler)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT Assembler_Development
)

install(
    TARGETS Assembler_Assembler
    EXPORT AssemblerTargets
    RUNTIME #
    COMPONENT Assembler_Runtime
    LIBRARY #
    COMPONENT Assembler_Runtime
    NAMELINK_COMPONENT Assembler_Development
    ARCHIVE #
    COMPONENT Assembler_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    Assembler_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE STRING "CMake package config location relative to the install prefix"
)
set_property(CACHE Assembler_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(Assembler_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${Assembler_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT Assembler_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${Assembler_INSTALL_CMAKEDIR}"
    COMPONENT Assembler_Development
)

install(
    EXPORT AssemblerTargets
    NAMESPACE Assembler::
    DESTINATION "${Assembler_INSTALL_CMAKEDIR}"
    COMPONENT Assembler_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
