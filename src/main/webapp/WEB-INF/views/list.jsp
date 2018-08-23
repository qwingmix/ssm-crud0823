<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>




<!-- 这里是V.16 ajax改造之前的代码实现

 -->




<!-- 引入c foreach标签库, 这里是JSP里面JSTL的知识点，之前是没有学的。  下面的prefix c大概就是代表签名的一整个URI吧 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表|广州市德里克信息科技有限公司</title>



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
				<h1>德里克信息员工管理系统</h1>
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
				<table class="table table-hover">
					<tr>
						<th>工号</th>
						<th>名字</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门</th>
						<th>操作</th>
					</tr>

					<!-- 这里的var=emp，意思就是每一条的数据叫做emp，大概就是说代表每个员工的所有信息啦。  -->
					<c:forEach items="${pageInfo.list }" var="emp">

						<tr>
							<th>${emp.empId}</th>
							<th>${emp.empName}</th>
							<th>${emp.gender=="M"?"男":"女"}</th>
							<th>${emp.email}</th>
							<th>${emp.department.deptName}</th>
							<!-- 因为emp里面的部门信息是属于联合查询，所以这里应该是emp的department的deptName的属性 -->
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>




							</th>
						</tr>

					</c:forEach>



				</table>
			</div>
		</div>



		<!-- ====================================第四行，分页信息====================================  -->
		<div class="row"></div>
		<!-- =======================分页文字信息_左边的=============== -->
		<!-- 这些pageInfo的几个特殊的属性都是在pageHelper分页插件里面已经帮你定义好的。 直接拿来用就对了。 -->
		<div class="col-md-6">当前${pageInfo.pageNum}页,总${pageInfo.pages}页，总${pageInfo.total}条记录</div>
		<!-- =======================分页条信息_右边的================= -->
		<div class="col-md-6">
			<nav aria-label="Page navigation">
			<ul class="pagination">


				<!--   这里是显示首页 -->
				<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>



				<!-- 这里是显示上一页 -->
				<c:if test="${pageInfo.hasPreviousPage }">

					<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>


				</c:if>




				<!-- 这些就是上一页，下一页按钮之间的数字锚文本连接 -->
				<c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
					<c:if test="${page_Num == pageInfo.pageNum }">
						<li class="active"><a href="#">${page_Num}</a></li>
					</c:if>
					<c:if test="${page_Num != pageInfo.pageNum }">
						<li><a href="${APP_PATH }/emps?pn=${page_Num}">${page_Num}</a></li>
					</c:if>

				</c:forEach>




				<!-- 这里是显示下一页 -->
				<c:if test="${pageInfo.hasNextPage }">
					<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>

				</c:if>

				<!--   这里是末页 -->
				<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>

			</ul>
			</nav>
		</div>
	</div>
</body>
</html>