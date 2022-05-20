package dev.asolidtime;

import java.io.*;
import java.net.Socket;

public class RequestProcessor implements Runnable {
    Socket clientSocket;
    Main mainClass;
    int requestNum;
    @Override
    public void run() {
        InputStream input = null;
        try {
            input = clientSocket.getInputStream();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        BufferedReader reader = new BufferedReader(new InputStreamReader(input));
        PrintStream printStream = null;
        try {
            printStream = new PrintStream(clientSocket.getOutputStream());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        String fullRequest = null;
        try {
            fullRequest = reader.readLine();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        try {
            String request = fullRequest.split(" ")[1];
            //System.out.println("full request:\n" + fullRequest + "\nthat's the request.");
            String[] narrowed = request.split("\\/"); // haha, double escape!
            //System.out.println(narrowed[1]);
            if (narrowed[1].startsWith("getPos")) {
                //System.out.println("get position unimplemented");
                printStream.println(mainClass.rotationStepperPosition + "," + mainClass.directionStepperPosition);
            } else if (narrowed[1].startsWith("fire")) {
                if (narrowed[1].equals("fireWithAim")) {
                    System.out.println("fire with aim unimplemented");
                } else if (narrowed[1].equals("fire")) {
                    System.out.println("fire unimplemented");
                }
            } else {
                float rotation = Float.parseFloat(narrowed[3]) * 5;
                float angle = Float.parseFloat(narrowed[2]) * 7; // little less for this one
                mainClass.rotationStepperPosition = (int) rotation;
                mainClass.directionStepperPosition = (int) angle;
                //System.out.println("rot " + rotation + " ang " + angle);
            }
            clientSocket.getOutputStream().write(200);
            clientSocket.close();
            //System.out.println("request #" + requestNum + " finished");
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println(fullRequest);
        }
    }
    public RequestProcessor(Socket clientSocket, int requestNum, Main mainClass) {
        this.clientSocket = clientSocket;
        this.mainClass = mainClass;
        this.requestNum = requestNum;
    }
}
