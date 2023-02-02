<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
page import="kr.co.wizi.wizilearn.comm.service.Globals" %><%@ 
page import="kr.co.wizi.wizilearn.comm.vo.LoginInfo" %><%@ 
page import="kr.co.wizi.wizilearn.comm.service.EgovProperties" %><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<section id="header" class="main-section-01">
	<div class="box-area">
		<h1><a href="/index.do"><img src="/images/common/logo.png" alt="K-LINK" /></a></h1>
		<div class="header-top">
			<%
			LoginInfo loginInfo = new LoginInfo();
    		if(loginInfo.isLogin()){
	    %>
			<ul>

				<li><i class="fa fa-user" aria-hidden="true"></i><span
						title="My id"><%=session.getAttribute(Globals.SESSION_USER_ID) %></span> <%
	    	  	if(session.getAttribute(Globals.AUTH_GROUP_ID) != null && session.getAttribute(Globals.AUTH_GROUP_ID).equals("UT01")){
	    	  %>
					<a href="<%=EgovProperties.getProperty("Globals.admin.main") %>">ADMIN</a>
					<%	
	    	  	}
	    	  %></li>
				<li>|</li>
				<li><a href="/lu/mypage/mydesk.do">My Desk</a></li>
				<li>|</li>
				<li><a href="/lu/mypage/myInfo.do">My Info</a></li>
				<li>|</li>
				<li><a href="/logout.do"><i class="fa fa-unlock" aria-hidden="true"></i>Logout</a></li>
				<li>|</li>
				<li><a href="/sitemap.do">Sitemap</a></li>
			</ul>
		</div>

		<%	
    		}else{
    		 %>
		<ul>
			<li><a href="/login.do">Sign In</a></li>
			<li>|</li>
			<li><a href="/stipulation.do">Sign Up</a></li>
			<li>|</li>
			<li><a href="/sitemap.do">Sitemap</a></li>
		</ul>
	</div>
	<%
    		}
    	%>
	<nav id="main-menu" tabindex="-1" style="outline:0;">
		<div class="menu-p">
			<h2 class="sr-only">Main Menu</h2>
			<ol>
				<c:set var="upperMenuNo" value="TOP" />
				<c:set var="menuLevel" value="1" />
				<c:set var="key1" value="${ upperMenuNo}_${menuLevel}" />
				<c:if test="${not empty menuList[key1]}">
					<c:forEach var="menu1" items="${menuList[key1]}" varStatus="status">
						<!-- S : depth-1 -->
						<c:if test="${menu1.menuViewTypeCode eq '2016CCOD0000011' }">
							<li class="cls-${status.count}" onMouseLeave="mOut();">
								<a href="#" class="menu-0${status.count}" onMouseEnter="mOver('${status.count}');"
									onfocus="mOver('${status.count}');">${menu1.menuTitle
									}</a>
								<!--  S : depth-2 -->
								<div class="sub-menu">
									<ul id="childNum${status.count}" class="childNumCla">
										<c:set var="key2" value="${ menu1.menuId}_2" />
										<c:choose>
											<c:when test="${not empty menuList[key2]}">
												<c:forEach var="menu2" items="${menuList[key2]}" varStatus="status2">
													<li><a href="${menu2.menuUrl }"><span>${menu2.menuTitle }</span></a></li>
												</c:forEach>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</ul>
								</div>
							</li>
						</c:if>
					</c:forEach>
				</c:if>
			</ol>
		</div>
		<!-- E : PC Menu -->

		<div class="fa fa-bars btn-menu-m " title="Show menu"><span class="ir_so">Show menu</span></div>
		<!-- E : Mobile Button -->

		<div class="menu-m">
			<div class="top-area"><a href="/" class="logo-m"><img src="/images/common/logo.png" alt="K-LINK" /></a></div>
			<div class="fa fa-times-circle menu-close"></div>
			<ul>
				<c:set var="upperMenuNo" value="TOP" />
				<c:set var="menuLevel" value="1" />
				<c:set var="key1" value="${ upperMenuNo}_${menuLevel}" />
				<c:if test="${not empty menuList[key1]}">
					<c:forEach var="menu1" items="${menuList[key1]}" varStatus="status">
						<!-- S : depth-1 -->
						<c:if test="${menu1.menuViewTypeCode eq '2016CCOD0000011' }">
							<li>
								<a href="#" class="menu-0${status.count}" onclick="subMenuOn('${status.count}');">${menu1.menuTitle
									}</a>
								<!-- S : depth-2 -->
								<div class="sub-menu">
									<div class="subMenu${status.count} subMenu" style="display: none;">
										<ul>
											<c:set var="key2" value="${ menu1.menuId}_2" />
											<c:choose>
												<c:when test="${not empty menuList[key2]}">
													<c:forEach var="menu2" items="${menuList[key2]}" varStatus="status2">
														<li><a href="${menu2.menuUrl }">${menu2.menuTitle }</a></li>
													</c:forEach>
												</c:when>
												<c:otherwise></c:otherwise>
											</c:choose>
										</ul>
									</div>
								</div>
							</li>
						</c:if>
					</c:forEach>
				</c:if>
			</ul>
		</div>
		<!-- E : Mobile Menu -->
	</nav>
	</div> <!-- E: box-area -->
</section>

<script>
	$(document).ready(function () {

		$(".sub-menu li:last-child a").on('blur', function () {
			$(".sub-menu").css("display", "none");
		});
	});

	function mOver(num) {
		const idName = "childNum" + num;
		const ele = document.getElementById(idName);
		const eleCount = ele.childElementCount;
		const claN = ".cls-" + num + " div.sub-menu";
		const item = $(claN);
		if (eleCount <= 1) {
			item.css({
				display: 'none'
			});
		} else {
			item.css({
				display: 'block'
			});
		}
	};

	$('.menu-02').click(function () {
		const link_url = "https://klink.or.kr/lu/notice/listBbs";
		location.replace(link_url);
	});

	function mOut() {
		const item = $(".sub-menu");
		item.css({
			display: 'none'
		});
	}

	$(".btn-menu-m").click(function () {
		$("nav div.menu-m").addClass("menu-on")
	});

	$(".menu-close").click(function () {
		$("nav div.menu-m").removeClass("menu-on")
		$(".menu-m div.sub-menu").hide();
	});

	function subMenuOn(num) {
		$(".menu-m div.sub-menu").show();
		const claName = "subMenu" + num;
		const claNameNum = document.getElementsByClassName(claName);
		$(".menu-m div.sub-menu div.subMenu").hide();
		claNameNum[0].style.display = "block";
	};
</script>
