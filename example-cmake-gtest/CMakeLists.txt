cmake_minimum_required(VERSION 3.9)
project(my_project)

# GoogleTest requires at least C++14
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)
Set(FETCHCONTENT_QUIET FALSE)
FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG        v1.14.0
        GIT_PROGRESS   TRUE
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

FetchContent_Declare(
        protobuf
        GIT_REPOSITORY https://github.com/protocolbuffers/protobuf.git
        GIT_TAG        v24.2
        SOURCE_SUBDIR  cmake
        GIT_PROGRESS   TRUE
)

#fix https://github.com/protocolbuffers/protobuf/issues/12185
set(ABSL_ENABLE_INSTALL ON)
FetchContent_Declare(
        grpc
        GIT_REPOSITORY https://github.com/grpc/grpc.git
        GIT_TAG        v1.58.0
        GIT_PROGRESS   TRUE
)

FetchContent_MakeAvailable(googletest protobuf grpc)

include(CTest)

include_directories(include)
add_subdirectory(src)
add_subdirectory(test)
