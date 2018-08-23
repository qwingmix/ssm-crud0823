<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 8.19 今晚是搞到V.17 里面的弹窗,7:19的时候 -->


<!-- 本页最重要的事情就是，如何获得json数据，并解析出来，拆开， 放入到html标签里面去。 -->


<!-- 引入c foreach标签库, 这里是JSP里面JSTL的知识点，之前是没有学的。  下面的prefix c大概就是代表签名的一整个URI吧 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表|SSM-CRUD</title>



<!-- 
下面这里很奇怪，应该是JSP的知识点。 相当于设置了一个键值对，APP_PATH的值是getContextPath函数拿到的项目目录，这个函数的值是/开头，无/结尾，
在本项目， 大概就是http://localhost:8080/ssm-crud/emps?pn=3, 这样随意一个URL里面的/ssm-crud吧
 -->
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!-- 不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。 
以/开始的相对路径，找资源， 以服务器为标准，如 http://localhost:3306,需要加上项目名http://localhost:3306/crud

 -->

<!-- 这里仅仅是引入jquery和booststrap等第三方js库吧 -->
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>



<body>

	<!-- 搭建显示页面，这层div是最底层的容器了。 -->
	<div class="container">
		<!--第一行，这里是标题  -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD System</h1>
			</div>
		</div>


		<!--第二行，这里是按钮  -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>



		<!--第三行，这里显示表格数据  -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table"><!-- table是最高层级的标签 -->
					<thead><!-- 这里是表头 -->
						<tr><!-- 这里是一行，table row -->
							<th>工号</th><!-- 这里是一个table header cell , thead里面只能是有th，不能有td吧我猜-->
							<th>名字</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					
					
					<tbody>
					</tbody>

					<!-- 这里的var=emp，意思就是每一条的数据叫做emp，大概就是说代表每个员工的所有信息啦。  -->

				</table>
			</div>
		</div>



		<!-- ====================================第四行，分页信息====================================  -->
		<div class="row">
		<!-- =======================分页文字信息_左边的=============== -->
		<!-- 这些pageInfo的几个特殊的属性都是在pageHelper分页插件里面已经帮你定义好的。 直接拿来用就对了。 -->
		<div class="col-md-6" id="page_info_area"></div>
		<!-- =======================分页条信息_右边的================= -->
		<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>



		<!-- ====================================以下是js相关的代码了，偏重在函数，比较不是布局方面的了====================================  -->
	<script type="text/javascript">
	
	var totalRecord,currentPage;
	//1·页面加载完以后，直接去发送ajax请求，要到分页数据；
	$(function(){
		//去首页
		to_page(1)
	});
	
	function to_page(pn){
		$.ajax({
			url:"${APP_PATH}/emps",
			data:"pn="+pn,
			type:"GET",
			success:function(result){
				//console.log(result);
				//1·解析并显示员工数据
				build_emps_table(result);
				
				//2.解析显示分页信息
				build_emps_info(result);
				
				//3.解析显示分页条数据
				build_page_nav(result);
			}
		})
		}
	
	//下面这里是从json里面拆出所有员工数据
	
//-----------------1·解析并显示员工数据------------------------
	
	function build_emps_table(result){
		//清空table表格
		//$("#emps_table tbody").empty();
		var emps = result.extend.pageInfo.list;//这里其实就是json里面的一个个层级的维度名
		//$.each这个就是遍历函数了
		$.each(emps,function(index,item){//这里的function就是每次遍历的回调函数。另，这里的每一个emps就是每一个员工
			//alert(item.empName);/* 8.19马克 ，这里仅仅是测试时候用的*   V.17 08:04 */

			
		   //var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
			var empIdTd = $("<td></td>").append(item.empId);//td就是单元格
			var empNameTd =$("<td></td>").append(item.empName);
			var genderTd=$("<td></td>").append(item.gender=='M'?"男":"女");
			var emailTd = $("<td></td>").append(item.email);//我去，08.22这几天，因为这里的美刀符号漏掉了，所以代码一起没跑成功，这个错误很难发现啊，eclipse对jsp不报错了
			var deptNameTd = $("<td></td>") .append(item.department.deptName);
			
			
			
			//这里是编辑按钮
			var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
							.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
			editBtn.attr("edit-id",item.empId);//这里是为编辑按钮添加一个自定义的属性，来表示当前员工id
							
			//这里是删除按钮
			var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
							.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
			delBtn.attr("del-id",item.empId);
			
			
			//考虑到两个按钮之间要留有空格，所以做一个大的单元格， 把上面两个按钮放到里面去，中间留一个空位。
			var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
			
			//append方法执行完成以后还是返回原来的元素，也就是还返回tr标签。这部分就是链式操作了
			$("<tr></tr>").append(empIdTd)//注意，tr是行，td是单元格。
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				.append(btnTd) //因为要加空格，所以把两个按钮加在btnTd里面去统一append了。.append(editBtn).append(delBtn)
				.appendTo("#emps_table tbody");
		})
	}
	
	
	
	
	//2.-------------------解析显示分页信息------------------
	function build_emps_info(result){
		$("#page_info_area").empty();
		$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum
				+"页,总"+result.extend.pageInfo.pages
				+"页，总"+result.extend.pageInfo.total+"条记录")
		totalRecord = result.extend.pageInfo.total;
		currentPage = result.extend.pageInfo.pageNum;
	}
	

	
	//3.--------------------解析显示分页条数据-----------------------------
	function build_page_nav(result){
		//page_nav_area
		
		
		//这里应该是导航条真快的父元素
		var ul = $("<ul></ul>").addClass("pagination");
		
		
		//构建元素,$()这是jquery的知识范畴
		//首页
		var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
		
		//前一页
		var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
		
		//下一页
		var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
		
		//末页
		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("fhrf","#"));
		
		//添加首页和前一页进去ul容器里面去
		ul.append(firstPageLi).append(prePageLi);
		
		
		
		
		//一二三四五页码链接,.each是循环，function(index,item)是遍历. 每次遍历的过程，都对ul父容器添加页面链接
		$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
		
			//遍历出来的元素，也是一个个个页码号的点击链接
			var numLi =  $("<li></li>").append($("<a></a>").append(item));
			ul.append(numLi);//每次遍历的时候，把页码号链接添加到ul容器里边去。
		}
		)
		
		
		//添加下一页和最后一页进去ul容器里面去
		ul.append(nextPageLi).append(lastPageLi);
		
		//把ul容器加入到nav导航条元素里面去
		var navEle = $("<nav></nav>").append(ul);
		//最后把导航条标签添加到div中去，竟然把这里的#给漏掉了
		navEle.appendTo("#page_nav_area"); 

	}
	
	
	

	</script>

</body>
</html>