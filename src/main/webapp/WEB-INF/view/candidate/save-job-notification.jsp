<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script>
	alert("${msgAlert}");
	window.location = '${pageContext.request.contextPath}/candidate/listSaveJobs?userId=${currentUser.id}';
</script>