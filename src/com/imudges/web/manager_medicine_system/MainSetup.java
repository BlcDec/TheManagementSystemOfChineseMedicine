package com.imudges.web.manager_medicine_system;

/**
 * Created by yangyang on 2017/4/23.
 */
import org.nutz.dao.Dao;
import org.nutz.dao.util.Daos;
import org.nutz.ioc.Ioc;
import org.nutz.mvc.NutConfig;
import org.nutz.mvc.Setup;

import java.util.Date;

public class MainSetup implements Setup{
    public static Ioc ioc;
    @Override
    public void destroy(NutConfig arg0) {
    }

    @Override
    public void init(NutConfig conf) {
        MainSetup.ioc = conf.getIoc();
        Dao dao = ioc.get(Dao.class);
        Daos.createTablesInPackage(dao, "com.imudges.web.manager_medicine_system", false);

//        User test = new User();
//        test.setUsername("test");
//        Toolkit.generatePasswd(test,"123456");
//        test.setPrivilege(1);
//        test.setRegisterTime(new Date(System.currentTimeMillis()));
//        dao.insert(test);
    }
}