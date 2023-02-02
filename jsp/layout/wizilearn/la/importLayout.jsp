<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><% 
	String contextRootJS = request.getContextPath();
%><link rel="stylesheet" type="text/css" href="${contextRootJS }/js/jquery-ui.css" />
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
 <!-- //includeJs --><tiles:insertAttribute name="body" />