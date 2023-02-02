<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%

HashMap<String, Object> menuList = new HashMap<String,Object>();
menuList = (HashMap<String, Object>)session.getAttribute("menuList"); 

// 세션 정보등록
String menuPathLeafNode = (String)session.getAttribute("menuPathLeafNode");
String menuIdPathLeafNode =     (String)session.getAttribute("menuIdPathLeafNode");
pageContext.setAttribute("menuPathLeafNode",menuPathLeafNode);
pageContext.setAttribute("menuIdPathLeafNode",menuIdPathLeafNode);

%>
<style>a{color:#000000}</style>
			<c:set var="menuPathList" value="${fn:split(menuPathLeafNode, '@')}" />
			<c:set var="menuIdPathList" value="${fn:split(menuIdPathLeafNode, '@')}" />

<!-- ############### LA body location ########## -->
						<dl id="title">
							<dt>
							<c:forEach var="menuPath" items="${menuPathList }" varStatus="status">
								<c:if test="${ status.last }">
									<a href="#"  >${menuPath }</a>
								</c:if>
							</c:forEach>
							</dt>
							<dd>HOME<b>></b>
								<c:forEach var="menuPath" items="${menuPathList }" varStatus="status">
									<c:choose>
										<c:when test="${ status.last }">
											<a href="#"  >${menuPath }</a>
										</c:when>
										<c:otherwise>
											<a href="#"  >${menuPath }</a><b>></b>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</dd>
						</dl>
<!-- ############### // LA body location ########## -->
