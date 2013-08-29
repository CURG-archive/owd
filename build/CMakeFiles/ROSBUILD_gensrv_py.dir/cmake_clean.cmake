FILE(REMOVE_RECURSE
  "../srv_gen"
  "../srv_gen"
  "../src/owd/srv"
  "CMakeFiles/ROSBUILD_gensrv_py"
  "../src/owd/srv/__init__.py"
  "../src/owd/srv/_SetGains.py"
  "../src/owd/srv/_StepJoint.py"
  "../src/owd/srv/_CalibrateJoints.py"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/ROSBUILD_gensrv_py.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
