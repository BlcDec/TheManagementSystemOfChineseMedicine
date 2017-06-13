package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

/**
 * 病历
 * TODO 提交诊断书后生成。如果需要开药方，在付款之后继续向病历添加处方信息
 */
@Table("A_MEDICINEHISTORY")
public class MedicineHistory {
    @Id
    private int Id;


}
