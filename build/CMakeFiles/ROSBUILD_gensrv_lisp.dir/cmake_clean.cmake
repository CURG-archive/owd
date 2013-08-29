FILE(REMOVE_RECURSE
  "../srv_gen"
  "../srv_gen"
  "../src/owd/srv"
  "CMakeFiles/ROSBUILD_gensrv_lisp"
  "../srv_gen/lisp/SetGains.lisp"
  "../srv_gen/lisp/_package.lisp"
  "../srv_gen/lisp/_package_SetGains.lisp"
  "../srv_gen/lisp/StepJoint.lisp"
  "../srv_gen/lisp/_package.lisp"
  "../srv_gen/lisp/_package_StepJoint.lisp"
  "../srv_gen/lisp/CalibrateJoints.lisp"
  "../srv_gen/lisp/_package.lisp"
  "../srv_gen/lisp/_package_CalibrateJoints.lisp"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/ROSBUILD_gensrv_lisp.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
