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

<title>QP Works - List Apply Jobs</title>
</head>
<body>
	<!-- Header -->
	<section class="header">
		<div class="container p-2">
			<div class="d-flex align-items-center justify-content-between">
				<div class="logo">
					<a href="${pageContext.request.contextPath}/">Quang Phuong
						Works</a>
				</div>

				<security:authorize access="hasRole('ROLE_USERS')">
					<div>
						<a href="${pageContext.request.contextPath}/"
							class="btn-group me-4 text-light"> Trang chủ </a>

						<div class="btn-group">
							<ul class="nav nav-pills">
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle text-white"
									data-bs-toggle="dropdown" href="#" role="button"
									aria-expanded="false">Công ty</a>
									<ul class="dropdown-menu">
										<c:url var="candidateAllCompaniesLink"
											value="/candidate/allCompanies">
											<c:param name="userId" value="${currentUser.id}" />
										</c:url>
										<li><a class="dropdown-item"
											href="${candidateAllCompaniesLink}">Tất cả công ty</a></li>

										<c:url var="listFollowCompaniesLink"
											value="/candidate/listFollowCompanies">
											<c:param name="userId" value="${currentUser.id}" />
										</c:url>
										<li><a class="dropdown-item"
											href="${listFollowCompaniesLink}">Công ty đã theo dõi</a></li>
									</ul></li>
							</ul>
						</div>

						<div class="btn-group">
							<ul class="nav nav-pills">
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle text-white"
									data-bs-toggle="dropdown" href="#" role="button"
									aria-expanded="false">Việc làm</a>
									<ul class="dropdown-menu">
										<c:url var="candidateAllJobsLink" value="/candidate/allJobs">
											<c:param name="userId" value="${currentUser.id}" />
										</c:url>
										<li><a class="dropdown-item"
											href="${candidateAllJobsLink}">Tất cả việc làm</a></li>

										<c:url var="candidateSaveJobsLink"
											value="/candidate/listSaveJobs">
											<c:param name="userId" value="${currentUser.id}" />
										</c:url>
										<li><a class="dropdown-item"
											href="${candidateSaveJobsLink}">Việc làm đã lưu</a></li>

										<c:url var="candidateListApplyJobLink"
											value="/candidate/listApplyJob">
											<c:param name="userId" value="${currentUser.id}" />
										</c:url>
										<li><a class="dropdown-item"
											href="${candidateListApplyJobLink}">Việc làm đã ứng tuyển</a></li>
									</ul></li>
							</ul>
						</div>

						<div class="btn-group">
							<button type="button" class="btn btn-warning dropdown-toggle"
								data-bs-toggle="dropdown" aria-expanded="false">
								${currentUser.fullName}</button>
							<ul class="dropdown-menu">

								<c:url var="candidateProfileLink"
									value="/candidate/updateProfile">
									<c:param name="userId" value="${currentUser.id}" />
								</c:url>
								<li><a class="dropdown-item" href="${candidateProfileLink}">Hồ
										sơ</a></li>

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
			<h3 class="text-center text-white">DANH SÁCH VIỆC LÀM ĐÃ ỨNG TUYỂN</h3>
		</div>
	</section>

	<section class="p-5">
		<div class="container">
			<c:choose>
				<c:when test="${theListApplyJobs == null}">
					<h4 class="text-center">Danh sách trống, bạn hãy chọn ứng tuyển các công
						việc yêu thích!</h4>
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
											<th>Thông tin việc làm</th>
											<th>CV đã nộp</th>
										</tr>
									</thead>

									<!-- hien thi du lieu tu model "theListApplyJobs" -->
									<c:forEach var="tempApplyJob" items="${theListApplyJobs}"
										varStatus="vs">

										<tr>
											<td>
												<div class="d-flex align-items-center">
													<c:choose>
														<c:when test="${tempApplyJob.company.logo eq ''}">
															<img
																src="<c:url value="/resources/images/default-image.png" />"
																width="100" height="100" class="me-2" />
														</c:when>
														<c:otherwise>
															<img
																src="<c:url value="/resources/img-upload/${tempApplyJob.company.logo}" />"
																width="100" height="100" class="me-2" />
														</c:otherwise>
													</c:choose>
													<div>
														<p class="text-uppercase mb-1">${tempApplyJob.recruitment.type}</p>
														<c:url var="recruitmentDetailLink"
															value="/recruitmentDetail">
															<c:param name="recruitmentId"
																value="${tempApplyJob.recruitment.id}" />
														</c:url>
														<p>
															<a href="${recruitmentDetailLink}" class="h6">${tempApplyJob.recruitment.title}</a>
														</p>
														<span class="fst-italic"> <i class="bi bi-building"></i>${tempApplyJob.recruitment.getCompany().companyName}
															<i class="bi bi-geo-alt ms-3"></i>${tempApplyJob.recruitment.address}
															<i class="bi bi-folder ms-3 me-1"></i>${tempApplyJob.recruitment.category.getCategoryName()}
															<i class="bi bi-currency-dollar ms-3 me-1"></i>${tempApplyJob.recruitment.salary}
															vnd <i class="bi bi-award ms-3"></i>${tempApplyJob.recruitment.experience}
															<i class="bi bi-calendar ms-3 me-1"></i>${tempApplyJob.recruitment.deadline}
														</span>
													</div>
												</div>
											</td>
											<td>
												<div class="d-flex justify-content-start">
													<div class="actions">
													<p class="mb-1">Tên file: <span class="fst-italic">${tempApplyJob.cvName}</span></p>
            										<a href="<c:url value="/resources/cv-upload/${tempApplyJob.cvName}" />" style="text-decoration: underline;">Download</a>
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
