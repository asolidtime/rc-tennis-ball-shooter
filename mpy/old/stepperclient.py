def getValuesFromServer():
    import socket
    addr = socket.getaddrinfo("192.168.7.151", 8040)[0][-1]
    s = socket.socket()
    s.connect(addr)
    s.send("GET /getPos/ HTTP/1.1\n")
    data = s.recv(100)
    s.close()
    rotation = str(data[:-2]).split("'")[1].split(",")[0]
    angle = str(data[:-2]).split("'")[1].split(",")[1]
    return rotation, angle
