<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>
<%@ page import="org.apache.commons.lang3.time.DateUtils" %>
<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<%@ page import="kr.co.wizi.wizilearn.commbiz.util.BizUtil" %>
<%@ page import="kr.co.wizi.wizilearn.comm.vo.LoginInfo" %>
<%@ page import="kr.co.wizi.wizilearn.comm.service.Globals" %>
<%@ page import="kr.co.wizi.wizilearn.comm.vo.LoginVO" %>
<%-- <%@ page import="kr.co.wizi.wizilearn.sys.menu.vo.MenuMngmVO" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- WIZILEARN Header -->
<!-- ############### LA Header ############### -->
<%
	LoginInfo loginInfo = new LoginInfo();
	if(loginInfo.isLogin()){

		String sessionLastLoginDt = session.getAttribute(Globals.SESSION_LAST_LOGIN_DT) + ""; // 최종 로그인 시간
		
%>
	<c:if test="${ empty menuList}">
			<dl id="top-area"> 
				<dt><span>ADMIN</span> mode</dt> 
				<dd class="info"><span><%=loginInfo.getUserName() %></span>님 안녕하세요. <a href="/commbiz/login/logout.do" class="logout">로그아웃</a></dd>
				<dd class="bg-1"></dd> 
				<dd class="bg-2"></dd> 
			</dl>	 
	</c:if> 					
	<c:if test="${not empty menuList}"> 					
 			<div id="header">
				<h1><a href="#" title="위지런 온라인교육시스템">위지런</a></h1>
			</div>

			<div id="gnb-pc" class="newgnb-menu-area newgnb-two-depth-area">
				<h2 class="hidden">전체메뉴</h2>
				<div class="newgnb-menu">
					<ul class="gnb-one-depth">
					
						<c:set var="upperMenuNo" value="TOP"/>
						<c:set var="menuLevel" value="1"/>
						<c:set var="key1" value="${ upperMenuNo}_${menuLevel}"/>
						<c:if test="${not empty menuList[key1]}">
							<c:forEach var="menu1" items="${menuList[key1]}" varStatus="status">
								<!-- S : depth-1 -->
								<li class="sel0${status.count }">

										<a id="hm_a_${menu1.menuId }" href="#" class="btn-slide" onclick="javascript:com.subPageMove('${menu1.menuArea }', '${menu1.rootMenuId }', '${menu1.menuId }' , false);">${menu1.menuTitle }<img src="/images/wizilearn/std/inc/blank.png" alt="" /></a>
										<c:set var="key2" value="${ menu1.menuId}_${menu1.menuLevel+1}"/>
										<c:choose>
											<c:when test="${not empty menuList[key2]}">
											<div class="list0${status.count } sell">
												<ul>
												<c:forEach var="menu2" items="${menuList[key2]}" varStatus="status2">
													<!-- S : depth-2 -->
														<li><a id="hm_a_${menu2.menuId }" href="#" onclick="javascript:com.subPageMove('${menu2.menuArea }', '${menu2.rootMenuId }', '${menu2.menuId }' , false);">${menu2.menuTitle }</a></li>
												</c:forEach>
												</ul>
											</div>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
								</li>
								
							</c:forEach>
						</c:if>
					
					</ul>
				</div>
			</div><!-- gnb -->
	</c:if>
	<%}else{ %>
		<dl id="top-area">
			<dt><span>ADMIN</span> mode</dt>
			<dd class="info"><a href="/lu/login/goUserLogin.do"></a></dd>
			<dd class="bg-1"></dd>
			<dd class="bg-2"></dd>
		</dl>			  
	<%} %>
	
<!-- ############### // LA Header ############### -->