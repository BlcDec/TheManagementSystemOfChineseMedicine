package com.imudges.web.manager_medicine_system.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigReader {


    public  String read(String param){
        Properties properties = new Properties();
        InputStream in = this.getClass().getResourceAsStream("/config.properties");

        try {
            properties.load(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return properties.getProperty(param, "null");
    }

    public int readInt(String param){
        Properties properties = new Properties();
        InputStream in =  this.getClass().getResourceAsStream("/config.properties");
        try {
            properties.load(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            return Integer.parseInt(properties.getProperty(param, "null"));
        } catch (Exception e) {

            return -1;
        }

    }
}