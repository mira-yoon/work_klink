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
		com.datepicker('ntceBgnde');
	    com.datepicker('ntceEndde'); 
	}
  
	/* save(등록) */
	function fn_save(  ){
		var pathId = $("#mainBannerType").val();
		
		if($("#mainBannerTitle").val() ==""){
			alert("제목을 입력하지 않았습니다.");
			$("#mainBannerTitle").focus();
			return false;
		}
		if($("#ntceBgnde").val() ==""){
			alert("기간을 입력하지 않았습니다.");
			$("#ntceBgnde").focus();
			return false;
		}
		if($("#ntceEndde").val() ==""){
			alert("기간을 입력하지 않았습니다.");
			$("#ntceEndde").focus();
			return false;
		}
		if($("#mainBannerLink").val() ==""){
			alert("링크를 입력하지 않았습니다.");
			$("#mainBannerLink").focus();
			return false;
		}
		if($("#file1").val() ==""){
			alert("파일첨부를 하지 않았습니다.");
			return false;
		}
		if (confirm("저장 하시겠습니까?")) {
			 
		    $("#frmBanner").attr("method", "post" );
			$("#frmBanner").attr("enctype", "multipart/form-data" );			
			
			var reqUrl = "/la/banner/"+pathId+"/goInsertBanner";
			$("#frmBanner").attr("action", reqUrl);
			$("#frmBanner").submit();
		}
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
<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" />
<input type="hidden" id="mainBannerType" name="mainBannerType" value="${pathBbsId }"/>
<div class="title-name-1">등록 페이지</div>
<p style="display:inline-block; text-align:left; margin-top:10px;"><font color="red">*</font> 는 필수입력사항입니다.</p>
 <!-- 내용 시작 -->
<table border="0" cellpadding="0" cellspacing="0" class="view-1">
		<tr>
			<th><font color="red">*</font>제목 </th>
			<td><input name="mainBannerTitle"  type="text" id="mainBannerTitle"  maxlength="50" value="" style="width:99%;"/> </td>
		</tr>
		
		<tr>
			<th><font color="red">*</font>기간 </th>
			<td>
				<input type="text"  name="ntceBgnde"  id="ntceBgnde"   value=""  /> 
				~<input  type="text"  name="ntceEndde"   id="ntceEndde"   value=""  />
			</td>
		</tr>
		   
		<tr>
			<th><font color="red">*</font>링크 </th>
			<td><input name="mainBannerLink"   id="mainBannerLink"    value="#"  style="width:99%;"/></td>
		</tr>
		<tr>
			<th><font color="red">*</font>타겟 </th>
			<td>
				<input type="radio" name="mainBannerTarget"    value="_self"  checked>본창
				<input type="radio" name="mainBannerTarget"  value="_blank" >새창
			</td>
		</tr>		 
		<tr>
			<th><font color="red">*</font>배너이미지</th>
			<td id="filelist">
			<input type="text" id="file1" style="width:50%;" readonly="readonly">
			<span style="display: inline;">
				<a href="#@" class="checkfile">파일선택</a>
				<input type="file" class="file_input_hidden"  id="atchFiles" name="atchFiles" class="text" value=""  accept="image/*"  title="첨부파일 입력" style="width:90%;" onChange="javascript:document.getElementById('file1').value=this.value"/> 
			</span>
			</td>
		</tr> 
</table>

<div class="point-textarea-1">
	※ 이미지 파일만 첨부 가능합니다. <br/>
	<c:if test="${pathBbsId eq 'big'}">※ 이미지 사이즈는  2000 X 625가 적합 합니다.</c:if>
	<c:if test="${pathBbsId eq 'sub'}">※ 이미지 사이즈는  231 X 230가 적합 합니다.</c:if>
	<c:if test="${pathBbsId eq 'rolling'}">※ 이미지 사이즈는  148 X 34가 적합 합니다.</c:if>
</div>

<!-- 내용 끝 --> 
<div class="page-btn">
	<a href="#fn_save" onclick="javascript:fn_save(); return false" onkeypress="this.onclick();">저장</a>
	<a href="#fn_list" onclick="javascript:fn_list(1); return false" onkeypress="this.onclick();">목록</a>
</div>
  
</form:form>
 