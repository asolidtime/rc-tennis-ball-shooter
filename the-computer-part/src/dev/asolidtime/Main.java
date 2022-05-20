package dev.asolidtime;


import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public class Main {
    public int rotationStepperPosition = 0;
    public int directionStepperPosition = 0;
    public int numRequests = 0;
    public static void main(String[] args) {
        Main mainWindow = new Main();
        mainWindow.run();
    }
    public void run() {
        ServerSocket serverSocket;
        try {
            serverSocket = new ServerSocket(8040);
            while(true) {
                Socket clientSocket = serverSocket.accept();
                numRequests++;
                //System.out.println("request #" + numRequests + " started");
                new Thread(new RequestProcessor(clientSocket, numRequests, this)).start();
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }
}
