<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><% 
	String contextRootJS = request.getContextPath();
%><!DOCTYPE html >
<html  lang="ko"  >
	<head>
		<title>관리자 화면 : <tiles:insertAttribute name="title" /></title>
		<link rel="stylesheet" type="text/css" href="${contextRootJS }/css/font.css" />
		<script type="text/javascript" src="${contextRootJS }/js/webfont.js"></script>
		<script type="text/javascript">
		<!--
			WebFont.load({
				custom: {
					families: ['nbgM', 'play']
				}
			});
		//-->
		</script>

		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="keywords" content="K-LINK">
		<meta name="description" content="K-LINK">
		<script type="text/javascript">
			var CONTEXT_ROOT = "${contextRootJS }";
		</script>

		<link rel="stylesheet" type="text/css" href="${contextRootJS }/css/adm_login.css" />

		<link rel="stylesheet" type="text/css" href="${contextRootJS }/js/jquery-ui.css" />
		<link rel="stylesheet" type="text/css" href="${contextRootJS }/js/jquery-ui.min.css" />
		
		<script type="text/javascript" src="${contextRootJS }/js/jquery-3.1.1.min.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/jquery-common.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/jquery-ui.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/popup.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/jquery-admin.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/jquery-latest.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/jquery-3.1.1.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/jquery-ui.min.js"></script>		
		<script type="text/javascript" src="${contextRootJS }/js/jquery.maskedinput.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/common.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/jquery.blockUI.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/webfont.js"></script>
		<script type="text/javascript" src="${contextRootJS }/js/wizi/FusionCharts.js"></script> 
 		<!-- //includeJs -->
		
		<script type="text/javascript">
		
			//Controller에서  전달된 메시지를 출력한다.
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
<body>
<!-- ###############  loginLayout ############### -->
			<!-- S : body --><tiles:insertAttribute name="body" /><!-- E : body -->
<!-- ###############  loginLayout ############### -->
 </body>
</html>