<!-- index.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
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
	href="${pageContext.request.contextPath}/resources/css/index.css" />

<title>QuangPhuong Works</title>

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

				<!-- User da dang nhap -->
				<security:authorize access="hasRole('ROLE_USERS')">
					<div>
						<a href="${pageContext.request.contextPath}/"
							class="btn-group me-4 text-light"> Trang chủ </a>

						<security:authorize access="hasRole('ROLE_UNGVIEN')">

							<div class="btn-group">
								<ul class="nav nav-pills">
									<li class="nav-item dropdown"><a
										class="nav-link dropdown-toggle text-white"
										data-bs-toggle="dropdown" href="#" role="button"
										aria-expanded="false">Công ty</a>
										<ul class="dropdown-menu">
											<c:url var="candidateAllCompaniesLink" value="/candidate/allCompanies">
												<c:param name="userId" value="${currentUser.id}" />
											</c:url>
											<li><a class="dropdown-item" href="${candidateAllCompaniesLink}">Tất cả công ty</a></li>
											
											<c:url var="listFollowCompaniesLink" value="/candidate/listFollowCompanies">
												<c:param name="userId" value="${currentUser.id}" />
											</c:url>
											<li><a class="dropdown-item" href="${listFollowCompaniesLink}">Công ty đã theo dõi</a></li>
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
											
											<c:url var="candidateSaveJobsLink" value="/candidate/listSaveJobs">
												<c:param name="userId" value="${currentUser.id}" />
											</c:url>
											<li><a class="dropdown-item" href="${candidateSaveJobsLink}">Việc làm đã
													lưu</a></li>
											
											<c:url var="candidateListApplyJobLink" value="/candidate/listApplyJob">
												<c:param name="userId" value="${currentUser.id}" />
											</c:url>
											<li><a class="dropdown-item" href="${candidateListApplyJobLink}">Việc làm đã ứng tuyển</a></li>
										</ul>
									  </li>
								</ul>
							</div>

						</security:authorize>

						<security:authorize access="hasRole('ROLE_CONGTY')">
							<c:url var="employerListCandidateLink"
								value="/employer/listCandidate">
								<c:param name="userId" value="${currentUser.id}" />
							</c:url>
							<a href="${employerListCandidateLink}" class="btn-group me-4 text-light">Ứng
								cử viên</a>
							<a
								href="${pageContext.request.contextPath}/employer/postRecruitment"
								class="btn btn-info me-2">Đăng tuyển</a>
						</security:authorize>

						<div class="btn-group">
							<button type="button" class="btn btn-warning dropdown-toggle"
								data-bs-toggle="dropdown" aria-expanded="false">
								${currentUser.fullName}</button>
							<ul class="dropdown-menu">

								<c:choose>
									<c:when test="${currentUser.role.getId() == 2}">
										<c:url var="employerProfileLink"
											value="/employer/updateProfile">
											<c:param name="userId" value="${currentUser.id}" />
										</c:url>
										<li><a class="dropdown-item"
											href="${employerProfileLink}">Hồ sơ</a></li>
									</c:when>
									<c:otherwise>
										<c:url var="candidateProfileLink"
											value="/candidate/updateProfile">
											<c:param name="userId" value="${currentUser.id}" />
										</c:url>
										<li><a class="dropdown-item"
											href="${candidateProfileLink}">Hồ sơ</a></li>
									</c:otherwise>
								</c:choose>

								<security:authorize access="hasRole('ROLE_CONGTY')">
									<li><c:url var="recruitmentsManagementLink"
											value="/employer/recruitmentsManagement">
											<c:param name="employerId" value="${currentUser.id}"></c:param>
										</c:url> <a class="dropdown-item" href="${recruitmentsManagementLink}">Danh
											sách bài đăng</a></li>
								</security:authorize>

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

				<!-- Neu chua dang nhap thi hien thi button Dang ky hoac Dang nhap -->
				<security:authorize access="!hasRole('ROLE_USERS')">
					<div>
						<a href="${pageContext.request.contextPath}/register"
							class="btn btn-info">Đăng ký</a> <a
							href="${pageContext.request.contextPath}/login"
							class="btn btn-warning">Đăng nhập</a>
					</div>
				</security:authorize>

			</div>
		</div>
	</section>

	<!-- Search Area -->
	<section class="main-banner text-light p-5 p-lg-0 pt-lg-5">
		<div class="container">
			<div class="search-area">
				<h3 class="text-center">Tìm kiếm công việc mơ ước của bạn</h3>
				<form:form
					action="searchProcess?${_csrf.parameterName}=${_csrf.token}"
					method="post" onsubmit="return checkSearchInput()">
					<div class="search-form">
						<div class="input-group">
							<input type="text" id="search-job" name="searchJob"
								class="form-control"
								placeholder="Việc làm, công ty, ngành nghề..." /> <input
								type="text" id="search-place" name="searchPlace"
								class="form-control" placeholder="Tỉnh/thành, quận..." />
							<button type="submit" class="btn btn-primary btn-lg">
								Tìm kiếm</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</section>

	<!-- Top 4 Danh muc cong viec -->
	<section class="bg-top p-5">
		<div class="container">
			<div class="title text-center">DANH MỤC CÔNG VIỆC</div>
			<h2 class="text-center mb-4">Top Danh Mục</h2>
			<div class="row row-cols-2 row-cols-md-4 g-2 g-md-3">
				<c:forEach var="tempCategory" items="${topCategories}"
					varStatus="vs">
					<div class="col">
						<div class="top4cats">
							<p>
								<h6>${tempCategory.categoryName}</h6>
							</p>
							<p>
								<span class="number">${tempCategory.numberChoose}</span> vị trí
							</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>

	<!-- Features -->
	<section class="feature-home p-5">
		<div class="container">
			<div class="row text-center g-4">
				<div class="col-md">
					<div class="card bg-transparent border-0 text-light">
						<div class="card-body text-center">
							<div class="h1 mb-3">
								<i class="bi bi-card-checklist"></i>
							</div>
							<h4 class="card-title mb-3">Tìm kiếm hàng triệu việc làm</h4>
							<p class="card-text">Danh sách các công việc được cập nhật
								thường xuyên, đa dạng nghành nghề, tỉnh thành.</p>
						</div>
					</div>
				</div>
				<div class="col-md">
					<div class="card bg-transparent border-0 text-light">
						<div class="card-body text-center">
							<div class="h1 mb-3">
								<i class="bi bi-check-circle"></i>
							</div>
							<h4 class="card-title mb-3">Dễ dàng quản lý công việc</h4>
							<p class="card-text">Nhà tuyển dụng và ứng viên có thể theo
								dõi công việc mình đang quan tâm.</p>
						</div>
					</div>
				</div>
				<div class="col-md">
					<div class="card bg-transparent border-0 text-light">
						<div class="card-body text-center">
							<div class="h1 mb-3">
								<i class="bi bi-bar-chart"></i>
							</div>
							<h4 class="card-title mb-3">Top nghành nghề trọng điểm</h4>
							<p class="card-text">Danh mục nhiều ngành nghề được tìm kiếm
								nhiều nhất, bắt kịp xu hướng thời đại.</p>
						</div>
					</div>
				</div>
				<div class="col-md">
					<div class="card bg-transparent border-0 text-light">
						<div class="card-body text-center">
							<div class="h1 mb-3">
								<i class="bi bi-people-fill"></i>
							</div>
							<h4 class="card-title mb-3">Ứng viên chuyên gia tìm kiếm</h4>
							<p class="card-text">Ứng viên giàu kinh nghiệm, ứng tuyển
								nhanh, tỉ lệ phỏng vấn đạt cao.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Cong ty noi bat va cac viec lam noi bat -->
	<section class="bg-top p-5">
		<div class="container">
			<div class="row">
				<div class="col-md-7">
					<p class="title">CÔNG VIỆC ĐƯỢC NHIỀU NGƯỜI ỨNG TUYỂN</p>
					<h4 class="mb-4">Việc làm nổi bật</h4>
					<c:forEach var="featuredJob" items="${featuredJobs}" varStatus="vs">
						<div
							class="d-sm-flex justify-content-between align-items-center p-3 feature-job">
							<div class="job">
								<div class="d-flex align-items-center">
									<c:choose>
										<c:when test="${featuredJob[0].company.logo eq ''}">
											<img
												src="<c:url value="/resources/images/default-image.png" />"
												width="100" height="100" class="me-2" />
										</c:when>
										<c:otherwise>
											<img
												src="<c:url value="/resources/img-upload/${featuredJob[0].company.logo}" />"
												width="100" height="100" class="me-2" />
										</c:otherwise>
									</c:choose>
									<div>
										<p class="title">${featuredJob[0].type}</p>
										<c:url var="recruitmentDetailLink" value="/recruitmentDetail">
											<c:param name="recruitmentId" value="${featuredJob[0].id}" />
										</c:url>
										<p><a href="${recruitmentDetailLink}" class="h5">${featuredJob[0].title}</a></p> 
										<span>
											<i class="bi bi-building"></i>${featuredJob[0].company.getCompanyName()}
											<i class="bi bi-geo-alt ms-3"></i>${featuredJob[0].address} <i
											class="bi bi-calendar ms-3 me-1"></i>${featuredJob[0].deadline}
										</span>
									</div>
								</div>
							</div>

							<security:authorize access="hasRole('ROLE_UNGVIEN')">
								<div class="apply">
									<button type="button" class="btn btn-primary btn-sm"
										data-bs-toggle="modal"
										data-bs-target="#applyJobModal${vs.index}">Apply Job
									</button>

									<!-- luu va huy luu cong viec danh cho ung vien -->
									<c:url var="saveJobLink" value="/candidate/saveJob">
										<c:param name="recruitmentId" value="${featuredJob[0].id}" />
										<c:param name="userId" value="${currentUser.id}" />
									</c:url>
									<c:url var="unSaveJobLink" value="/candidate/unSaveJob">
										<c:param name="recruitmentId" value="${featuredJob[0].id}" />
										<c:param name="userId" value="${currentUser.id}" />
									</c:url>

									<c:if
										test="${currentUserSaveJobs == null || !currentUserSaveJobs.contains(featuredJob[0].id)}">
										<a href="${saveJobLink}" class="btn btn-warning btn-sm">Lưu</a>
									</c:if>

									<c:if test="${currentUserSaveJobs.contains(featuredJob[0].id)}">
										<a href="${unSaveJobLink}" class="btn btn-warning btn-sm">Hủy
											lưu</a>
									</c:if>

									<!-- Modal Apply Job -->
									<div class="modal fade" id="applyJobModal${vs.index}"
										tabindex="-1" aria-labelledby="applyJobModalLabel"
										aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="applyJobModalLabel">Ứng
														tuyển công việc</h5>
													<button type="button" class="btn-close"
														data-bs-dismiss="modal" aria-label="Close"></button>
												</div>

												<div class="modal-body">
													<h5>
														Vị trí: <span>${featuredJob[0].title}</span>
													</h5>

													<form:form
														action="candidate/applyJobProcess?${_csrf.parameterName}=${_csrf.token}"
														method="post" enctype="multipart/form-data">

														<input type="hidden" name="recruitmentId"
															value="${featuredJob[0].id}" />
														<input type="hidden" name="userId"
															value="${currentUser.id}" />


														<div>
															<label class="col-form-label">CV:</label> <select
																id="type-cv" name="typeCVSelect" class="form-select"
																onchange="getTypeCV(this, 'new-cv${vs.index}','new-cv-input${vs.index}')">
																<c:choose>
																	<c:when test="${currentUserCV != null}">
																		<option value="updatedCV">Dùng CV đã cập nhật</option>
																		<option value="newCV">Nộp CV mới</option>
																	</c:when>
																	<c:otherwise>
																		<option value="newCV">Nộp CV mới</option>
																	</c:otherwise>
																</c:choose>
															</select>
														</div>

														<div id="new-cv${vs.index}" style="display: none;">
															<label for="" class="col-form-label">Chọn CV:</label> <input
																id="new-cv-input${vs.index}" name="selectCV" type="file"
																accept="application/pdf" class="form-control" />
														</div>

														<c:if test="${currentUserCV != null}">
															<input type="hidden" name="cvId"
																value="${currentUserCV.id}" />
														</c:if>

														<div>
															<label for="intro" class="col-form-label">Giới
																thiệu:</label>
															<textarea class="form-control" name="intro"
																placeholder="Hãy giới thiệu về bạn"></textarea>
														</div>

														<div class="modal-footer">
															<button type="button" class="btn btn-secondary"
																data-bs-dismiss="modal">Close</button>
															<button type="submit" class="btn btn-primary">Ứng
																tuyển</button>
														</div>
													</form:form>

												</div>


											</div>
										</div>
									</div>
									<!-- End of Modal Apply Job -->
								</div>
							</security:authorize>

						</div>
					</c:forEach>
				</div>
				<div class="col-md-5">
					<h5>Công ty nổi bật</h5>
					<div class="row g-2">
						<c:forEach var="featuredCompany" items="${featuredCompanies}">
							<div class="col-4 text-center">
								<c:choose>
									<c:when test="${featuredCompany[0].logo eq ''}">
										<img
											src="<c:url value="/resources/images/default-image.png" />"
											width="100%" />
									</c:when>
									<c:otherwise>
										<img
											src="<c:url value="/resources/img-upload/${featuredCompany[0].logo}" />"
											width="100%" />
									</c:otherwise>
								</c:choose>
								
								<c:url var="companyDetailLink" value="/companyDetail">
									<c:param name="companyId" value="${featuredCompany[0].id}" />
								</c:url>
								<p class="m-0">
									<a href="${companyDetailLink}" class="h6">${featuredCompany[0].companyName}</a>
								</p>
								<p style="font-size: 13px">
									<span class="number">${featuredCompany[1]}</span> vị trí ứng
									tuyển
								</p>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
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

	<script>
		// select option: 'nop CV moi'
		function getTypeCV(selectObject, thisNewCVId, thisNewCVIdInput) {
			if (selectObject.value == 'newCV') {
				document.getElementById(thisNewCVId).style.display = 'block';
				document.getElementById(thisNewCVIdInput).setAttribute(
						"required", "");
			} else {
				document.getElementById(thisNewCVId).style.display = 'none';
				document.getElementById(thisNewCVIdInput).removeAttribute(
						"required");
			}
		}

		// check and submit search form
		function checkSearchInput() {
			const inputSearchJob = document.getElementById("search-job");
			const inputSearchPlace = document.getElementById("search-place");

			if (inputSearchJob.value === "" && inputSearchPlace.value === "") {
				alert("Bạn vui lòng nhập thông tin cần tìm kiếm!");
				return false;
			} else {
				return true;
			}
		}
	</script>

</body>
</html>
