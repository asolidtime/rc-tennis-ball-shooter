import time
from machine import Pin
from AccelStepper import AccelStepper, FULL4WIRE
import socket

recheckinterval = 1000
#recheckinterval = 200
wrotation = 0
wangle = 0

IN1 = Pin(2, Pin.OUT)
IN2 = Pin(15, Pin.OUT)
IN3 = Pin(13, Pin.OUT)
IN4 = Pin(12, Pin.OUT)
IN5 = Pin(10, Pin.OUT)
IN6 = Pin(9, Pin.OUT)
IN7 = Pin(4, Pin.OUT)
IN8 = Pin(0, Pin.OUT)
get_status_led = Pin(26, Pin.OUT)
move_status_led = Pin(25, Pin.OUT)

angleStepper = AccelStepper(FULL4WIRE, IN1, IN2, IN3, IN4, False)
rotationStepper = AccelStepper(FULL4WIRE, IN5, IN6, IN7, IN8, False)
angleStepper.set_max_speed(750)
angleStepper.set_acceleration(1000)
rotationStepper.set_max_speed(100)
rotationStepper.set_acceleration(1000)

def getValuesFromServer():
    get_status_led.on()
    addr = socket.getaddrinfo("192.168.7.151", 8040)[0][-1]
    s = socket.socket()
    s.connect(addr)
    s.send("GET /getPos/ HTTP/1.1\n")
    data = s.recv(100)
    s.close()
    if data[-1:] == b'\xc8':
        rotation = str(data[:-2]).split("'")[1].split(",")[0]
        angle = str(data[:-2]).split("'")[1].split(",")[1]
        print(rotation + "," + angle)
        global wrotation
        global wangle
        wrotation = int(rotation)
        wangle = int(angle)
        get_status_led.off()

def stepBothSteppers():
    check1 = angleStepper.run()
    check2 = rotationStepper.run()
    return check1 or check2 # if I just do 'angleStepper.run() or rotationStepper.run(), rotationStepper.run() won't evaluate if angleStepper.run() returns true

def mainLoop():
    getValuesFromServer()
    angleStepper.move_to(wangle)
    rotationStepper.move_to(wrotation)
    move_status_led.on()
    start = time.ticks_ms()
    while stepBothSteppers():
        delta = time.ticks_diff(time.ticks_ms(), start)
        if delta > recheckinterval: # todo
            move_status_led.off()
            break
        pass

while True:
    mainLoop()
