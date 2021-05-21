import serial

TestString = b'FF'
port = serial.Serial('/dev/ttyUSB1', 9600 )
port.timeout = 0.5
port.write(TestString)
port.flush()
response = port.read(10)
port.close()

