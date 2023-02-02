<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %> 
<%@ page import="org.apache.commons.lang3.time.DateUtils" %>
<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<%@ page import="kr.co.wizi.wizilearn.commbiz.util.BizUtil" %>
<%@ page import="kr.co.wizi.wizilearn.comm.service.Globals" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		
<!-- ############### LA Header ############### -->
		<dl id="top-area"> 
			<dt><span>ADMIN</span> mode</dt> 
			<dd class="info"><span><%=session.getAttribute(Globals.SESSION_USER_ID) %></span> 님 안녕하세요.<a href="/la/logout" class="logout">로그아웃</a></dd>
			<dd class="bg-1"></dd> 
			<dd class="bg-2"></dd> 
		</dl>
	
<!-- ############### // LA Header ############### -->