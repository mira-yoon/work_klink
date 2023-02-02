<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	/* 타이틀 */
	$(document).ready(function () {
		$(document).attr("title", "Sitemap > Sitemap : K-LINK");
	});
</script>

<div id="sitemap">
	<div class="site-area">
		<c:set var="upperMenuNo" value="TOP" />
		<c:set var="menuLevel" value="1" />
		<c:set var="key1" value="${ upperMenuNo}_${menuLevel}" />
		<c:if test="${not empty menuList[key1]}">
			<c:forEach var="menu1" items="${menuList[key1]}" varStatus="status">
				<div class="sitemap-box">

					<span>${menu1.menuTitle }</span>
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

				<c:if test="${status.count == 4 }">
	</div>
	<div class="site-area">
		</c:if>
		<c:if test="${status.count == 8 }">
	</div>
	<div class="site-area">
		</c:if>
		</c:forEach>
		</c:if>
	</div>
</div><!-- E : sitemap -->