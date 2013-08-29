# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Produce verbose output by default.
VERBOSE = 1

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/armuser/ros/owd

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/armuser/ros/owd

# Include any dependencies generated for this target.
include openmath/CMakeFiles/openmath.dir/depend.make

# Include the progress variables for this target.
include openmath/CMakeFiles/openmath.dir/progress.make

# Include the compile flags for this target's objects.
include openmath/CMakeFiles/openmath.dir/flags.make

openmath/CMakeFiles/openmath.dir/Inertia.o: openmath/CMakeFiles/openmath.dir/flags.make
openmath/CMakeFiles/openmath.dir/Inertia.o: openmath/Inertia.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/armuser/ros/owd/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object openmath/CMakeFiles/openmath.dir/Inertia.o"
	cd /home/armuser/ros/owd/openmath && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/openmath.dir/Inertia.o -c /home/armuser/ros/owd/openmath/Inertia.cc

openmath/CMakeFiles/openmath.dir/Inertia.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/openmath.dir/Inertia.i"
	cd /home/armuser/ros/owd/openmath && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/armuser/ros/owd/openmath/Inertia.cc > CMakeFiles/openmath.dir/Inertia.i

openmath/CMakeFiles/openmath.dir/Inertia.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/openmath.dir/Inertia.s"
	cd /home/armuser/ros/owd/openmath && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/armuser/ros/owd/openmath/Inertia.cc -o CMakeFiles/openmath.dir/Inertia.s

openmath/CMakeFiles/openmath.dir/Inertia.o.requires:
.PHONY : openmath/CMakeFiles/openmath.dir/Inertia.o.requires

openmath/CMakeFiles/openmath.dir/Inertia.o.provides: openmath/CMakeFiles/openmath.dir/Inertia.o.requires
	$(MAKE) -f openmath/CMakeFiles/openmath.dir/build.make openmath/CMakeFiles/openmath.dir/Inertia.o.provides.build
.PHONY : openmath/CMakeFiles/openmath.dir/Inertia.o.provides

openmath/CMakeFiles/openmath.dir/Inertia.o.provides.build: openmath/CMakeFiles/openmath.dir/Inertia.o

openmath/CMakeFiles/openmath.dir/SE3.o: openmath/CMakeFiles/openmath.dir/flags.make
openmath/CMakeFiles/openmath.dir/SE3.o: openmath/SE3.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/armuser/ros/owd/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object openmath/CMakeFiles/openmath.dir/SE3.o"
	cd /home/armuser/ros/owd/openmath && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/openmath.dir/SE3.o -c /home/armuser/ros/owd/openmath/SE3.cc

openmath/CMakeFiles/openmath.dir/SE3.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/openmath.dir/SE3.i"
	cd /home/armuser/ros/owd/openmath && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/armuser/ros/owd/openmath/SE3.cc > CMakeFiles/openmath.dir/SE3.i

openmath/CMakeFiles/openmath.dir/SE3.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/openmath.dir/SE3.s"
	cd /home/armuser/ros/owd/openmath && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/armuser/ros/owd/openmath/SE3.cc -o CMakeFiles/openmath.dir/SE3.s

openmath/CMakeFiles/openmath.dir/SE3.o.requires:
.PHONY : openmath/CMakeFiles/openmath.dir/SE3.o.requires

openmath/CMakeFiles/openmath.dir/SE3.o.provides: openmath/CMakeFiles/openmath.dir/SE3.o.requires
	$(MAKE) -f openmath/CMakeFiles/openmath.dir/build.make openmath/CMakeFiles/openmath.dir/SE3.o.provides.build
.PHONY : openmath/CMakeFiles/openmath.dir/SE3.o.provides

openmath/CMakeFiles/openmath.dir/SE3.o.provides.build: openmath/CMakeFiles/openmath.dir/SE3.o

openmath/CMakeFiles/openmath.dir/SO3.o: openmath/CMakeFiles/openmath.dir/flags.make
openmath/CMakeFiles/openmath.dir/SO3.o: openmath/SO3.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/armuser/ros/owd/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object openmath/CMakeFiles/openmath.dir/SO3.o"
	cd /home/armuser/ros/owd/openmath && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/openmath.dir/SO3.o -c /home/armuser/ros/owd/openmath/SO3.cc

openmath/CMakeFiles/openmath.dir/SO3.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/openmath.dir/SO3.i"
	cd /home/armuser/ros/owd/openmath && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/armuser/ros/owd/openmath/SO3.cc > CMakeFiles/openmath.dir/SO3.i

openmath/CMakeFiles/openmath.dir/SO3.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/openmath.dir/SO3.s"
	cd /home/armuser/ros/owd/openmath && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/armuser/ros/owd/openmath/SO3.cc -o CMakeFiles/openmath.dir/SO3.s

openmath/CMakeFiles/openmath.dir/SO3.o.requires:
.PHONY : openmath/CMakeFiles/openmath.dir/SO3.o.requires

openmath/CMakeFiles/openmath.dir/SO3.o.provides: openmath/CMakeFiles/openmath.dir/SO3.o.requires
	$(MAKE) -f openmath/CMakeFiles/openmath.dir/build.make openmath/CMakeFiles/openmath.dir/SO3.o.provides.build
.PHONY : openmath/CMakeFiles/openmath.dir/SO3.o.provides

openmath/CMakeFiles/openmath.dir/SO3.o.provides.build: openmath/CMakeFiles/openmath.dir/SO3.o

# Object files for target openmath
openmath_OBJECTS = \
"CMakeFiles/openmath.dir/Inertia.o" \
"CMakeFiles/openmath.dir/SE3.o" \
"CMakeFiles/openmath.dir/SO3.o"

# External object files for target openmath
openmath_EXTERNAL_OBJECTS =

lib/libopenmath.a: openmath/CMakeFiles/openmath.dir/Inertia.o
lib/libopenmath.a: openmath/CMakeFiles/openmath.dir/SE3.o
lib/libopenmath.a: openmath/CMakeFiles/openmath.dir/SO3.o
lib/libopenmath.a: openmath/CMakeFiles/openmath.dir/build.make
lib/libopenmath.a: openmath/CMakeFiles/openmath.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX static library ../lib/libopenmath.a"
	cd /home/armuser/ros/owd/openmath && $(CMAKE_COMMAND) -P CMakeFiles/openmath.dir/cmake_clean_target.cmake
	cd /home/armuser/ros/owd/openmath && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/openmath.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
openmath/CMakeFiles/openmath.dir/build: lib/libopenmath.a
.PHONY : openmath/CMakeFiles/openmath.dir/build

openmath/CMakeFiles/openmath.dir/requires: openmath/CMakeFiles/openmath.dir/Inertia.o.requires
openmath/CMakeFiles/openmath.dir/requires: openmath/CMakeFiles/openmath.dir/SE3.o.requires
openmath/CMakeFiles/openmath.dir/requires: openmath/CMakeFiles/openmath.dir/SO3.o.requires
.PHONY : openmath/CMakeFiles/openmath.dir/requires

openmath/CMakeFiles/openmath.dir/clean:
	cd /home/armuser/ros/owd/openmath && $(CMAKE_COMMAND) -P CMakeFiles/openmath.dir/cmake_clean.cmake
.PHONY : openmath/CMakeFiles/openmath.dir/clean

openmath/CMakeFiles/openmath.dir/depend:
	cd /home/armuser/ros/owd && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/armuser/ros/owd /home/armuser/ros/owd/openmath /home/armuser/ros/owd /home/armuser/ros/owd/openmath /home/armuser/ros/owd/openmath/CMakeFiles/openmath.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : openmath/CMakeFiles/openmath.dir/depend

