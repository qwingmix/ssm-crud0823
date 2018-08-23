package com.atguigu.crud.dao;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);
    
    
    //下面这里是MBG原生的查询
    List<Employee> selectByExample(EmployeeExample example);
    Employee selectByPrimaryKey(Integer empId);
    
    
    //以下是在MBG原生查询基础上做扩展， 让它变成联合查询，同时拿到员工信息和员工的部门信息
    List<Employee> selectByExampleWithDept(EmployeeExample example);
    Employee selectByPrimaryKeyWithDept(Integer empId);

    //------------------以上，为此要在employeemarpper.xml增加好多行代码---------------------------------------------------------
    
    
    
    

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);
}