cmake_minimum_required(VERSION 2.8.3)
project(owd)
set(CMAKE_VERBOSE_MAKEFILE ON)
## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED  geometry_msgs pr_msgs std_msgs sensor_msgs actionlib_msgs message_generation roscpp tf)

## System dependencies are found with CMake's conventions
# find_package(Boost REQUIRED COMPONENTS system)


if(RT_BUILD)
include(find_xenomai.cmake)
endif(RT_BUILD)

set(BUILD_BHD 1)
set(BUILD_OWD 0)
set(BUILD_TOOLS 0)
set(BUILD_SIM 0)

#set (CANBUS_TYPE "ESD")
set (CANBUS_TYPE "PEAK")


add_subdirectory(openwam)
add_subdirectory(openmath)

include_directories (openwam openmath ${catkin_INCLUDE_DIRS} srv)

add_definitions("-O0 -ggdb3 -DWRIST -DBH8")

if (CANBUS_TYPE STREQUAL "ESD")
message(STATUS "using ESD CANbus driver")
set (CANBUS_DEFS "-DESD_CAN -I../esdcan-pci200/lib32")
set (CANBUS_LIBS "ntcan")
set (CANBUS_LDFLAGS "-L../esdcan-pci200/lib32")
elseif (CANBUS_TYPE  STREQUAL "PEAK")
message(STATUS "using PEAK CANbus driver")
set (CANBUS_DEFS "-DPEAK_CAN")
set (CANBUS_LIBS "pcan")
else (CANBUS_TYPE STREQUAL "ESD")
message(SEND_ERROR "No CANbus type recognized")
set (CANBUS_DEFS "")
set (CANBUS_LIBS "")
endif (CANBUS_TYPE STREQUAL "ESD")

include(detect_cpu.cmake)

if (DEFINED ENV{OWD_MARCH_FLAGS})
    message(STATUS "Using mtune flags set in environment: $ENV{OWD_MARCH_FLAGS}")
    add_definitions( "$ENV{OWD_MARCH_FLAGS}" )
elseif (VENDOR_ID STREQUAL "GenuineIntel" AND CPU_FAMILY EQUAL 6 AND MODEL EQUAL 28)
    message(STATUS "Building for Intel Atom")
    add_definitions("-march=core2 -mtune=native -mmmx -msse2 -msse3 -mfpmath=sse")
elseif (VENDOR_ID STREQUAL "CentaurHauls")
    message(STATUS "Building for VIA - Original Barrett WAM PC")
    add_definitions("-march=c3-2")
endif  (DEFINED ENV{OWD_MARCH_FLAGS})


## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/api/catkin/html/user_guide/setup_dot_py.html
# catkin_python_setup()

################################################
## Declare ROS messages, services and actions ##
################################################

## To declare and build messages, services or actions from within this
## package, follow these steps:
## * Let MSG_DEP_SET be the set of packages whose message types you use in
##   your messages/services/actions (e.g. std_msgs, actionlib_msgs, ...).
## * In the file package.xml:
##   * add a build_depend and a run_depend tag for each package in MSG_DEP_SET
##   * If MSG_DEP_SET isn't empty the following dependencies might have been
##     pulled in transitively but can be declared for certainty nonetheless:
##     * add a build_depend tag for "message_generation"
##     * add a run_depend tag for "message_runtime"
## * In this file (CMakeLists.txt):
##   * add "message_generation" and every package in MSG_DEP_SET to
##     find_package(catkin REQUIRED COMPONENTS ...)
##   * add "message_runtime" and every package in MSG_DEP_SET to
##     catkin_package(CATKIN_DEPENDS ...)
##   * uncomment the add_*_files sections below as needed
##     and list every .msg/.srv/.action file to be processed
##   * uncomment the generate_messages entry below
##   * add every package in MSG_DEP_SET to generate_messages(DEPENDENCIES ...)

## Generate messages in the 'msg' folder
# add_message_files(
#   FILES
#   Message1.msg
#   Message2.msg
# )

## Generate services in the 'srv' folder
 add_service_files(
   FILES
   CalibrateJoints.srv
   SetGains.srv
   StepJoint.srv
 )

## Generate actions in the 'action' folder
# add_action_files(
#   FILES
#   Action1.action
#   Action2.action
# )

## Generate added messages and services with any dependencies listed here
 generate_messages(
   DEPENDENCIES
   std_msgs
   geometry_msgs
   pr_msgs
 )

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if you package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES test
  CATKIN_DEPENDS message_runtime
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(include ${catkin_INCLUDE_DIRS})

## Declare a cpp library
# add_library(test
#   src/${PROJECT_NAME}/test.cpp
# )

## Declare a cpp executable
# add_executable(test_node src/test_node.cpp)

## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
# add_dependencies(test_node test_generate_messages_cpp)

## Specify libraries to link a library or executable target against
# target_link_libraries(test_node
#   ${catkin_LIBRARIES}
# )

#Enable this for WAM arm
if(BUILD_OWD)
  add_executable(owd owd.cpp openwamdriver.cpp bhd280.cc ft.cc tactile.cc)
  target_link_libraries(owd wamcan openwam openmath lapack blas gfortran ${CANBUS_LIBS} ${catkin_LIBRARIES})
  set_target_properties(owd PROPERTIES COMPILE_FLAGS "${CANBUS_DEFS}")
  set_target_properties(owd PROPERTIES LINK_FLAGS "${CANBUS_LDFLAGS}")
  add_dependencies(owd ${catkin_EXPORTED_TARGETS})
endif(BUILD_OWD)


#Enable this for Barret Hand only
if(BUILD_BHD)
  add_executable(canbhd owd.cpp openwamdriver.cpp bhd280.cc ft.cc tactile.cc)
  target_link_libraries(canbhd bhdcan openwam openmath lapack blas gfortran ${CANBUS_LIBS}  ${catkin_LIBRARIES})
  set_target_properties(canbhd PROPERTIES COMPILE_FLAGS "-DBH280 -DBH280_ONLY ${CANBUS_DEFS}")
  set_target_properties(canbhd PROPERTIES LINK_FLAGS "${CANBUS_LDFLAGS}")
endif(BUILD_BHD)

#These utilities are not used in the current stack
if(BUILD_SIM)
  add_executable(owdsim owd.cpp openwamdriver.cpp)
  target_link_libraries(owdsim openwamsim openmath lapack blas gfortran  ${catkin_LIBRARIES})
  set_target_properties(owdsim PROPERTIES COMPILE_FLAGS "-DOWDSIM")
endif(BUILD_SIM)

if(BUILD_TOOLS)
  add_executable(owd_test test.cpp)
  target_link_libraries(owd_test ${catkin_LIBRARIES})

  add_executable(puck_update puck_update.cpp)
  target_link_libraries(puck_update wamcan openwam ${CANBUS_LIBS}  ${catkin_LIBRARIES})
  set_target_properties(puck_update PROPERTIES COMPILE_FLAGS "${CANBUS_DEFS}")
  set_target_properties(puck_update PROPERTIES LINK_FLAGS "${CANBUS_LDFLAGS}")

  add_executable(puck_defaults puck_defaults.cpp)
  target_link_libraries(puck_defaults wamcan openwam ${CANBUS_LIBS}  ${catkin_LIBRARIES})
  set_target_properties(puck_defaults PROPERTIES COMPILE_FLAGS "${CANBUS_DEFS}")
  set_target_properties(puck_defaults PROPERTIES LINK_FLAGS "${CANBUS_LDFLAGS}")

  add_executable(puck_getprops puck_getprops.cpp)
  target_link_libraries(puck_getprops wamcan openwam ${CANBUS_LIBS}  ${catkin_LIBRARIES})
  set_target_properties(puck_getprops PROPERTIES COMPILE_FLAGS "${CANBUS_DEFS}")
  set_target_properties(puck_getprops PROPERTIES LINK_FLAGS "${CANBUS_LDFLAGS}")

  add_executable(puck_find_mofst puck_find_mofst.cpp)
  target_link_libraries(puck_find_mofst ${CANBUS_LIBS}  ${catkin_LIBRARIES})
  set_target_properties(puck_find_mofst PROPERTIES COMPILE_FLAGS "${CANBUS_DEFS}")
  set_target_properties(puck_find_mofst PROPERTIES LINK_FLAGS "${CANBUS_LDFLAGS}")
endif(BUILD_TOOLS)

if (RT_BUILD)

	add_executable(owdrt owd.cpp openwamdriver.cpp bhd280.cc ft.cc tactile.cc)
  	target_link_libraries(owdrt wamcanrt openwam openmath lapack blas gfortran ${CANBUS_LIBS} ${RT_LIBS}  ${catkin_LIBRARIES})
  	set_target_properties(owdrt PROPERTIES COMPILE_FLAGS "${CANBUS_DEFS} ${RT_DEFS}")
  	set_target_properties(owdrt PROPERTIES LINK_FLAGS "${CANBUS_LDFLAGS}")

  	add_executable(canbhdrt owd.cpp openwamdriver.cpp bhd280.cc ft.cc tactile.cc)
  	target_link_libraries(canbhdrt bhdcanrt openwam openmath lapack blas gfortran ${CANBUS_LIBS} ${RT_LIBS}  ${catkin_LIBRARIES})
  	set_target_properties(canbhdrt PROPERTIES COMPILE_FLAGS "-DBH280 -DBH280_ONLY ${CANBUS_DEFS} ${RT_DEFS}")
  	set_target_properties(canbhdrt PROPERTIES LINK_FLAGS "${CANBUS_LDFLAGS}")

endif (RT_BUILD)

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
# install(TARGETS test test_node
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_test.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)















