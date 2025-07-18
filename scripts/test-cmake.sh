#!/usr/bin/env bash
mkdir cmake-consumer
cd cmake-consumer

cat <<EOT > CMakeLists.txt
cmake_minimum_required(VERSION 3.18)
project(testing LANGUAGES CXX)
find_package(manifold "3.2.0" REQUIRED)
add_executable(testing test.cpp)
target_link_libraries(testing PRIVATE manifold::manifold)
EOT

cat <<EOT > test.cpp
#include <manifold/manifold.h>
#include <manifold/version.h>

#if MANIFOLD_VERSION < MANIFOLD_VERSION_NUMBER(3, 2, 0)
# error "Unexpected: minimum version number not available"
#endif

int main() { manifold::Manifold foo; return 0; }
EOT

mkdir build
cd build
cmake ..
make
./testing
