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
<title>员工列表|Employee Management System</title>



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


<!-- 员工添加功能的模态框v.20 -->
<!-- 下面是【新增】的模态框，直接从boostrap官网上面拿来的界面代码，然后改动。  -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">员工添加</h4>
      </div>
      <div class="modal-body">
      
<!--       下面是body体内的表单 -->

					<!-- 名字输入框 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">名字</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control" id="empName_add_input"
									placeholder="empName">
							</div>
						</div>

					<!-- 邮件输入框 ,这里面的name属性要跟javabean里面的字段对应，就是pojo那些的字段-->
						<div class="form-group">
							<label class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control" id="email_add_input"
									placeholder="email@atguigu.com">
							</div>
						</div>
						
						
					<!-- 性别选择框 -->
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								
								<!-- 性别这里就不是输入框了，应用了选择按钮。 -->
								<label class="radio-inline"> <input type="radio" 
									name="gender" id="gender1_add_input" value="M" checked="checked">
									男
								</label> <label class="radio-inline"> <input
									type="radio" name="gender" id="gender2_add_input"
									value="F">女
								</label>
							</div>
						</div>



						<!-- 性别选择框 -->
						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<!-- 部门这里就不是输入框了，而是下拉列表。 -->
								<!-- 部门提交部门id即可 -->
									<select class="form-control" name="dId" >
									</select>
																
								
							</div>
						</div>


					</form>

				</div><!-- modal-body的尾巴 -->
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
 </div>














	<!-- 搭建显示页面，这层div是最底层的容器了。 -->
	<div class="container">
		<!--第一行，这里是标题  -->
		<div class="row">
			<div class="col-md-12">
				<h1>Employee Management System</h1>
			</div>
		</div>


		<!--第二行，这里是按钮  -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
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
				build_page_info(result);
				
				//3.解析显示分页条数据
				build_page_nav(result);
			}
		})
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	//下面这里是从json里面拆出所有员工数据
	
//-----------------1·解析并显示员工数据------------------------
	
	function build_emps_table(result){
		//因为ajax是页面无刷新的，所以要先清空，不然会重复叠加，页面乱掉。
		$("#emps_table tbody").empty();
		
		
		
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
	
	
	
	
	//2.-------------------2.解析显示分页信息------------------
	function build_page_info(result){
		
		//下面这里也是，先让容器清空，再来加载数据，因为ajax无刷新问题。 
		$("#page_info_area").empty();
		
		$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum
				+"页,总"+result.extend.pageInfo.pages
				+"页，总"+result.extend.pageInfo.total+"条记录")
		totalRecord = result.extend.pageInfo.total;
		currentPage = result.extend.pageInfo.pageNum;
	}
	

	
	//3.--------------------3.解析显示分页条数据-----------------------------
	function build_page_nav(result){
		//page_nav_area
		
		//下面这里也是，先让容器清空，再来加载数据，因为ajax无刷新问题。 
		$("#page_nav_area").empty();
		
		//这里应该是导航条真快的父元素
		var ul = $("<ul></ul>").addClass("pagination");
		
		
		//构建元素,$()这是jquery的知识范畴
		//******************导航条之首页********************
		var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
		
		
		
		
		
		//*******************导航条之上一页********************
		
		//善上一页
		var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
		
		
		//-------v.19 如果当前页为第一页，那么首页和前一页设置为无法点击（鼠标变成红色的禁止标识），否则的话，赋予正确的点击逻辑------------
		if(result.extend.pageInfo.hasPreviousPage == false){
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		}else{
			firstPageLi.click(function(){
				to_page(1);
				});
			
			prePageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum -1);
				});

		}
		
		

		//*******************导航条之下一页********************

		var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
		
		
		//*******************导航条之末页********************

		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("fhrf","#"));
		
		
		//-------v.19 如果当前页为最后一页，那么下一页和最后一页设置为无法点击，否则的话，赋予正确的点击逻辑------------
		if(result.extend.pageInfo.hasNextPage == false){
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		}else{
			nextPageLi.click(function(){
			to_page(result.extend.pageInfo.pageNum+1);
				
			});
			
			lastPageLi.click(function(){
			to_page(result.extend.pageInfo.pages);
				
			});
			
		}
		


		//添加首页和前一页进去ul容器里面去
		ul.append(firstPageLi).append(prePageLi);
		

		//一二三四五页码链接,.each是循环，function(index,item)是遍历. 每次遍历的过程，都对ul父容器添加页面链接
		$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
		

			//遍历出来的元素，也是一个个个页码号的点击链接
			var numLi =  $("<li></li>").append($("<a></a>").append(item));
			
			//当前页码链接样式加亮，逻辑-如果当前页面等于我们正在遍历的页面
			if(result.extend.pageInfo.pageNum == item){
				numLi.addClass("active");
			}
			
			
			//这里就是用的ajax请求，点击页面号后去到对应的页
			numLi.click(function(){
				to_page(item);
			});


			
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
	
	
	//##############下面开始模态框的事件了####################
	
	//点击新增按钮，弹出模态框
	$("#emp_add_modal_btn").click(function(){
		
		//v.21 发送ajax请求，查出部门信息，显示在下拉列表中，但这里为了分离吧，把代码卸载其他地方了。
		getDepts();
		
		
		//弹出模态框
		$("#empAddModal").modal({
			backdrop:"static"
		});
	});
	
	
	
	//v.21 这里就是向数据库查询部门的ajax代码了。 
	function getDepts(){
		$.ajax({
			url:"${APP_PATH}/depts",//这里首先是会去到前端控制器，收到请求后再转发给service，service也就是dao，去数据库拿东西回来
			type:"GET",
			success:function(result){
				//在浏览器F12看到拿出来的json长这样的，{"code":100,"msg":"哟，赞赞赞，处理成功！","extend":{"depts":[{"deptId":1,"deptName":"研发部"},{"deptId":2,"deptName":"其他部门"}]}}
				//console.log(result)
				
				//显示在下拉列表中

				//"#empAddModal select"，这一整个，就是empAddModal模态框里边的select下拉列表，因为仅有一个下拉列表，就可以这样去定位。
				$.each(result.extend.depts,function(){//这里是遍历了
					var optionEle =  $("<option></option>").append(this.deptName).attr("value",this.deptId);//这里的this是当前在遍历的对象，就是其中一个部门啦。 
					optionEle.appendTo("#empAddModal select");//一定要有分号，不然bug。 这里的意思，就是把上面构建的option标签，增加到模态框的下拉列表上面去
				});
			}
		});
	}
	
	
	
	//点击保存，保存员工。 为保存按钮绑定单击事件
	
	
	
	

	
	</script>

</body>
</html>