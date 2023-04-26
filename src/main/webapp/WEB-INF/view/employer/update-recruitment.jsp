<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
      crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profile.css" />
    
    <title>QP Works - Update Recruitment</title>
    
  </head>
  <body>
    <!-- Header -->
    <section class="header">
      <div class="container p-2">
        <div class="d-flex align-items-center justify-content-between">
          <div class="logo"><a href="${pageContext.request.contextPath}/">Quang Phuong Works</a></div>
          
          <security:authorize access="hasRole('ROLE_USERS')">
          	<div>
            <a href="${pageContext.request.contextPath}/" class="btn-group me-4 text-light"> Trang chủ </a>
            <c:url var="employerListCandidateLink" value="/employer/listCandidate">
       		  <c:param name="userId" value="${currentUser.id}" />
       		</c:url>
            <a href="${employerListCandidateLink}" class="btn-group me-4 text-light">Ứng cử viên</a>
            <a href="${pageContext.request.contextPath}/employer/postRecruitment" class="btn btn-info me-2">Đăng tuyển</a>
            
            <div class="btn-group">
              <button
                type="button"
                class="btn btn-warning dropdown-toggle"
                data-bs-toggle="dropdown"
                aria-expanded="false"
              >
                ${currentUser.fullName}
              </button>
              <ul class="dropdown-menu">
              
              	<c:url var="employerProfileLink" value="/employer/updateProfile">
              		<c:param name="userId" value="${currentUser.id}" />
              	</c:url>
              	<li><a class="dropdown-item" href="${employerProfileLink}">Hồ sơ</a></li>
              	
              	<li>
                  <c:url var="recruitmentsManagementLink" value="/employer/recruitmentsManagement">
                  	<c:param name="employerId" value="${currentUser.id}"></c:param>
                  </c:url>
                  <a class="dropdown-item" href="${recruitmentsManagementLink}">Danh sách bài đăng</a>
	            </li>
                
                <li><hr class="dropdown-divider" /></li>
                
                <li>
	                <c:url value="/logout" var="logoutUrl" />
					<form id="logout" action="${logoutUrl}" method="post" >
					  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
                    <a class="dropdown-item" href="javascript:document.getElementById('logout').submit()"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a>
                </li>
                
              </ul>
             </div>
          	</div>
          </security:authorize>
          
        </div>
      </div>
    </section>

    <!-- Post Recruitment Title -->
    <section class="bg-main-title p-5">
      <div class="container">
        <h3 class="text-center text-white">CẬP NHẬT THÔNG TIN BÀI ĐĂNG</h3>
      </div>
    </section>

    <!-- Post Recruitment Form -->
    <section class="px-5 pt-2 pb-5">
      <div class="container px-5">
        <div class="row">
        	<div class="card mt-3">
        	  <div class="card-body">
        	  <h5>Chi tiết bài tuyển dụng</h5>
        	  <hr />
        	  
        	    <form:form action="updateRecruitmentProcess" method="post">
        	  	<div class="row">
        	  		
        	  		<input type="hidden" name="recruitmentId" value="${recruitmentUpdate.id}" />
        	  		
                    <div class="col-12">
                      <label for="title" class="col-form-label"
                        >Tiêu đề:</label
                      >
                      <input
                        type="text"
                        class="form-control"
                        id="title"
                        name="title"
                        value="${recruitmentUpdate.title}"
                        required
                      />
                    </div>
                    <div class="col-12">
                      <label for="desc" class="col-form-label"
                        >Mô tả công việc:</label
                      >
                      <textarea
                        class="form-control"
                        name="desc"
                      >${recruitmentUpdate.description}</textarea>
                    </div>
                    <div class="col-12">
                      <label for="experience" class="col-form-label"
                        >Kinh nghiệm:</label
                      >
                      <input
                        type="text"
                        class="form-control"
                        id="experience"
                        name="experience"
                        value="${recruitmentUpdate.experience}"
                        required
                      />
                    </div>
                    <div class="col-12">
                      <label for="quantity" class="col-form-label"
                        >Số người cần tuyển:</label
                      >
                      <input
                        type="number"
                        class="form-control"
                        id="quantity"
                        name="quantity"
                        value="${recruitmentUpdate.quantity}"
                        required
                      />
                    </div>
                    <div class="col-12">
                      <label for="address" class="col-form-label"
                        >Địa chỉ công ty:</label
                      >
                      <input
                        type="text"
                        class="form-control"
                        id="address"
                        name="address"
                        value="${recruitmentUpdate.address}"
                        required
                      />
                    </div>
                    <div class="col-12">
                      <label for="deadline" class="col-form-label"
                        >Hạn ứng tuyển:</label
                      >
                      <input
                        type="date"
                        class="form-control"
                        id="deadline"
                        name="deadline"
                        value="${recruitmentUpdate.deadline}"
                        required
                      />
                    </div>
                    <div class="col-12">
                      <label for="salary" class="col-form-label"
                        >Mức lương:</label
                      >
                      <input
                        type="text"
                        class="form-control"
                        id="salary"
                        name="salary"
                        value="${recruitmentUpdate.salary}"
                        required
                      />
                    </div>
                    <div class="col-12">
	                  <label for="" class="col-form-label">Loại công việc:</label>
	                  <select name="type" class="form-select" required>
	                    <option selected="selected" value="${recruitmentUpdate.type}">${recruitmentUpdate.type}</option>
	                    <c:forEach var="tempType" items="${types}">
	                    	<option value="${tempType}">${tempType}</option>
	                    </c:forEach>
	                  </select>
	                </div>
	                <div class="col-12">
	                  <label for="" class="col-form-label">Danh mục công việc:</label>
	                  <select name="category" class="form-select" required>
	                    <option selected="selected" value="${recruitmentUpdate.category.getId()}">${recruitmentUpdate.category.getCategoryName()}</option>
	                    <c:forEach var="tempCategory" items="${categories}">
	                    	<option value="${tempCategory.getId()}">${tempCategory.getCategoryName()}</option>
	                    </c:forEach>
	                  </select>
	                </div>
                  </div>

                  <div class="mt-3 text-center">
	                  <c:url var="recruitmentsManagementLink" value="/employer/recruitmentsManagement">
	                  	<c:param name="employerId" value="${currentUser.id}"></c:param>
	                  </c:url>
	                  <a class="btn btn-secondary" href="${recruitmentsManagementLink}">Back</a>
                      <button type="submit" class="btn btn-primary">Cập nhật</button>
                  </div>
                  
                  </form:form>
                  
        	  </div>
        	</div>          
        </div>
      </div>
      
    </section>

    <!-- Footer -->
    <footer class="bg-footer p-4 text-center text-dark position-relative">
      <div class="container">
        <span class="fst-italic">
          Copyright &copy; 2023 Quang Phuong Works | phuongnq1809@gmail.com |
          097.9189.790
        </span>
        <a href="#" class="position-absolute bottom-0 end-0 p-4">
          <i class="bi bi-arrow-up-circle h3"></i>
        </a>
      </div>
    </footer>

    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
      crossorigin="anonymous"
    ></script>
    
  </body>
</html>
