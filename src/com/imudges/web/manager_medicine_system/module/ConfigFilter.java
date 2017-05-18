package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.util.Toolkit;
import org.nutz.mvc.ActionContext;
import org.nutz.mvc.ActionFilter;
import org.nutz.mvc.View;

/**
 * 写入全局配置
 */
public class ConfigFilter implements ActionFilter {

    @Override
    public View match(ActionContext actionContext) {
        actionContext.getRequest().setAttribute("system_name", Toolkit.getSystemName());
        return null;
    }
}
