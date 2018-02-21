#!/usr/bin/env python

from gpiozero import LED, Button
from signal import pause
from time import sleep

button = Button(27)
led = LED(14)


def door_action_closed():
    print("The door has ben closed!")

def door_action_opened():
    print("The door has ben opened!")
    led.source = button.values

def door_status_open():
    print("The door is opened!")

def door_status_close():
    print("The door is closed!")

    
if button.value == 0:
    print("The door is opened!")
else:
    print("The door is closed!")

button.when_pressed = door_action_closed
button.when_released = door_action_opened

pause()
