<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
