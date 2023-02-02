<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- ############### LA Left ############### -->
 
			<li id="menu-area">
				<h1><a href="/index.do" target="_blank">홈페이지</a></h1>
						<c:set var="upperMenuNo" value="TOP"/>
						<c:set var="menuLevel" value="1"/>
						<c:set var="menuTypeNum" value="1"/>
						<c:set var="key1" value="${ upperMenuNo}_${menuLevel}"/>
						<c:if test="${not empty menuList[key1]}">
							<c:forEach var="menu1" items="${menuList[key1]}" varStatus="status">
							 
								<!-- S : depth-1 -->
								<dl class="menu-${menuTypeNum }">
								<c:set var="menuTypeNum" value="${menuTypeNum+1}"/>
								
									<dt id="dt_${menu1.menuId }">
										<c:choose>
											<c:when test="${'false' eq menu1.isLeaf}"><a id="a_${menu1.menuId }" href="#" >${menu1.menuTitle }</a></c:when>
											<c:otherwise><a id="a_${menu1.menuId }" <c:if test="${menu1.isLeaf eq 'true' }" >href="#"</c:if><c:if test="${menu1.isLeaf eq 'false' }" >href="${menu1.menuUrl}?menuId=${menu1.menuId}"</c:if> >${menu1.menuTitle }</a></c:otherwise>
										</c:choose>
									</dt>
									
									<c:set var="key2" value="${ menu1.menuId}_${menu1.menuDepth+1}"/>
									<c:choose>
											<c:when test="${not empty menuList[key2]}">
											<dd id="dd_${menu1.menuId }">
												<c:forEach var="menu2" items="${menuList[key2]}" varStatus="status2">												
													<dl class="depth-2">
														<!-- S : depth-2 -->
														<dt id="dt_${menu2.menuId }"><a id="a_${menu2.menuId }"  <c:if test="${menu2.isLeaf eq 'true' }" >href="#"</c:if><c:if test="${menu2.isLeaf eq 'false' }" >href="${menu2.menuUrl}?menuId=${menu2.menuId }"</c:if> >${menu2.menuTitle }</a></dt>
														
														<c:set var="key3" value="${ menu2.menuId}_${menu2.menuDepth+1}"/>
														<c:choose>
															<c:when test="${not empty menuList[key3]}">
																<dd id="dd_${menu2.menuId }">
																	<c:forEach var="menu3" items="${menuList[key3]}" varStatus="status3">
																		<dl class="depth-3">
																			<!-- S : depth-3 -->
																			<dt id="dt_${menu3.menuId }"><a id="a_${menu3.menuId }" href="${menu3.menuUrl}?menuId=${menu3.menuId }">${menu3.menuTitle }</a></dt>
																			<dd id="dd_${menu3.menuId }" class="hidden"></dd>
																		</dl>
																	</c:forEach>
																</dd>
															</c:when>
															<c:otherwise><dd class="hidden"></dd></c:otherwise>
														</c:choose>
													</dl>
												</c:forEach>
											</dd>
											</c:when>
											<c:otherwise><dd class="hidden"></dd></c:otherwise>
									</c:choose>
								</dl><!-- E : depth-1 -->
				
					
							</c:forEach>
						</c:if>
				 
			</li>

<script type="text/javascript">  
 
			<c:set var="leftMenuIdPathList" value="${fn:split(menuIdPathLeafNode, '@')}" />

			<c:forEach var="menuPath" items="${leftMenuIdPathList }" varStatus="status">
			$("#dt_${leftMenuIdPathList[status.index]}").addClass('on');
			$("#dd_${leftMenuIdPathList[status.index]}").addClass('on'); 
			</c:forEach>
			
			<c:if test="${not empty menuId}">
				$("#dt_${menuId}").addClass('on');
			</c:if>
			
			$(function(){
				// 타이틀변경시처리
			    // $(document).attr("title","""); 

			});
 
</script>
		
<!-- ############### // LA Left ############### -->