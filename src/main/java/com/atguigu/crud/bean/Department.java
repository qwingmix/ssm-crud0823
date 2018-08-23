package com.atguigu.crud.bean;

public class Department {
    private Integer deptId;

    private String deptName;
    
    
    
      
    
    //�����޲ι�����
    public Department() {
		super();

	}
   //�����вι�������ͬʱҲҪcc���������޲Σ�
	public Department(Integer deptId, String deptName) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
	}

	public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}