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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register.css" />
    <title>QP Works Registration</title>
  </head>
  <body>
    <!-- Header -->
    <section class="header">
      <div class="container p-2">
        <div class="d-flex align-items-center justify-content-between">
          <div class="logo"><a href="${pageContext.request.contextPath}">Quang Phuong Works</a></div>
        </div>
      </div>
    </section>

    <!-- Registration Title -->
    <section class="bg-main-title p-5">
      <div class="container">
        <h3 class="text-center text-white">ĐĂNG KÝ THÀNH VIÊN</h3>
      </div>
    </section>

    <!-- Registration Form -->
    <section class="p-5">
      <div class="container">
        <div class="row">
          <div class="col-md-7">
            <img src="${pageContext.request.contextPath}/resources/images/register.jpg" width="100%" />
          </div>
          <div class="col-md-5">
            <form:form action="${pageContext.request.contextPath}/register/processForm" method="POST">
              <div class="row">
                <div class="col-12">
                  <label for="addemail" class="col-form-label">Email:</label>
                  <input
                    type="email"
                    class="form-control"
                    id="addemail"
                    name="email"
                    required
                  />
                </div>
                <div class="col-12">
                  <label for="addname" class="col-form-label">Họ và tên:</label>
                  <input
                    type="text"
                    class="form-control"
                    id="addname"
                    name="name"
                    required
                  />
                </div>
                <div class="col-12">
                  <label for="addPassword" class="col-form-label"
                    >Mật khẩu:</label
                  >
                  <input
                    type="password"
                    class="form-control"
                    id="addPassword"
                    name="password"
                    required
                  />
                </div>
                <div class="col-12">
                  <label for="addPasswordConfirm" class="col-form-label"
                    >Nhập lại mật khẩu:</label
                  >
                  <input
                    type="password"
                    class="form-control"
                    id="addPasswordConfirm"
                    name="passwordConfirm"
                    required
                  />
                </div>
                <div class="col-12">
                  <label for="addRole" class="col-form-label">Vai trò:</label>
                  <select name="role" class="form-select" required>
                    <option value="">Chọn vai trò</option>
                    <option value="1">Ứng viên</option>
                    <option value="2">Công ty</option>
                  </select>
                </div>
              </div>
              <c:if test="${error_msg != null}">
              	<div class="alert alert-danger col-xs-offset-1 col-xs-10 mt-4">
                	${error_msg}
              	</div>
              </c:if>
              
              <div class="mt-5">
                <button type="reset" class="btn btn-secondary">Hủy</button>
                <button type="submit" class="btn btn-primary">Đăng ký</button>
              </div>
            </form:form>
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
