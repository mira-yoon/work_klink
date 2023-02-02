<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%><%@ 
page import="java.util.Date" %><%@ 
page import="java.util.Locale" %><%@ 
page import="org.apache.commons.lang3.time.DateUtils" %><%@ 
page import="org.apache.commons.lang.time.DateFormatUtils" %><%@ 
page import="kr.co.wizi.wizilearn.commbiz.util.BizUtil" %><%@ 
page import="kr.co.wizi.wizilearn.comm.vo.LoginInfo" %><%@ 
page import="kr.co.wizi.wizilearn.comm.service.Globals" %><%@ 
page import="kr.co.wizi.wizilearn.comm.vo.LoginVO" %><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ 
taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="Pragma" content="no-cache" /> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="keywords" content="K-LINK, 케이링크" />

	<title>K-LINK</title>

	<!-- 공통 css -->
	<link rel="stylesheet" href="/css/import.css" />
	<link rel="stylesheet" href="/css/jquery.bxslider.css" />
	<script type="text/javascript" src="/js/jquery-3.1.1.js"></script>
	<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="/js/jquery.bxslider.js"></script>
	<%@include file="/includeJs.jsp"%>

	<script type="text/javascript">
		$(document).ready(function () {
			$("nav ul li a").click(function () {
				$("nav li ul").removeClass("menu-on");
				$(this).next().addClass("menu-on");

			});
			$("nav ul li ul").mouseleave(function () {
				$("nav li ul").removeClass("menu-on");
			});
			
			$(".m-open").click(function () {
				$("nav").addClass("m-on");
				$(".m-bg").show();
			});

			$(".m-bg").click(function () {
				$("nav").removeClass("m-on");
				$(".m-bg").hide();
				$("nav li ul.menu-on").removeClass("menu-on");
			});
		});
	</script>
	<script type="text/javascript">
		//Controller에서  전달된 메시지를 출력한다.
		$(document).ready(function () {

			if ("" != "${retMsgEncode}") {
				alert(decodeURI('${retMsgEncode}'));
			} else if ("" != "${retMsg}") {
				alert("${retMsg}");
			} else if ("" != "${returnResultMap.retMsg}") {
				alert("${returnResultMap.retMsg}");
			}
		});
	</script>
</head>

<body>

	<!-- S: skip navigation -->
	<ul id="skip">
		<li><a href="#container">Skip to main content</a></li>
		<li><a href="#main-menu">Skip to main menu</a></li>
	</ul>
	<!-- //E: skip navigation -->

	<!-- S : wrapper -->
	<div id="wrapper">
		<!-- S : header --><tiles:insertAttribute name="header" /><!-- //E : header -->

		<!-- S : main-container -->
		<div class="box-area">
			<div id="container" tabindex="-1" style="outline:0;">
				<div id="sub-contents">
					<tiles:insertAttribute name="body" />
				</div>
			</div>
		</div>
		<!-- //E : main-container -->

		<!-- S : footer --><tiles:insertAttribute name="footer" /><!-- E : footer -->

	</div>
	<!-- //E : wrapper -->
</body>

</html>