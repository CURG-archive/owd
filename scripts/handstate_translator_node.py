#!/usr/bin/env python

import roslib
import rospy
import geometry_msgs.msg

import pr_msgs.msg
import sensor_msgs.msg


class handstate_translator:
	def __init__(self): 
		rospy.init_node('handstate_translator_node', anonymous=True)
		self.pub = rospy.Publisher('/joint_state', sensor_msgs.msg.JointState)

		rospy.Subscriber("/bhd/handstate", pr_msgs.msg.BHState, self.handle_handstate_message)
		rospy.spin()

	def handle_handstate_message(self, req):
		header = req.header
		position = req.positions
		#velocity and effort are also needed eventually...
		
		joint_state_message = sensor_msgs.msg.JointState()
		joint_state_message.header = req.header
		joint_state_message.position = position

		self.pub.publish(joint_state_message)

if __name__ == '__main__':
	handstate_translator()