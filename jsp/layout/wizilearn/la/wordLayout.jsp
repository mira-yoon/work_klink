<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
page import="java.util.Calendar"%><%@ page import="java.util.Date"%><%@ 
page import="java.text.DecimalFormat"%><%@ 
page import="java.text.SimpleDateFormat"%><%@ 
taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">	
	<%
		String wordFileName = (String)request.getAttribute("WordName");
 		wordFileName = new String(wordFileName.getBytes("EUC-KR"), "8859_1");
		String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date()).toString(); 
		response.setHeader("Content-Type","application/vnd.ms-word");
		response.setHeader("Content-Disposition", "attachment; filename="+wordFileName+"_"+toDay+".doc");
	%>
</head>
<body>
<tiles:insertAttribute name="body" />
</body>
</html>