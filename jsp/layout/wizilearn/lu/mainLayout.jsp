<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%><%@ 
taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%><!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="Pragma" content="no-cache" /> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="keywords" content="K-LINK, 케이링크" />
<meta name="google-site-verification" content="jEQiMf_wg3McL-HCk2fiG54kPJ7jkNw8eqf54JQrYl8" />

<title>K-LINK</title>

<!-- 공통 css -->
<link rel="stylesheet" href="/css/import.css" />
<link rel="stylesheet" href="/css/jquery.bxslider.css" />
<script type="text/javascript" src="/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/js/jquery.bxslider.js"></script>
 
<script type="text/javascript">
	// Controller에서  전달된 메시지를 출력한다.
	$(document).ready(function(){

		if(""!="${retMsgEncode}"){
			alert(decodeURI('${retMsgEncode}') );
		}else if ("" != "${retMsg}") {
			alert("${retMsg}");
		}else if ("" != "${returnResultMap.retMsg}") {
			alert("${returnResultMap.retMsg}");
		}
	});
</script>
</head>
<body class="body-scroll">	

	<!-- S: skip navigation -->
	<ul id="skip">
		<li><a href="#container">Skip to main content</a></li>
		<li><a href="#main-menu">Skip to main menu</a></li>
	</ul>
	<!-- //E: skip navigation -->

	<!-- S : wrapper -->
	<div id="wrapper">
		<!-- S : header --><tiles:insertAttribute name="header" /><!-- //E : header -->	
		<!-- S : main-container --><tiles:insertAttribute name="body" /><!-- //E : main-container -->
		<!-- S : footer --><tiles:insertAttribute name="footer" /><!-- //E : footer -->
	</div>
	<!-- //E : wrapper -->
</body>
</html>
