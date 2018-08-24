package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.DepartmentService;

/**
 * @author 负责处理跟部门有关的请求
 *
 */




@Controller
public class DepartmentController {
	
	
	@Autowired
	private DepartmentService departmentService;//这里的话， 就涉及到创建这个DepartmentService类了，就从这里进去吧。
	//这个类是放在service里边的
	
	/*
	 * 返回所有的部门信息
	 * V.21
	 */
	
	@RequestMapping("/depts")//这里跟jsp里面的下拉列表里的url请求路径一致的;
	@ResponseBody
	public Msg getDepts() {
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
	
	
	
}
