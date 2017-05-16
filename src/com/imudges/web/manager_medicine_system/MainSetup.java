package com.imudges.web.manager_medicine_system;

/**
 * Created by yangyang on 2017/4/23.
 */
import com.imudges.web.manager_medicine_system.bean.User;
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

        User user = new User();
        user.setUsername("test");
        user.setPassword("123");
        dao.insert(user);
    }
}