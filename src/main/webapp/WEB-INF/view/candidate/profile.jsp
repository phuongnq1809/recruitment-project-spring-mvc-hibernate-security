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
	href="${pageContext.request.contextPath}/resources/css/profile.css" />

<title>QP Works - Candidate Profile</title>

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

	<!-- Profile Title -->
	<section class="bg-main-title p-5">
		<div class="container">
			<h3 class="text-center text-white">HỒ SƠ</h3>
			<p class="m-0 text-center">
				<c:choose>
					<c:when test="${userCandidate.image eq ''}">
						<img src="<c:url value="/resources/images/default-image.png" />"
							width="100" height="100" class="rounded-circle" />
					</c:when>
					<c:otherwise>
						<img
							src="<c:url value="/resources/img-upload/${userCandidate.image}" />"
							width="100" height="100" class="rounded-circle" />
					</c:otherwise>
				</c:choose>

			</p>
		</div>
	</section>

	<!-- Employer Profile Form -->
	<section class="px-5 pt-2 pb-5">
		<div class="container px-5">
			<div class="row">

				<!-- Thong tin ca nhan -->

				<form:form
					action="updateProfileProcess?${_csrf.parameterName}=${_csrf.token}"
					method="post" enctype="multipart/form-data">

					<div class="row">
						<div class="col-md-6">
							<h5>Cập nhật thông tin</h5>
							<p>Ảnh đại diện</p>
							<p class="m-0">
								<label for="img-input" class="img-input">Chọn ảnh</label> <input
									name="imgProfile" accept="image/*" type="file" id="img-input" />
								<br />
								<c:choose>
									<c:when test="${userCandidate.image eq ''}">
										<img
											src="<c:url value="/resources/images/default-image.png" />"
											width="75" height="75" id="img-preview" class="mt-2" />
									</c:when>
									<c:otherwise>
										<img
											src="<c:url value="/resources/img-upload/${userCandidate.image}" />"
											width="75" height="75" id="img-preview" class="mt-2" />
									</c:otherwise>
								</c:choose>
							</p>
						</div>
						<div class="col-md-6">
							<h5>Thông tin CV</h5>
							<c:choose>
								<c:when test="${userCV != null}">
									<p class="mb-1">
										Tên file CV hiện tại: <span class="fst-italic">${userCV.fileName}</span>
									</p>
									<a
										href="<c:url value="/resources/cv-upload/${userCV.fileName}" />"
										style="text-decoration: underline;">Download</a>
								</c:when>
								<c:otherwise>
									<p class="fst-italic">Bạn chưa có CV, hãy upload file!</p>
								</c:otherwise>
							</c:choose>

							<p class="mt-3">
								<input name="userCV" type="file" accept="application/pdf"
									class="form-control btn btn-outline-primary" id="formFile">
							</p>
						</div>


					</div>

					<div class="card mt-3">
						<div class="card-body">

							<input type="hidden" name="userId" value="${userCandidate.id}" />

							<div class="row">
								<div class="col-12">
									<label for="addemail" class="col-form-label">Email:</label>
									<input type="email" class="form-control" id="addemail"
										name="email" value="${userCandidate.email}" required />
								</div>
								<div class="col-12">
									<label for="addname" class="col-form-label">Họ
										và tên:</label> <input type="text" class="form-control" id="addname"
										name="name" value="${userCandidate.fullName}" required />
								</div>
								<div class="col-12">
									<label for="address" class="col-form-label">Địa
										chỉ:</label> <input type="text" class="form-control" id="address"
										name="address" value="${userCandidate.address}" required />
								</div>
								<div class="col-12">
									<label for="phone" class="col-form-label">Số
										điện thoại:</label> <input type="number" class="form-control"
										id="phone" name="phone" value="${userCandidate.phoneNumber}"
										required />
								</div>
								<div class="col-12">
									<label for="" class="col-form-label">Mô
										tả bản thân:</label>
									<textarea class="form-control" name="userdesc"
										placeholder="Hãy giới thiệu về bạn...">${userCandidate.description}</textarea>
								</div>
							</div>

							<div class="mt-3">
								<button type="submit" class="btn btn-primary">Lưu thông
									tin</button>
							</div>

						</div>
					</div>

				</form:form>

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
      // anh profile - preview
      const inputImg = document.getElementById("img-input");
      const image = document.getElementById("img-preview");

      inputImg.addEventListener("change", (e) => {
        if (e.target.files.length) {
          const src = URL.createObjectURL(e.target.files[0]);
          image.src = src;
        }
      });
      
    </script>
</body>
</html>
