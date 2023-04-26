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

<link
	href="${pageContext.request.contextPath}/resources/datatables/sb-admin-2.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/resources/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/resources/datatables/tableCustomCss.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/register.css" />

<title>QP Works - Candidate List</title>
</head>
<body>
	<!-- Header -->
	<section class="header">
		<div class="container p-2">
			<div class="d-flex align-items-center justify-content-between">
				<div class="logo">
					<a href="${pageContext.request.contextPath}">Quang Phuong Works</a>
				</div>
				<security:authorize access="hasRole('ROLE_USERS')">
					<div>
						<a href="${pageContext.request.contextPath}/"
							class="btn-group me-4 text-light"> Trang chủ </a>
						<c:url var="employerListCandidateLink"
							value="/employer/listCandidate">
							<c:param name="userId" value="${currentUser.id}" />
						</c:url>
						<a href="${employerListCandidateLink}"
							class="btn-group me-4 text-light">Ứng cử viên</a> <a
							href="${pageContext.request.contextPath}/employer/postRecruitment"
							class="btn btn-info me-2">Đăng tuyển</a>

						<div class="btn-group">
							<button type="button" class="btn btn-warning dropdown-toggle"
								data-bs-toggle="dropdown" aria-expanded="false">
								${currentUser.fullName}</button>
							<ul class="dropdown-menu">
								<c:url var="employerProfileLink" value="/employer/updateProfile">
									<c:param name="userId" value="${currentUser.id}" />
								</c:url>
								<li><a class="dropdown-item" href="${employerProfileLink}">Hồ
										sơ</a></li>
								<li><c:url var="recruitmentsManagementLink"
										value="/employer/recruitmentsManagement">
										<c:param name="employerId" value="${currentUser.id}"></c:param>
									</c:url> <a class="dropdown-item" href="${recruitmentsManagementLink}">Danh
										sách bài đăng</a></li>
								<li><hr class="dropdown-divider" /></li>
								<li><c:url value="/logout" var="logoutUrl" />
									<form id="logout" action="${logoutUrl}" method="post">
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />
									</form> <a class="dropdown-item"
									href="javascript:document.getElementById('logout').submit()"><i
										class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
							</ul>
						</div>
					</div>
				</security:authorize>
			</div>
		</div>
	</section>

	<section class="bg-main-title p-5">
		<div class="container">
			<h3 class="text-center text-white">DANH SÁCH ỨNG CỬ VIÊN ỨNG
				TUYỂN</h3>
			<h4 class="text-center text-white">Công ty:
				${theCompany.companyName}</h4>
		</div>
	</section>

	<section class="p-5">
		<div class="container">
			<c:choose>
				<c:when test="${listApplyPost == null}">
					<h4 class="text-center">Danh sách trống, hiện chưa có ứng viên ứng tuyển!</h4>
				</c:when>
				<c:otherwise>
					<!-- DataTales -->
					<div class="card">
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered tableCustomCss"
									id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>Họ và tên</th>
											<th>Email</th>
											<th>Số điện thoại</th>
											<th>Địa chỉ</th>
											<th>Ảnh</th>
											<th>Vị trí ứng tuyển</th>
											<th>CV đã nộp</th>
											<th>Ngày ứng tuyển</th>
										</tr>
									</thead>

									<!-- hien thi du lieu tu model "listApplyPost" -->
									<c:forEach var="tempApplyPost" items="${listApplyPost}"
										varStatus="vs">
										<tr>
											<td>${tempApplyPost.getUser().getFullName()}</td>
											<td>${tempApplyPost.getUser().getEmail()}</td>
											<td>${tempApplyPost.getUser().getPhoneNumber()}</td>
											<td>${tempApplyPost.getUser().getAddress()}</td>
											<td><c:choose>
													<c:when test="${tempApplyPost.getUser().image eq ''}">
														<img
															src="<c:url value="/resources/images/default-image.png" />"
															width="50" height="50" />
													</c:when>
													<c:otherwise>
														<img
															src="<c:url value="/resources/img-upload/${tempApplyPost.getUser().image}" />"
															width="50" height="50" />
													</c:otherwise>
												</c:choose></td>
											<td>${tempApplyPost.getRecruitment().getTitle()}</td>
											<td><a
												href="<c:url value="/resources/cv-upload/${tempApplyPost.cvName}" />">Xem
													CV</a></td>
											<td>${tempApplyPost.created}</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
					</div>
					<!-- end data table -->
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

	<!-- Data Tables JavaScript-->
	<script
		src="${pageContext.request.contextPath}/resources/datatables/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/datatables/jquery.dataTables.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/datatables/dataTables.bootstrap4.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/datatables/datatables-user-home.js"></script>

</body>
</html>
