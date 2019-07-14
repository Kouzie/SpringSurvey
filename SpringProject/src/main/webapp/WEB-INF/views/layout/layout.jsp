<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>Product Page - Admin HTML Template</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:400,700" />
<!-- https://fonts.google.com/specimen/Roboto -->
<link rel="stylesheet" href="/resources/css/fontawesome.min.css" />
<!-- https://fontawesome.com/ -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<!-- https://getbootstrap.com/ -->
<link rel="stylesheet" href="/resources/css/templatemo-style.css">
<!--
	Product Admin CSS Template https://templatemo.com/tm-524-product-admin
  -->
<script src="/resources/js/jquery-3.3.1.min.js"></script>
<!-- https://jquery.com/download/ -->
<script src="/resources/js/bootstrap.min.js"></script>
<!-- https://getbootstrap.com/ -->

<link rel="stylesheet" href="/resources/css/popup.css"/>
<script src="/resources/js/popup.js"></script>

<link rel="stylesheet" href="/resources/css/datepicker.css"/>
<script src="/resources/js/datepicker.js"></script>



<script>
    $(document).ready(function () {
      $(".tm-product-name").on("click", function () {
        window.location.href = "edit-product.html";
      });
    })
  </script>
</head>

<body id="reportsPage">

	<!-- header -->
	<tiles:insertAttribute name="header" />

	<!-- content -->
	<tiles:insertAttribute name="content" />

	<!-- footer -->
	<tiles:insertAttribute name="footer" />

</body>

</html>