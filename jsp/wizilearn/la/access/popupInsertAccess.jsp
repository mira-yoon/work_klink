<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%><%@
 taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
 taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
 taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ 
 taglib prefix="form" uri="http://www.springframework.org/tags/form" %><%@ 
 taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
 taglib prefix="double-submit" uri="http://www.egovframe.go.kr/tags/double-submit/jsp" %><%@
 page import="kr.co.wizi.wizilearn.comm.util.Config" %>
<c:set var="targetUrl" value="/la/access/"/> 
<script type="text/javascript">
<!--
	var targetUrl = "${targetUrl}";

	$(document).ready(function() {
		loadPage();
		 if ("" != "${retMsg}") {
		 	fn_read();
		 }
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

		$(".requare").css("color", "red");

	}

	/*====================================================================
	사용자 정의 함수 
	====================================================================*/

	/* 등록 */
	function fn_formSave(){
		if(!$("#accessIp").val()){
			alert("아이피를 입력하세요.");
			$("#accessIp").focus();
			return;
		}else	if(!$("#accessName").val()){
			alert("대상을 입력하세요.");
			$("#accessName").focus();
			return;
		}else{
			var reqUrl = CONTEXT_ROOT + targetUrl + "insertAccess";
	
			$("#frmMain").attr("method", "post" );
			$("#frmMain").attr("action", reqUrl);
			$("#frmMain").submit();
		}
	}
	
	/* 수정 */
	function fn_formUpdate(){

		if(!$("#accessIp").val()){
			alert("아이피를 입력하세요.");
			return;
		}else	if(!$("#accessName").val()){
			alert("대상을 입력하세요.");
			return;
		}else{
			var reqUrl = CONTEXT_ROOT + targetUrl + "updateAccess";
	
			$("#frmMain").attr("method", "post" );
			$("#frmMain").attr("action", reqUrl);
			$("#frmMain").submit();
		}
	}
	/* 삭제 */
	function fn_formDelete(){

		var reqUrl = CONTEXT_ROOT + targetUrl + "deleteAccess";

		$("#frmMain").attr("method", "post" );
		$("#frmMain").attr("action", reqUrl);
		$("#frmMain").submit();
	}
 
	  
	function fn_read(){
		opener.fn_search(1);
		parent.close();
	}
//-->
</script>
<div id="popup-wrarpr">
	<div id="popup-header">
		<h1><img src="/images/wizilearn/adm/inc/pop_border_02.png" alt="" />아이피등록</h1>
		<p><a href="#" onclick="parent.close();"></a></p>
	</div><!-- E : p-header -->
	
	<div id="popup-content-area">
		<div id="popup-container">


<p style="display:block; text-align:left; padding-bottom:5px; border-bottom: 2px solid #DADCE5;"><font color="red">*</font> 는 필수입력사항입니다.</p>

<form:form commandName="frmMain">  
<input type="hidden" id="comAccessId" name="comAccessId"  value="${comAccessVO.comAccessId }" />
<!-- 검색조건유지 필드 끝 -->
<table border="0" cellpadding="0" cellspacing="0" class="view-1">
    <colgroup>
      <col width="15%">
      <col width="*">
    </colgroup>
	<tbody>
		<tr>
			<th ><span class="requare">*</span>아이피</th>
			<td>
				<input  type="number"   id="accessIp" name="accessIp"  value="${comAccessVO.accessIp}" style="width:50%" />
			</td>
		</tr>
		<tr>	
			<th ><span class="requare">*</span>사용대상</th>
			<td>
				<input type="text" id="accessName" name="accessName"  value="${comAccessVO.accessName}" style="width:50%" />
			</td>
		</tr>
		 
	</tbody>
</table><!-- E : view-1 -->
</form:form>

<div class="page-btn">
<c:if test="${empty comAccessVO }" >
	<a href="#fn_formSave" onclick="javascript:fn_formSave();" onkeypress="this.onclick;">저장</a>
</c:if>	
<c:if test="${!empty comAccessVO }" >
	<a href="#fn_formSave" onclick="javascript:fn_formUpdate();" onkeypress="this.onclick;">수정</a>
	<a href="#fn_formSave" onclick="javascript:fn_formDelete();" onkeypress="this.onclick;">삭제</a>
</c:if>	
	<a href="#fn_formReset" onclick="parent.close();"  onkeypress="this.onclick;">닫기</a>
</div><!-- E : page-btn -->

		</div><!-- E : p-contentiner -->
	</div><!-- E : p-content-area -->
	<div id="popup-footer"></div><!-- E : p-footer -->
</div><!-- E : p-wrapper --> 