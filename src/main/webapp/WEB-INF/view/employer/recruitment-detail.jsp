<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
      crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css"
    />
    
    <link href="${pageContext.request.contextPath}/resources/datatables/sb-admin-2.min.css" rel="stylesheet"> 
    
    <link href="${pageContext.request.contextPath}/resources/datatables/dataTables.bootstrap4.min.css" rel="stylesheet"> 
    
    <link href="${pageContext.request.contextPath}/resources/datatables/tableCustomCss.css" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register.css" />
    
    <style type="text/css">
    	.title{
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
          <div class="logo"><a href="${pageContext.request.contextPath}">Quang Phuong Works</a></div>
          <security:authorize access="hasRole('ROLE_USERS')">
          	<div>
            <a href="${pageContext.request.contextPath}/" class="me-4 text-light"> Trang chủ </a>
            <c:url var="employerListCandidateLink" value="/employer/listCandidate">
       		  <c:param name="userId" value="${currentUser.id}" />
       		</c:url>
            <a href="${employerListCandidateLink}" class="me-4 text-light">Ứng cử viên</a>
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
	              		<img
			                src="<c:url value="/resources/images/default-image.png" />"
			                width="75"
			                height="75"
			                class="me-2"
			            />
	              	</c:when>
	              	<c:otherwise>
	              		<img
			                src="<c:url value="/resources/img-upload/${company.logo}" />"
			                width="75"
			                height="75"
			                class="me-2"
			            />
	              	</c:otherwise>
	              </c:choose>
	            <div>
	            	<h4 class="title">${recruitmentDetail.title}</h4>
	            	<span class="fst-italic">
	                  <i class="bi bi-building"></i>${company.companyName}
	                  <i class="bi bi-geo-alt ms-3"></i>${recruitmentDetail.address}
	                  <i class="bi bi-clock ms-3 me-1"></i>${recruitmentDetail.type}
	                </span>
	            </div>
        	</div>
        	<div class="col-md-4 d-flex align-items-center">
        		<c:url var="recruitmentsManagementLink" value="/employer/recruitmentsManagement">
                	<c:param name="employerId" value="${currentUser.id}"></c:param>
                </c:url>
                <a class="btn btn-success" href="${recruitmentsManagementLink}">Danh sách bài đăng</a>
        	</div>
        </div>
        <div class="row mt-3">
        	<div class="col-md-8">
        		<h6 class="title"><i class="bi bi-text-left"></i>Mô tả công việc</h6>
        		<div>${recruitmentDetail.description}</div>
        	</div>
        	<div class="col-md-4">
        		<div class="card summary">
        			<div class="card-body">
        				<h6 class="title"><i class="bi bi-bookmarks"></i>Tóm tắt công việc</h6>
        				<p><strong>Ngày tạo:</strong> ${recruitmentDetail.created}</p>
        				<p><strong>Kiểu công việc:</strong> ${recruitmentDetail.type}</p>
        				<p><strong>Danh mục công việc:</strong> ${recruitmentDetail.category.getCategoryName()}</p>
        				<p><strong>Kinh nghiệm:</strong> ${recruitmentDetail.experience}</p>
        				<p><strong>Địa chỉ:</strong> ${recruitmentDetail.address}</p>
        				<p><strong>Lương:</strong> ${recruitmentDetail.salary} vnd</p>
        				<p><strong>Số lượng:</strong> ${recruitmentDetail.quantity}</p>
        				<p><strong>Hạn ứng tuyển:</strong> ${recruitmentDetail.deadline}</p>
        			</div>
        		</div>
        	</div>
        </div>
        <div class="row mt-3 px-3">
        	<h4 class="text-center">Danh sách ứng cử viên ứng tuyển</h4>
        	
        	<c:choose>
        		<c:when test="${applyPosts == null}">
        			<p class="text-center fst-italic">Chưa có ứng cử viên nào ứng tuyển</p>
        		</c:when>
        		<c:otherwise>
        			<!-- DataTales -->
			        <div class="card">
			        	<div class="card-body">
			            	<div class="table-responsive">
			                    <table class="table table-bordered tableCustomCss" id="dataTable" width="100%" cellspacing="0">
			                       <thead>
			                           <tr>
			                                <th>Họ và tên</th>
			                                <th>Email</th>
			                                <th>Số điện thoại</th>
			                                <th>Địa chỉ</th>
			                                <th>Ảnh</th>
			                                <th>CV đã nộp</th>
			                                <th>Ngày ứng tuyển</th>
			                            </tr>
			                        </thead>
			                        
			                       	<!-- hien thi du lieu tu model "applyPosts" -->
			                       	<c:forEach var="tempApplyPost" items="${applyPosts}" varStatus="vs">
				                   		<tr>
				                   			<td>${tempApplyPost.getUser().getFullName()}</td>
				                   			<td>${tempApplyPost.getUser().getEmail()}</td>
				                   			<td>${tempApplyPost.getUser().getPhoneNumber()}</td>
				                   			<td>${tempApplyPost.getUser().getAddress()}</td>
				                   			<td>
				                   				<c:choose>
				                   					<c:when test="${tempApplyPost.getUser().image eq ''}">
				                   						<img
											                src="<c:url value="/resources/images/default-image.png" />"
											                width="50"
											                height="50"
										            	/>
				                   					</c:when>
				                   					<c:otherwise>
				                   						<img
											                src="<c:url value="/resources/img-upload/${tempApplyPost.getUser().image}" />"
											                width="50"
											                height="50"
										            	/>
				                   					</c:otherwise>
				                   				</c:choose>
								            </td>
				                   			<td><a href="<c:url value="/resources/cv-upload/${tempApplyPost.cvName}" />">Xem CV</a></td>
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
    
     <!-- Data Tables JavaScript-->
    <script src="${pageContext.request.contextPath}/resources/datatables/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/datatables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/datatables/dataTables.bootstrap4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/datatables/datatables-user-home.js"></script>
    
  </body>
</html>
