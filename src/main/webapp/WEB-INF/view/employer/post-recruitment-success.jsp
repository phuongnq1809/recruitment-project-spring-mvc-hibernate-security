<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
	alert("Đăng tin tuyển dụng thành công!");
	window.location = '${pageContext.request.contextPath}/employer/recruitmentsManagement?employerId=${currentUser.id}';
</script>