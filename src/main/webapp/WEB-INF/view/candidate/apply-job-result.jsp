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
    <title>QP Works Apply Job</title>
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

    <!-- Apply Job Result -->
    <section class="bg-main-title p-5">
      <div class="container">
      	<c:if test="${applypost != null}">
        	<h5 class="text-center text-white">Chúc mừng bạn đã apply thành công! Vui lòng check email và điện thoại để nhận hồi đáp từ công ty. Chúc bạn thành công!</h5>
        </c:if>
        <c:if test="${msg_failure != null}">
        	<h5 class="text-center text-white">${msg_failure}</h5>
        </c:if>
        <p class="text-center"><a href="${pageContext.request.contextPath}" class="btn btn-warning">Trở lại trang chủ</a></p>
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
