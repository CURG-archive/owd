FILE(REMOVE_RECURSE
  "../srv_gen"
  "../srv_gen"
  "../src/owd/srv"
  "CMakeFiles/ROSBUILD_gensrv_cpp"
  "../srv_gen/cpp/include/owd/SetGains.h"
  "../srv_gen/cpp/include/owd/StepJoint.h"
  "../srv_gen/cpp/include/owd/CalibrateJoints.h"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/ROSBUILD_gensrv_cpp.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
