# Add a testing executable
add_executable(unit_tests
    unit_tests.cpp
)

target_link_libraries(unit_tests
    example_google_test
    GTest::gtest_main
)

include(GoogleTest)
add_test(UNIT_TEST unit_tests)
