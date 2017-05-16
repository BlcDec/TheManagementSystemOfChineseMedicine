package com.imudges.web.manager_medicine_system.util;


import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Properties;

public class ConfigWriter {

    static String profilepath="config.properties";

    private Properties props = new Properties();
    public ConfigWriter() {
        try {
            props.load(this.getClass().getResourceAsStream("/config.properties"));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            System.exit(-1);
        } catch (IOException e) {
            System.exit(-1);
        }
    }

    public void writeProperties(String keyname,String keyvalue) {
        try {
            OutputStream fos = new FileOutputStream(profilepath);
            props.setProperty(keyname, keyvalue);
            props.store(fos, "Update '" + keyname + "' value");
        } catch (IOException e) {

        }
    }
}