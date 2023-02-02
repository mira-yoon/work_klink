<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %>
<c:set var="targetUrl" value="/la/main/mainbanner/"/>

<script type="text/javascript">
<!--
	$(document).ready(function() {
		loadPage();
	});
	/*====================================================================
		화면 초기화 
	====================================================================*/
	function loadPage() {
		initEvent();
		initHtml();
	}


	/* 각종 버튼에 대한 액션 초기화 */
	function initEvent() {
	}

	/* 화면이 로드된후 처리 초기화 */
	function initHtml() { 	     
	}
  
	/* 수정페이지 */
	function fn_save(  ){ 
		var pathId = $("#mainBannerType").val();
		var reqUrl = "/la/banner/"+pathId+"/updateBanner";
		$("#frmBanner").attr("action", reqUrl);
		$("#frmBanner").submit(); 
	}
	
	/* 목록 */
	function fn_list(pageNo){
		var pathId = $("#mainBannerType").val();
		$("#pageIndex").val( pageNo );

		var reqUrl = "/la/banner/"+pathId+"/listBanner";
		$("#frmBanner").attr("action", reqUrl);
		$("#frmBanner").submit();
	}
//-->
</script> 
<form:form commandName="frmBanner"> 
<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>">
<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${pageIndex}'/>">
<input type="hidden" id="mainBannerId" name="mainBannerId" value="${comMainBannerVO.mainBannerId }"  />
<input type="hidden" id="mainBannerType" name="mainBannerType" value="${pathBbsId }"/>
<div class="title-name-1">상세보기 페이지</div>
<!-- 내용 시작 -->
<table border="0" cellpadding="0" cellspacing="0" class="view-1">
 
		<tr>
			<th>제목 </th>
			<td>${comMainBannerVO.mainBannerTitle }</td>
		</tr>
		
		<tr>
			<th>기간 </th>
			<td>
			${comMainBannerVO.ntceBgnde }~
			${comMainBannerVO.ntceEndde }
			</td>
		</tr>
		   
		<tr>
			<th>링크 </th>
			<td>
				${comMainBannerVO.mainBannerLink }
			</td>
		</tr>
		<tr>
			<th>타겟 </th>
			<td>
				<c:if test="${ '_self' == comMainBannerVO.mainBannerTarget }">본창</c:if>
				<c:if test="${ '_blank' == comMainBannerVO.mainBannerTarget }">새창</c:if> 
			</td>
		</tr>		 
		<tr>
			<th>이미지</th>
			<td id="filelist">	
			<c:if test="${!empty comMainBannerVO.saveFileName}">	 
				<img src="/la/banner/${pathBbsId }/getImage?mainBannerId=${comMainBannerVO.mainBannerId }" <c:if test="${pathBbsId eq 'big' }">style="width:800px;"</c:if> />
			</c:if>
			</td>
		</tr> 
</table>
<!-- 내용 끝 --> 
<div class="page-btn">
	<a href="#fn_save" onclick="javascript:fn_save(); return false" onkeypress="this.onclick();">수정</a>
	<a href="#fn_list" onclick="javascript:fn_list(1); return false" onkeypress="this.onclick();">목록</a>
</div>
  
</form:form>
 