package com.atguigu.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Derek.Wong
 *V.16
 *2018年8月19日下午7:19:28
 *暨南大学图书馆
 */


/**
 * @author Derek.Wong
 *2018年8月19日下午7:19:51
 *这个项目用来返回jason数据的，通用的返回的类，应该是类似于http请求的response，只是这里少一些，因为毕竟只是一个无刷新的局部返回， 不是一个页面。 
 */
public class Msg {
	//状态码，100表示成功，200表示失败, 这里的一百两百都是自己定义的，随便。 
	private int code;
	//提示信息
	private String msg;
	
	//用户要返回给浏览器的数据， 这里不明白，好像这个map的名字叫extend， 知识盲区了。 
	private Map<String,Object> extend = new HashMap<String,Object>();
	
	
	//代表请求成功了
	public static Msg success() {
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("哟，赞赞赞，处理成功！");
		return result;
	}
	
	public static Msg fail() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("哎呦，要加油哦，这次处理失败！");
		return result;
	}
	
	//说是什么为了支持后面的控制器里面的链式操作？还是什么来着
	
	public Msg add(String key,Object value) {
		this.getExtend().put(key, value);
		return this;
	}
	

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
	
	
	
	

}
