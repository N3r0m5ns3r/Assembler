#include <string>

#include "Assembler/Assembler.hpp"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("Name is Assembler", "[library]")
{
  auto const exported = exported_class {};
  REQUIRE(std::string("Assembler") == exported.name());
}
