#!/usr/bin/env python

import roslib
import rospy
import geometry_msgs.msg

import pr_msgs.msg
import sensor_msgs.msg


class HandStateTranslator:

    def __init__(self):
        rospy.init_node('handstate_translator_node', anonymous=True)
        self.joint_name_prefix = rospy.get_param('barrett_joint_name_prefix', 'wam/bhand/')
        finger_joints = []

        finger_joints += ['finger_1/prox_joint', 'finger_1/med_joint', 'finger_1/dist_joint']
        finger_joints += ['finger_2/prox_joint', 'finger_2/med_joint', 'finger_2/dist_joint']
        finger_joints += ['finger_3/med_joint', 'finger_3/dist_joint']

        finger_joints = [self.joint_name_prefix + finger_joint for finger_joint in finger_joints]
        print finger_joints
        self.finger_joint_dict = dict()

        for finger_joint in finger_joints:
            self.finger_joint_dict[finger_joint] = float('NaN')

        self.pub = rospy.Publisher('joint_states', sensor_msgs.msg.JointState)

        rospy.Subscriber("/bhd/handstate", pr_msgs.msg.BHState, self.handle_handstate_message)




    def handle_handstate_message(self, msg):

        #velocity and effort are also needed eventually...
        joint_state_message = sensor_msgs.msg.JointState()

        #fill finger_joint_dict
        self.finger_joint_dict[self.joint_name_prefix + 'finger_1/prox_joint'] = msg.positions[3]
        self.finger_joint_dict[self.joint_name_prefix + 'finger_2/prox_joint'] = msg.positions[3]

        self.finger_joint_dict[self.joint_name_prefix + 'finger_1/med_joint'] = msg.positions[0]
        self.finger_joint_dict[self.joint_name_prefix + 'finger_2/med_joint'] = msg.positions[1]
        self.finger_joint_dict[self.joint_name_prefix + 'finger_3/med_joint'] = msg.positions[2]

        self.finger_joint_dict[self.joint_name_prefix + 'finger_1/dist_joint'] = msg.positions[0]/3.0
        self.finger_joint_dict[self.joint_name_prefix + 'finger_2/dist_joint'] = msg.positions[1]/3.0
        self.finger_joint_dict[self.joint_name_prefix + 'finger_3/dist_joint'] = msg.positions[2]/3.0

        joint_state_message.header = msg.header
        joint_state_message.name = self.finger_joint_dict.keys()
        joint_state_message.position = self.finger_joint_dict.values()
        self.pub.publish(joint_state_message)

if __name__ == '__main__':
    HandStateTranslator()
    rospy.spin()