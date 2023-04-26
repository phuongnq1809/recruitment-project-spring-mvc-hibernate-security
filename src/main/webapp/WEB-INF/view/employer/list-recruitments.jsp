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

<title>QP Works - List Recruitments</title>
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
							class="btn-group btn btn-info me-2">Đăng tuyển</a>

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
			<h3 class="text-center text-white">DANH SÁCH BÀI ĐĂNG TUYỂN DỤNG</h3>
			<h5 class="text-center text-white">Công ty:
				${companyRecruitments.companyName}</h5>
		</div>
	</section>

	<section class="p-5">
		<div class="container">

			<c:choose>
				<c:when test="${recruitments == null}">
					<h4 class="text-center">Danh sách trống, bạn hãy đăng tin
						tuyển dụng để tìm kiếm ứng viên!</h4>
				</c:when>
				<c:otherwise>
					<!-- DataTales -->
					<div class="card shadow mb-4">
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered tableCustomCss"
									id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>Thông tin bài đăng</th>
											<th>Hành động</th>
										</tr>
									</thead>

									<!-- hien thi du lieu tu model "recruitments" -->
									<c:forEach var="tempRecruitment" items="${recruitments}"
										varStatus="vs">

										<!-- construct an "detail" link with recruitment id -->
										<c:url var="detailLink" value="/employer/recruitmentDetail">
											<c:param name="recruitmentId" value="${tempRecruitment.id}" />
										</c:url>

										<!-- construct an "update" link with recruitment id -->
										<c:url var="updateLink" value="/employer/updateRecruitment">
											<c:param name="recruitmentId" value="${tempRecruitment.id}" />
										</c:url>

										<!-- construct an "delete" link with recruitment id -->
										<c:url var="deleteLink" value="/employer/deleteRecruitment">
											<c:param name="recruitmentId" value="${tempRecruitment.id}" />
										</c:url>

										<tr>
											<td>
												<div class="d-flex align-items-center">
													<c:choose>
														<c:when test="${tempRecruitment.getCompany().logo eq ''}">
															<img
																src="<c:url value="/resources/images/default-image.png" />"
																width="100" height="100" class="me-2" />
														</c:when>
														<c:otherwise>
															<img
																src="<c:url value="/resources/img-upload/${tempRecruitment.getCompany().logo}" />"
																width="100" height="100" class="me-2" />
														</c:otherwise>
													</c:choose>
													<div>
														<p class="text-uppercase mb-1">${tempRecruitment.type}</p>
														<p>
															<a href="${detailLink}" class="h6">${tempRecruitment.title}</a>
														</p>
														<span class="fst-italic"> <i class="bi bi-building"></i>${companyRecruitments.companyName}
															<i class="bi bi-geo-alt ms-3"></i>${tempRecruitment.address}
															<i class="bi bi-folder ms-3 me-1"></i>${tempRecruitment.category.getCategoryName()}
															<i class="bi bi-currency-dollar ms-3 me-1"></i>${tempRecruitment.salary}
															vnd <i class="bi bi-award ms-3"></i>${tempRecruitment.experience}
															<i class="bi bi-calendar ms-3 me-1"></i>${tempRecruitment.deadline}
														</span>
													</div>
												</div>
											</td>
											<td>
												<div class="d-flex justify-content-start">
													<div class="actions">
														<a href="${detailLink}" class="btn btn-primary">Xem
															chi tiết</a>
													</div>
													<div class="actions">
														<a href="${updateLink}" class="btn btn-warning">Cập
															nhật</a>
													</div>
													<div class="actions">
														<button type="button" class="btn btn-danger btn-sm"
															data-bs-toggle="modal"
															data-bs-target="#deleteRecruitmentModal${vs.index}">
															Xóa</button>

														<!-- Modal Delete -->
														<div class="modal fade"
															id="deleteRecruitmentModal${vs.index}" tabindex="-1"
															aria-labelledby="deleteRecruitmentModalLabel"
															aria-hidden="true">
															<div class="modal-dialog">
																<div class="modal-content">
																	<div class="modal-header">
																		<h5 class="modal-title"
																			id="deleteRecruitmentModalLabel">Bạn chắc chắn
																			muốn xóa?</h5>
																		<button type="button" class="btn-close"
																			data-bs-dismiss="modal" aria-label="Close"></button>
																	</div>
																	<div class="modal-body">
																		Bài đăng: <span>${tempRecruitment.title}</span>
																		<div class="modal-footer" style="margin-top: 20px">
																			<button type="button"
																				class="btn btn-secondary btn-sm"
																				data-bs-dismiss="modal">Close</button>
																			<a href="${deleteLink}" class="btn btn-danger">Xóa</a>
																		</div>
																	</div>

																</div>
															</div>
														</div>
														<!-- End of Modal Delete -->

													</div>
												</div>
											</td>
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
