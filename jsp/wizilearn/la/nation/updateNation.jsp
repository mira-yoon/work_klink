<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	$(document).ready(function(){
		//input 숫자만 허용
		$("input:text[numberonly]").on("keyup", function() {
	 	  $(this).val($(this).val().replace(/[^0-9]/g,""));
		});
	});
	
	function fn_validation(){
		var natName = $("#natName").val();
		var natNameKr = $("#natNameKr").val();
		var natStep = $("#natStep").val();
		var natScore = $("#natScore").val();
		
		if(natName == ''){
			alert("국가명(영문)을 입력해 주세요.");
			$("input[name=natName]").focus();
			return;
		}else if(natNameKr == ''){
			alert("국가명(국문)을 입력해 주세요.");
			$("input[name=natNameKr]").focus();
			return;
		}else if(natStep == ''){
			alert("정렬순서를 입력해 주세요.");
			$("input[name=natStep]").focus();
			return;
		}else if(natScore == ''){
			alert("배점을 입력해 주세요.");
			$("input[name=natScore]").focus();
			return;
		}
		fn_save();
	}
	
	function fn_save(){
		var reqUrl = "/la/nation/updateNation";
		$("#frmNation").attr("action", reqUrl);
		$("#frmNation").attr("target","_self");
		$("#frmNation").submit();
	}
	/* 리스트 조회 */
	function fn_search(){		 
		var reqUrl = "/la/nation/listNation";
		$("#frmNation").attr("action", reqUrl);
		$("#frmNation").attr("target","_self");
		$("#frmNation").submit();
	}
	/* 삭제 */
	function fn_delete(param){
		if(confirm("해당 글을 삭제하시겠습니까?")){
			$("#deleteYn").val("Y");
			var reqUrl = "/la/nation/updateNation";
			$("#frmNation").attr("action", reqUrl);
			$("#frmNation").attr("target","_self");
			$("#frmNation").submit();
		}
	}
</script>
<form id="frmNation" name="frmNation" method="post">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>" /> 
	<input type="hidden" id="natCd" name="natCd" value="${result.natCd }" />
	<input type="hidden" id="deleteYn" name="deleteYn" value="N" />
	<div class="title-name-1">국가관리 수정</div>
	<p style="display:inline-block; text-align:left; margin-top:10px;"><font color="red">*</font> 는 필수입력사항입니다.</p>
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th><font color="red">*</font>대륙구분</th>
				<td>
					<select id="partCd" name="partCd" style="width:180px; margin-right:30px;">
						<c:forEach var="partCdList" items="${partCdList}" varStatus="status">
							<option value="${partCdList.codeCode}" <c:if test="${partCdList.codeCode eq result.partCd}">selected</c:if>>${partCdList.codeName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th><font color="red">*</font>국가구분</th>
				<td>
					<select id="typeCd" name="typeCd" style="width:180px; margin-right:30px;">
						<c:forEach var="typeCdList" items="${typeCdList}" varStatus="status">
							<option value="${typeCdList.codeCode}" <c:if test="${typeCdList.codeCode eq result.typeCd}">selected</c:if>>${typeCdList.codeName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th><font color="red">*</font>국가명(영문)</th>
				<td><input type="text" id="natName" name="natName" value="${result.natName}" maxlength="40"/></td>
			</tr>
			<tr>
				<th><font color="red">*</font>국가명(국문)</th>
				<td><input type="text" id="natNameKr" name="natNameKr" value="${result.natNameKr}" maxlength="40"/></td>
			</tr>
			<tr>  
				<th><font color="red">*</font>정렬순서</th>
				<td><input type="text" id="natStep" name="natStep" numberOnly="" value="${result.natStep}"/></td>
			</tr> 
			<tr>  
				<th><font color="red">*</font>배점</th>
				<td><input type="text" id="natScore" name="natScore" numberOnly="" value="${result.natScore}"/></td>
			</tr>  
			<tr>
				<th><font color="red">*</font>상태</th>
				<td>
					<input type="radio" name="useYn" value="Y" <c:if test="${result.useYn eq 'Y'}">checked</c:if>/>공개
					<input type="radio" name="useYn" value="N" <c:if test="${result.useYn eq 'N'}">checked</c:if>/>비공개
				</td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="#!" onclick="fn_validation();">수정</a>
	<a href="#!" onclick="fn_delete();">삭제</a>
	<a href="#!" onclick="fn_search();">목록</a>
</div>