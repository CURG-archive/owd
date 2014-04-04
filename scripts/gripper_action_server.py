#! /usr/bin/env python

import roslib; roslib.load_manifest('owd')
import rospy

import control_msgs.msg 
import actionlib
import time
import numpy
from OWDUtil import *


class GripperActionServer(object):
    _feedback = control_msgs.msg.GripperCommandFeedback()
    _result = control_msgs.msg.GripperCommandResult()

    def __init__(self, action_topic_name = "gripper_action_server"):
        self._as = actionlib.SimpleActionServer(action_topic_name, control_msgs.msg.GripperCommandAction, self.newActionCallback, False)
        self._as.start()
        self.last_position = numpy.array([float('NaN'),float('NaN'),float('NaN'),float('NaN')])

    def is_moving(self, positions, delta=.01):
        current_position = numpy.array(positions)
        all_close = False
        if numpy.allclose(current_position, self.last_position, atol=delta):
            all_close = True
        self.last_position = current_position
        return all_close


    def newActionCallback(self, action_goal):
        goal_position = action_goal.goal.position

        try:
            msg = rospy.wait_for_message("/bhd/handstate", pr_msgs.msg.BHState, 5)
            if MoveHandSrv(1, [goal_position,goal_position,goal_position,msg.positions[3]]):
                whichmanip = 0
                timeout = 5.0 

                waittime = 0.25
                numiter = int(floor(timeout / waittime))
                for i in range( numiter ):
                    #check for preempt
                    if self._as.is_preempt_requested():
                        self._as.set_preempted()
                        break                    
                    time.sleep( waittime )
                    success, reason, positions = GetHandPose( whichmanip )
                    #rospy.loginfo( '  hand pose: %s' % ( array( positions ) ) )
                    
                    self._feedback.reached_goal = self.is_moving(positions)
                    self._feedback.stalled = self._feedback.reached_goal
                    self._feedback.position = numpy.mean(positions[:3])
                    self._feedback.effort = 0
                    self._as.publish_feedback(self._feedback)

                if self._feedback.reached_goal:                    
                    self._result.reached_goal = self._feedback.reached_goal
                    self._result.stalled = self._feedback.stalled
                    self._result.position = self._feedback.position
                    self._result.effort = 0

                    self._as.set_succeeded(self._result)

        except:
            pass


if __name__ == '__main__':
    rospy.init_node('gripper_action_server')
    gas = GripperActionServer()
    rospy.spin()