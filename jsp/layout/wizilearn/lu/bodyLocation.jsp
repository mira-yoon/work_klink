<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
			<c:set var="menuClassNm" value=""/>
			<c:set var="menuPathList" value="${fn:split(menuPathLeafNode, '@')}" />
			<c:set var="menuIdPathList" value="${fn:split(menuIdPathLeafNode, '@')}" />
			<c:set var="firstMenuPath" value=""/>
			<c:set var="nowMenuPath" value=""/>
<!-- ############### LU body location ########## -->

					<h2 id="page-title">
							<c:forEach var="menuPath" items="${menuPathList }" varStatus="status">
								<c:if test="${ status.first }">
									<c:out value="${menuPath}"/>
										<c:forEach var="menuIdPath" items="${menuIdPathList }" varStatus="status1">
											<c:if test="${ status1.first }"> 
												<c:set var="firstMenuPath" value="${menuIdPath}"/>
											</c:if>
										</c:forEach>
								</c:if>
							</c:forEach>
					</h2>
					<div id="page-location"><b>HOME</b>
						<c:forEach var="menuPath" items="${menuPathList }" varStatus="status">
									<c:choose>
										<c:when test="${ status.last }">
											<span><a href="#"  onclick="javascript:com.subPageMoveMenuLocation('','${menuIdPathList[status.index]}',false);" ><c:out value="${menuPath}"/></a></span>
											<c:set var="nowMenuPath" value="${menuIdPathList[status.index]}"/>
										</c:when>
										<c:otherwise>
											<span><c:out value="${menuPath}"/></span>
										</c:otherwise>
									</c:choose>
						</c:forEach>
					</div>
<c:set var="upperMenuNo" value="TOP"/>
<c:set var="menuLevel" value="1"/>
<c:set var="key1" value="${ upperMenuNo}_${menuLevel}"/>
						<c:if test="${not empty menuList[key1]}">
							<div id="lnb-tnb" class="notice">
							<c:forEach var="menu1" items="${menuList[key1]}" varStatus="status">
							<c:if test="${menu1.menuId ne '2017MENU0000022' }">
									<!-- S : depth-1  --> 
									<c:if test="${menu1.menuId eq firstMenuPath }">
										<c:set var="key2" value="${ menu1.menuId}_${menu1.menuLevel+1}"/>
										<c:choose>
											<c:when test="${not empty menuList[key2]}">
												<c:forEach var="menu2" items="${menuList[key2]}" varStatus="status2">
														<a id="hm_a_${menu2.menuId }" href="#"  <c:if test="${menu2.menuId eq nowMenuPath }">class="current" </c:if> onclick="javascript:com.subPageMove('${menu2.menuArea }', '${menu2.rootMenuId }', '${menu2.menuId }' , false);">${menu2.menuTitle }</a>
												</c:forEach>
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
									</c:if>
							</c:if>
							</c:forEach>
							</div>
						</c:if>
					<div id="lnb-wrap">
						<div id="lnb-prev" onclick="myScroll.scrollToPage('prev', 0);return false">prev</div>
						<div id="lnb-wrapper">
							<div id="scroller" class="notice">
								<ul id="thelist">
 						<c:set var="upperMenuNo" value="TOP"/>
						<c:set var="menuLevel" value="1"/>
						<c:set var="key1" value="${ upperMenuNo}_${menuLevel}"/>
						<c:if test="${not empty menuList[key1]}">
							<c:forEach var="menu1" items="${menuList[key1]}" varStatus="status">
									<c:if test="${menu1.menuId eq firstMenuPath }">
									 <c:choose>
											<c:when test="${menu1.menuId eq '2017MENU0000010' }">
																				<c:set var="menuClassNm" value="notice"/>
											</c:when>
											<c:when test="${menu1.menuId eq '2017MENU0000020' }">
																				<c:set var="menuClassNm" value="introduct"/>
											</c:when>
											<c:when test="${menu1.menuId eq '2017MENU0000021' }">
																				<c:set var="menuClassNm" value="member"/>
											</c:when>
											<c:when test="${menu1.menuId eq '2017MENU0000022' }">
																				<c:set var="menuClassNm" value="schedule"/>
											</c:when>
											<c:when test="${menu1.menuId eq '2017MENU0000100' }">
																				<c:set var="menuClassNm" value="etc"/>
											</c:when>
											<c:when test="${menu1.menuId eq '2017MENU0000140' }">
																				<c:set var="menuClassNm" value="introduct"/>
											</c:when>											
											<c:otherwise>
																				<c:set var="menuClassNm" value="etc"/>
											</c:otherwise>
										</c:choose>								
										<c:set var="key2" value="${ menu1.menuId}_${menu1.menuLevel+1}"/>
										<c:choose>
											<c:when test="${not empty menuList[key2]}">
												<c:forEach var="menu2" items="${menuList[key2]}" varStatus="status2">
													<!-- S : depth-2 -->
														<li <c:if test="${menu2.menuId eq nowMenuPath }">class="current" </c:if>><a id="hm_a_${menu2.menuId }" href="#"   onclick="javascript:com.subPageMove('${menu2.menuArea }', '${menu2.rootMenuId }', '${menu2.menuId }' , false);">${menu2.menuTitle }</a></li>
												</c:forEach>
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
										</c:if>									
							</c:forEach>
						</c:if> 								
								</ul>
							</div>
						</div>
						<div id="lnb-next" onclick="myScroll.scrollToPage('next', 0);return false">next</div>
  						<script type="text/javascript" src="/js/iscroll.js"></script>
						<script type="text/javascript">
							var myScroll;

							function loaded() {
								myScroll = new iScroll('lnb-wrapper', {
									snap: true,
									momentum: false,
									hScrollbar: false,
								});
							}
							document.addEventListener('DOMContentLoaded', loaded, false);
							
							 $(document).ready(function(){

									$(".notice").attr('class','${menuClassNm}');

							 });
						</script>
					</div>
 <!-- ############### // LU body location ########## -->
