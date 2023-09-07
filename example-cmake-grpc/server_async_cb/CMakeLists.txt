#
# Dependencies
#
find_package(Threads)

#
# Sources
#
set(SOURCES
    src/main.cpp
)

source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SOURCES})


#
# Target
#
add_executable(server_async_cb ${SOURCES})
target_link_libraries(server_async_cb
    PRIVATE
        myproto
)
