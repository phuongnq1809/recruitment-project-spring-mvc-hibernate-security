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

<title>QP Works - List Recruitments By Company</title>
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
			<h3 class="text-center text-white">DANH SÁCH VIỆC LÀM HIỆN CÓ</h3>
			<h5 class="text-center text-white">Công ty:
				${company.companyName}</h5>
		</div>
	</section>

	<section class="p-5">
		<div class="container">

			<!-- DataTales -->
			<div class="card shadow mb-4">
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered tableCustomCss" id="dataTable"
							width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>Thông tin việc làm</th>
									<th>Hành động</th>
								</tr>
							</thead>

							<!-- hien thi du lieu tu model "listRecruitmentOfCompany" -->
							<c:forEach var="tempRecruitment" items="${listRecruitmentOfCompany}"
								varStatus="vs">

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
												<c:url var="recruitmentDetailLink"
													value="/recruitmentDetail">
													<c:param name="recruitmentId" value="${tempRecruitment.id}" />
												</c:url>
												<p>
													<a href="${recruitmentDetailLink}" class="h6">${tempRecruitment.title}</a>
												</p>
												<span class="fst-italic"> <i class="bi bi-building"></i>${tempRecruitment.getCompany().companyName}
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
												<button type="button" class="btn btn-primary btn-sm"
													data-bs-toggle="modal"
													data-bs-target="#applyJobModal${vs.index}">Apply
													Job</button>

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
																	Vị trí: <span>${tempRecruitment.title}</span>
																</h5>

																<form:form
																	action="applyJobProcess?${_csrf.parameterName}=${_csrf.token}"
																	method="post" enctype="multipart/form-data">

																	<input type="hidden" name="recruitmentId"
																		value="${tempRecruitment.id}" />
																	<input type="hidden" name="userId"
																		value="${currentUser.id}" />


																	<div>
																		<label class="col-form-label">CV:</label> <select
																			id="type-cv" name="typeCVSelect" class="form-select"
																			onchange="getTypeCV(this, 'new-cv${vs.index}','new-cv-input${vs.index}')">
																			<c:choose>
																				<c:when test="${userCV != null}">
																					<option value="updatedCV">Dùng CV đã cập
																						nhật</option>
																					<option value="newCV">Nộp CV mới</option>
																				</c:when>
																				<c:otherwise>
																					<option value="newCV">Nộp CV mới</option>
																				</c:otherwise>
																			</c:choose>
																		</select>
																	</div>

																	<div id="new-cv${vs.index}" style="display: none;">
																		<label for="" class="col-form-label">Chọn CV:</label>
																		<input id="new-cv-input${vs.index}" name="selectCV"
																			type="file" accept="application/pdf"
																			class="form-control" />
																	</div>

																	<c:if test="${userCV != null}">
																		<input type="hidden" name="cvId" value="${userCV.id}" />
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

											<div class="actions">
												<c:url var="saveJobLink" value="/candidate/saveJob">
													<c:param name="recruitmentId" value="${tempRecruitment.id}" />
													<c:param name="userId" value="${currentUser.id}" />
												</c:url>
												<c:url var="unSaveJobLink" value="/candidate/unSaveJob">
													<c:param name="recruitmentId" value="${tempRecruitment.id}" />
													<c:param name="userId" value="${currentUser.id}" />
												</c:url>

												<c:if
													test="${userSaveJobs == null || !userSaveJobs.contains(tempRecruitment.id)}">
													<a href="${saveJobLink}" class="btn btn-warning">Lưu</a>
												</c:if>

												<c:if test="${userSaveJobs.contains(tempRecruitment.id)}">
													<a href="${unSaveJobLink}" class="btn btn-warning">Hủy
														lưu</a>
												</c:if>

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
