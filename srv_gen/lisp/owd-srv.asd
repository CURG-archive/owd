
(cl:in-package :asdf)

(defsystem "owd-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :pr_msgs-msg
)
  :components ((:file "_package")
    (:file "SetGains" :depends-on ("_package_SetGains"))
    (:file "_package_SetGains" :depends-on ("_package"))
    (:file "StepJoint" :depends-on ("_package_StepJoint"))
    (:file "_package_StepJoint" :depends-on ("_package"))
    (:file "CalibrateJoints" :depends-on ("_package_CalibrateJoints"))
    (:file "_package_CalibrateJoints" :depends-on ("_package"))
  ))