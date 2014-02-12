cmake_minimum_required(VERSION 2.4.6)
# set (ROS_BUILD_STATIC_LIBS true)
# include($ENV{ROS_ROOT}/core/rosbuild/rosbuild.cmake)
include(../find_xenomai.cmake)
include(../detect_cpu.cmake)

#set (CANBUS_TYPE "ESD")
set (CANBUS_TYPE "PEAK")

if (CANBUS_TYPE STREQUAL "ESD")
message(STATUS "using ESD CANbus driver")
set (CANBUS_DEFS "-DESD_CAN -I../../esdcan-pci200/lib32")
set (CANBUS_LIBS "ntcan")
set (CANBUS_LDFLAGS "-L../../esdcan-pci200/lib32")

elseif (CANBUS_TYPE  STREQUAL "PEAK")
message(STATUS "using PEAK CANbus driver")
set (CANBUS_DEFS "-DPEAK_CAN")
set (CANBUS_LIBS "pcan")

else (CANBUS_TYPE STREQUAL "ESD")
message(SEND_ERROR "No CANbus type recognized")
set (CANBUS_DEFS "")
set (CANBUS_LIBS "")
endif (CANBUS_TYPE STREQUAL "ESD")

# add_subdirectory(positionInterface)
# link_directories (positionInterface)

if (DEFINED ENV{OWD_MARCH_FLAGS})
    message(STATUS "Using mtune flags set in environment: $ENV{OWD_MARCH_FLAGS}")
    add_definitions( "$ENV{OWD_MARCH_FLAGS}" )
elseif (VENDOR_ID STREQUAL "GenuineIntel" AND CPU_FAMILY EQUAL 6 AND MODEL EQUAL 28)
    message(STATUS "Building for Intel Atom")
    add_definitions("-march=core2 -mtune=native -mmmx -msse2 -msse3 -mfpmath=sse")
elseif (VENDOR_ID STREQUAL "CentaurHauls")
    message(STATUS "Building for VIA - Original Barrett WAM PC")
    add_definitions("-march=c3-2")
endif (DEFINED ENV{OWD_MARCH_FLAGS})

add_definitions("-O0 -ggdb3 -DWRIST -DBH8 -DRT_STATS")

add_library(openwam Joint.cc Motor.cc Puck.cc Group.cc
  Sigmoid.cc Kinematics.cc Dynamics.cc
  TrajType.cc PulseTraj.cc Trajectory.cc ParabolicSegment.cc
  ParaJointTraj.cc MacJointTraj.cc MacQuinticBlend.cc MacQuinticSegment.cc
  ServoTraj.cc StepTraj.cc ConstrainedForceTrajectory.cc butterworth_solver.c)

add_dependencies(openwam ${catkin_EXPORTED_TARGETS})
if(BUILD_SIM)
  add_library(openwamsim Joint.cc CANbus_sim.cc Motor.cc Puck.cc Group.cc
    ControlLoop.cc Sigmoid.cc WAM.cc Kinematics.cc Dynamics.cc
    TrajType.cc PulseTraj.cc Trajectory.cc ParabolicSegment.cc
    ParaJointTraj.cc MacJointTraj.cc MacQuinticBlend.cc MacQuinticSegment.cc
    ServoTraj.cc StepTraj.cc ConstrainedForceTrajectory.cc
    Plugin.cc butterworth_solver.c)
  set_target_properties(openwamsim PROPERTIES COMPILE_FLAGS "-DOWDSIM")
endif(BUILD_SIM)

if(BUILD_OWD)
  add_library(wamcan ControlLoop.cc CANbus.cc WAM.cc Plugin.cc)
  set_target_properties(wamcan PROPERTIES COMPILE_FLAGS "${CANBUS_DEFS}")
  set_target_properties(wamcan PROPERTIES LINK_FLAGS "${CANBUS_LDFLAGS}")
  add_dependencies(wamcan ${catkin_EXPORTED_TARGETS})
endif(BUILD_OWD)


if(BUILD_BHD)
  add_library(bhdcan ControlLoop.cc CANbus.cc WAM.cc Plugin.cc)
  set_target_properties(bhdcan PROPERTIES COMPILE_FLAGS "${CANBUS_DEFS} -DBH280_ONLY")
  set_target_properties(bhdcan PROPERTIES LINK_FLAGS "${CANBUS_LDFLAGS}")
  add_dependencies(bhdcan ${catkin_EXPORTED_TARGETS})
endif(BUILD_BHD)


if (RT_BUILD)

	add_library(wamcanrt ControlLoop.cc CANbus.cc WAM.cc Plugin.cc)
	target_link_libraries(wamcanrt ${catkin_LIBRARIES})
	set_target_properties(wamcanrt PROPERTIES COMPILE_FLAGS "${CANBUS_DEFS} ${RT_DEFS}")
	set_target_properties(wamcanrt PROPERTIES LINK_FLAGS "${CANBUS_LIBS} ${RT_LIBS}")

	add_library(bhdcanrt ControlLoop.cc CANbus.cc WAM.cc Plugin.cc)
	target_link_libraries(bhdcanrt ${catkin_LIBRARIES})
	set_target_properties(bhdcanrt PROPERTIES COMPILE_FLAGS "${CANBUS_DEFS} ${RT_DEFS} -DBH280_ONLY")
	set_target_properties(bhdcanrt PROPERTIES LINK_FLAGS "${CANBUS_LIBS} ${RT_LIBS}")

endif (RT_BUILD)

include_directories (../openmath)
