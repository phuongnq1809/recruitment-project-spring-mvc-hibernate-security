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

<style type="text/css">
.title {
	color: #007cb9;
}

.summary {
	background-color: #f3f3f3;
	font-size: 14px;
}

.summary p {
	margin: 10px auto;
}
</style>

<title>QP Works - Recruitment Detail</title>
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
												href="${candidateListApplyJobLink}">Việc làm đã ứng
													tuyển</a></li>
										</ul></li>
								</ul>
							</div>

						</security:authorize>

						<security:authorize access="hasRole('ROLE_CONGTY')">
							<c:url var="employerListCandidateLink"
								value="/employer/listCandidate">
								<c:param name="userId" value="${currentUser.id}" />
							</c:url>
							<a href="${employerListCandidateLink}"
								class="btn-group me-4 text-light">Ứng cử viên</a>
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

	<section class="bg-main-title p-5">
		<div class="container">
			<h3 class="text-center text-white">CHI TIẾT CÔNG VIỆC</h3>
		</div>
	</section>

	<section class="px-5 pb-5 pt-3">
		<div class="container">
			<div class="row">
				<div class="col-md-8 d-flex align-items-center">
					<c:choose>
						<c:when test="${company.logo eq ''}">
							<img src="<c:url value="/resources/images/default-image.png" />"
								width="75" height="75" class="me-2" />
						</c:when>
						<c:otherwise>
							<img
								src="<c:url value="/resources/img-upload/${company.logo}" />"
								width="75" height="75" class="me-2" />
						</c:otherwise>
					</c:choose>
					<div>
						<h4 class="title">${recruitmentDetail.title}</h4>
						<span class="fst-italic"> <i class="bi bi-building"></i>${company.companyName}
							<i class="bi bi-geo-alt ms-3"></i>${recruitmentDetail.address} <i
							class="bi bi-clock ms-3 me-1"></i>${recruitmentDetail.type}
						</span>
					</div>
				</div>
				<div class="col-md-4 d-flex align-items-center">

					<security:authorize access="hasRole('ROLE_UNGVIEN')">
						<div class="apply">
							<button type="button" class="btn btn-primary btn-sm"
								data-bs-toggle="modal" data-bs-target="#applyJobModal">Apply
								Job</button>

							<!-- luu va huy luu cong viec danh cho ung vien -->
							<c:url var="saveJobLink" value="/candidate/saveJob">
								<c:param name="recruitmentId" value="${recruitmentDetail.id}" />
								<c:param name="userId" value="${currentUser.id}" />
							</c:url>
							<c:url var="unSaveJobLink" value="/candidate/unSaveJob">
								<c:param name="recruitmentId" value="${recruitmentDetail.id}" />
								<c:param name="userId" value="${currentUser.id}" />
							</c:url>

							<c:if
								test="${currentUserSaveJobs == null || !currentUserSaveJobs.contains(recruitmentDetail.id)}">
								<a href="${saveJobLink}" class="btn btn-warning btn-sm">Lưu</a>
							</c:if>

							<c:if
								test="${currentUserSaveJobs.contains(recruitmentDetail.id)}">
								<a href="${unSaveJobLink}" class="btn btn-warning btn-sm">Hủy
									lưu</a>
							</c:if>

							<!-- Modal Apply Job -->
							<div class="modal fade" id="applyJobModal" tabindex="-1"
								aria-labelledby="applyJobModalLabel" aria-hidden="true">
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
												Vị trí: <span>${recruitmentDetail.title}</span>
											</h5>

											<form:form
												action="candidate/applyJobProcess?${_csrf.parameterName}=${_csrf.token}"
												method="post" enctype="multipart/form-data">

												<input type="hidden" name="recruitmentId"
													value="${recruitmentDetail.id}" />
												<input type="hidden" name="userId" value="${currentUser.id}" />


												<div>
													<label class="col-form-label">CV:</label> <select
														id="type-cv" name="typeCVSelect" class="form-select"
														onchange="getTypeCV(this, 'new-cv','new-cv-input')">
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

												<div id="new-cv" style="display: none;">
													<label for="" class="col-form-label">Chọn CV:</label> <input
														id="new-cv-input" name="selectCV" type="file"
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
			</div>
			<div class="row mt-3">
				<div class="col-md-8">
					<h6 class="title">
						<i class="bi bi-text-left"></i>Mô tả công việc
					</h6>
					<div>${recruitmentDetail.description}</div>
				</div>
				<div class="col-md-4">
					<div class="card summary">
						<div class="card-body">
							<h6 class="title">
								<i class="bi bi-bookmarks"></i>Tóm tắt công việc
							</h6>
							<p>
								<strong>Ngày tạo:</strong> ${recruitmentDetail.created}
							</p>
							<p>
								<strong>Kiểu công việc:</strong> ${recruitmentDetail.type}
							</p>
							<p>
								<strong>Danh mục công việc:</strong>
								${recruitmentDetail.category.getCategoryName()}
							</p>
							<p>
								<strong>Kinh nghiệm:</strong> ${recruitmentDetail.experience}
							</p>
							<p>
								<strong>Địa chỉ:</strong> ${recruitmentDetail.address}
							</p>
							<p>
								<strong>Lương:</strong> ${recruitmentDetail.salary} vnd
							</p>
							<p>
								<strong>Số lượng:</strong> ${recruitmentDetail.quantity}
							</p>
							<p>
								<strong>Hạn ứng tuyển:</strong> ${recruitmentDetail.deadline}
							</p>
						</div>
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

	<!-- Data Tables JavaScript-->
	<script
		src="${pageContext.request.contextPath}/resources/datatables/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/datatables/jquery.dataTables.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/datatables/dataTables.bootstrap4.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/datatables/datatables-user-home.js"></script>

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
	</script>

</body>
</html>
