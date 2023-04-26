<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<title>QP Works - Log in</title>
		
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
		
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css" />
		
	</head>

	<body>
		<div class="login-form">
		    <form:form action="${pageContext.request.contextPath}/authenticateTheUser" method="POST">
		        <h2 class="text-center">Đăng nhập</h2>       
		        <div class="form-group">
		            <input type="email" name="username" class="form-control" placeholder="Email" required="required">
		        </div>
		        <div class="form-group">
		            <input type="password" name="password" class="form-control" placeholder="Password" required="required">
		        </div>
		        
		        <div>
					<!-- Check for login error -->
					<c:if test="${param.error != null}">
						<div class="alert alert-danger col-xs-offset-1 col-xs-10">
							Tài khoản hoặc mật khẩu không đúng. Vui lòng nhập lại! <br />
							Trường hợp bạn là nhà tuyển dụng, cần xác thực email trước khi đăng nhập. Xin cảm ơn!
						</div>
					</c:if>
	            </div>
		        <div class="form-group">
		            <button type="submit" class="btn btn-primary btn-block">Log in</button>
		        </div>      
		    </form:form>
		</div>
	</body>

</html>