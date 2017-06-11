package com.imudges.web.manager_medicine_system.util;

import com.imudges.web.manager_medicine_system.bean.Doctor;
import org.nutz.lang.Lang;
import org.nutz.lang.random.R;
import org.nutz.lang.util.NutMap;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;


public class Toolkit {

    public static final Log log = Logs.get();

    public static String captcha_attr = "nutz_captcha";

    public static boolean checkCaptcha(String expected, String actual) {
        if (expected == null || actual == null || actual.length() == 0 || actual.length() > 24)
            return false;
        return actual.equalsIgnoreCase(expected);
    }

    public static String passwordEncode(String password, String slat) {
        String str = slat + password + slat;
        return Lang.digest("SHA-512", str);
    }

    private static final String Iv = "\0\0\0\0\0\0\0\0";
    private static final String Transformation = "DESede/CBC/PKCS5Padding";

    public static String _3DES_encode(byte[] key, byte[] data) {
        SecretKey deskey = new SecretKeySpec(key, "DESede");
        IvParameterSpec iv = new IvParameterSpec(Iv.getBytes());
        try {
            Cipher c1 = Cipher.getInstance(Transformation);
            c1.init(Cipher.ENCRYPT_MODE, deskey, iv);
            byte[] re = c1.doFinal(data);
            return Lang.fixedHexString(re);
        } catch (Exception e) {
            log.info("3DES FAIL?", e);
            e.printStackTrace();
        }
        return null;
    }

    public static String _3DES_decode(byte[] key, byte[] data) {
        SecretKey deskey = new SecretKeySpec(key, "DESede");
        IvParameterSpec iv = new IvParameterSpec(Iv.getBytes());
        try {
            Cipher c1 = Cipher.getInstance(Transformation);
            c1.init(Cipher.DECRYPT_MODE, deskey, iv);
            byte[] re = c1.doFinal(data);
            return new String(re);
        } catch (Exception e) {
            log.debug("BAD 3DES decode", e);
        }
        return null;
    }

    public static NutMap kv2map(String kv) {
        NutMap re = new NutMap();
        if (kv == null || kv.length() == 0 || !kv.contains("="))
            return re;
        String[] tmps = kv.split(",");
        for (String tmp : tmps) {
            if (!tmp.contains("="))
                continue;
            String[] tmps2 = tmp.split("=", 2);
            re.put(tmps2[0], tmps2[1]);
        }
        return re;
    }



//    public static String randomPasswd(User usr) {
//        String passwd = R.sg(10).next();
//        String slat = R.sg(48).next();
//        usr.setSalt(slat);
//        usr.setPassword(passwordEncode(passwd, slat));
//        return passwd;
//    }
//
//    public static void generatePasswd(User usr,String passwd) {
//        String slat = R.sg(48).next();
//        usr.setSalt(slat);
//        usr.setPassword(passwordEncode(passwd, slat));
//    }


    public static byte[] hexstr2bytearray(String str) {
        byte[] re = new byte[str.length() / 2];
        for (int i = 0; i < re.length; i++) {
            int r = Integer.parseInt(str.substring(i * 2, i * 2 + 2), 16);
            re[i] = (byte) r;
        }
        return re;
    }

    public static String getAccessKey(){
        String slat = R.sg(48).next();
        return Lang.digest("SHA-512", Lang.digest("SHA-512",System.currentTimeMillis() + slat) + slat).substring(32);
    }

    public static Map<String,Object> getSuccessResult(Map<String,Object>data){
        Map<String,Object>result = new HashMap<>();
        result.put("code","0");
        result.put("msg","ok");
        result.put("data",data);
        return result;
    }


    public static Map<String,Object>getFailResult(int code,Map<String,Object>data){
        Map<String,Object>result = new HashMap<>();
        result.put("code","" + code);
        result.put("msg",new ConfigReader().read("" + code));
        result.put("data",data);
        return result;
    }

    public static String getSystemName(){
        return new ConfigReader().read("system_name");
    }

    public static String getCurrentYMD(){
        String Year = Calendar.getInstance().get(Calendar.YEAR) + "";
        String Month = "";
        int monthNum = (Calendar.getInstance().get(Calendar.MONTH)+ 1);
        if(monthNum<10){
            Month = Month + "0" + monthNum;
        } else {
            Month = Month + monthNum;
        }
        String Day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH) + "";
        String res = Year + Month + Day;
        return res;
    }

    public static String getCurrentYear(){
        String Year = Calendar.getInstance().get(Calendar.YEAR) + "";
        return Year;
    }

    public static int getYear(String idCard){
        String year = "";
        for (int i = 6; i <= 9; i++) {
            year += idCard.charAt(i) + "";
        }
        return Integer.parseInt(Toolkit.getCurrentYear()) - Integer.parseInt(year);
    }

    public static int getSearchMedicinePage(){
        return new ConfigReader().readInt("search_page");
    }

    public static boolean isDigit(String strNum) {
        return strNum.matches("[0-9]{1,}");
    }

    public static String getDoctorUrl(Doctor doctor){
        String res = "";
        if(doctor == null){
            return null;
        } else {
            switch(doctor.getPosition()){
                case "0":
                    res = "windows.php";
                    break;
                case "1":
                    res = "diagnose.php";
                    break;
                case "2":
                    res = "collection.php";
                    break;
            }
        }
        return res;
    }

    public static String getAdminName(){
        return new ConfigReader().read("admin_name");
    }

    public static String getIdCardLastSixNum(String idCard){
        if(idCard == null || idCard.equals("") || idCard.length()!=18){
            return null;
        }
        String res = "";
        for (int i = 12; i <18; i++) {
            res += idCard.charAt(i) + "";
        }
        return res ;
    }
}