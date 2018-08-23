package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;


/**
 * @author derek
 * 测试dao层的工作
 *推荐spring的项目用spring的单元测试。 可以自动注入我们需要的组件
 *1、导入SpringTest模块
 *2、@ContextConfiguration
 *3、直接autowired要使用的组件
 */


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired//这里的意思就是，自动注入departmentMapper mapper.
	DepartmentMapper departmentMapper ;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	
	@Autowired
	SqlSession sqlSession;
	
	
	@Test
	public void testCRUD() {
		
		System.out.println(departmentMapper);
		
//		//1、插入几个部门
//	departmentMapper.insertSelective(new Department(null,"开发部"));
//	departmentMapper.insertSelective(new Department(null,"测试部"));
//	
	
//		//2、生成员工数据，测试员工插入
//	employeeMapper.insertSelective(new Employee(null,"Derek","M","Derek@atguigu.com",2));
	
		
		//3.批量插入多个员工：批量，使用可以执行批量操作的sqlSession.
		
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=900;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0,5)+i;
			mapper.insertSelective(new Employee(null,uid,"M",uid+"@atguigu.com",1));
		}
		System.out.println("批量完成");
		
	
		
	}

}
