var ioc = {
    dataSource : {
        type : "com.alibaba.druid.pool.DruidDataSource",
        events : {
            create : "init",
            depose : 'close'
        },
        fields : {
            // url : "jdbc:mysql://127.0.0.1:3306/chinese_medicine_manager_system?useUnicode=true&characterEncoding=UTF8",
            // url : "jdbc:oracle:thin:@localhost:1521:epsit",
            jdbcUrl : 'jdbc:oracle:thin:@127.0.0.1:8082:orcl',
            username : "scott",
            password : "jack",
            testWhileIdle : true,
            validationQuery : "select 1 from dual" ,
            maxActive : 100
        }
    },
    dao : {
        type : "org.nutz.dao.impl.NutDao",
        args : [{refer:"dataSource"}]
    }
};