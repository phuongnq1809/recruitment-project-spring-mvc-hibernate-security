<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
	alert("Cập nhật thông tin thành công!");
	window.location = '${pageContext.request.contextPath}/employer/updateProfile?userId=${currentUser.id}';
</script>