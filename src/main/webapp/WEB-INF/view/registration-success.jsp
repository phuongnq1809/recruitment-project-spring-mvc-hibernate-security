<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/register.css" />
<title>QP Works Registration</title>
</head>
<body>
	<!-- Header -->
	<section class="header">
		<div class="container p-2">
			<div class="d-flex align-items-center justify-content-between">
				<div class="logo">
					<a href="${pageContext.request.contextPath}">Quang Phuong Works</a>
				</div>
			</div>
		</div>
	</section>

	<!-- Registration Title -->
	<section class="bg-main-title p-5">
		<div class="container">
			<h3 class="text-center text-white">ĐĂNG KÝ TÀI KHOẢN THÀNH CÔNG</h3>
		</div>
	</section>

	<!-- Registration Message -->
	<section class="p-5">
		<div class="container">
			<c:choose>
				<c:when test="${userRegisterd.role.getRoleName() eq 'Cong ty'}">
					<div class="card">
						<div class="card-body text-center">
							<h6>Xin chào ${userRegisterd.fullName}!</h6>
							<p>Cảm ơn bạn đã đăng ký tài khoản với vai trò là nhà tuyển dụng!</p>
							<p>Vui lòng kiểm tra email và làm theo hướng dẫn để xác thực tài khoản
							trước khi có thể sử dụng các chức năng của hệ thống! Xin cảm ơn!</p>
							<p>Mọi thắc mắc vui lòng liên hệ bộ phận CSKH của Quang Phuong Works:</p>
							<p>Email: phuongnq1809@gmail.com | Mobile: 097.9189.790</p>
							<p>
								<a href="${pageContext.request.contextPath}/"
									class="btn btn-primary">Về trang chủ</a>
							</p>
						</div>
					</div>

				</c:when>
				<c:otherwise>
					<div class="card">
						<div class="card-body text-center">
							<h6>Xin chào ${userRegisterd.fullName}!</h6>
							<p>Chúc mừng bạn đã đăng ký thành công tài khoản tại Quang Phương Works</p>
							<p>Hãy đăng nhập để sử dụng các chức năng của hệ thống. Trân trọng cảm ơn!</p>
							<p>Mọi thắc mắc vui lòng liên hệ bộ phận CSKH của Quang Phuong Works:</p>
							<p>Email: phuongnq1809@gmail.com | Mobile: 097.9189.790</p>
							<p>
								<a href="${pageContext.request.contextPath}/login" class="btn btn-warning">Đăng nhập</a>
							</p>
						</div>
					</div>
					
				</c:otherwise>
			</c:choose>

		</div>
	</section>

	<!-- Footer -->
	<footer class="bg-footer p-4 text-center text-dark position-relative">
		<div class="container">
			<span class="fst-italic"> Copyright &copy; 2023 Quang Phuong
				Works | phuongnq1809@gmail.com | 097.9189.790 </span> <a href="#"
				class="position-absolute bottom-0 end-0 p-4"> <i
				class="bi bi-arrow-up-circle h3"></i>
			</a>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>
