<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
<!--
$(document).ready(function() {
	initHtml();	
});

function initHtml() {

		com.datepicker('scDay'); 

}
/* HTML Form 신규, 수정 */
function fn_save(){
	var scSection = $("#scSection").val();
	if (fn_formValidate()) {
		
		var reqUrl =  "/la/schedule/"+scSection+"/updateSchedule";
		
		$("#frmSchedule").attr("action", reqUrl);
		$("#frmSchedule").submit();
	}
}
/* 취소 */
function fn_backList(){
	var scSection = $("#scSection").val();
	var reqUrl =  "/la/schedule/"+scSection+"/listSchedule";
	
	$("#frmSchedule").attr("action", reqUrl);
	$("#frmSchedule").submit();
}


/*
* 화면 유효성 첵크
*/
function fn_formValidate() {

	if( com.isBlank( $("#scType").val() ) ){
		alert("일정구분을 선택하세요.");
		return false;
	}
	if(!document.frmSchedule.title.value){
		alert(" 제목을 입력하세요.");
		return false;
	}
	if( com.isBlank( $("#scDay").val() ) ){
		alert(" 일자를 입력하세요.");
		return false;
	}
	if( com.isBlank( $("#location").val() ) ){
		alert(" 장소를 입력하세요.");
		return false;
	}
	if( com.isBlank( $("#content").val() ) ){
		alert(" 내용을 입력하세요.");
		return false;
	}
	return true;
}
//-->
</script>

<form id="frmSchedule" method="post" name="frmSchedule">
	<input type="hidden" id="scSeq" name="scSeq" value="${result.scSeq }"/>
	<input type="hidden" id="scSection" name="scSection" value="${pathBbsId}"/>
	<c:if test="${pathBbsId eq 'meeting'}">
		<input type="hidden" id="scType" name="scType" value="M"/>
		<input type="hidden" id="location" name="location" value="NIPA 회의실"/>
		<input type="hidden" id="content" name="content" value="StartUp 회의"/>
	</c:if>
	<div class="title-name-1">일정 수정</div>
	<p style="display:inline-block; text-align:left; margin-top:10px;"><font color="red">*</font> 는 필수입력사항입니다.</p>
	<table border="0" cellpadding="0" cellspacing="0" class="view-1">
		<tbody>
			<c:if test="${pathBbsId eq 'calendar'}">
				<tr>
					<th><font color="red">*</font>일정구분</th>
					<td>
						<select name="scType"  id="scType" title="일정 구분" style="width:30%;"> 
							<option value="">= 선택 =</option>
							<c:forEach var="codeList" items="${codeList }" varStatus="status">
								<option value="${codeList.codeCode }" class="choice" <c:if test="${result.scType == codeList.codeCode}">selected</c:if>/><label>${codeList.codeName }</label>
							</c:forEach>
						</select>
					</td>
				</tr>
			</c:if>
			<tr>
				<th>
					<c:if test="${pathBbsId eq 'calendar'}"><font color="red">*</font>제목</c:if>
					<c:if test="${pathBbsId eq 'meeting'}"><font color="red">*</font>예약자</c:if>
				</th>
				<td><input type="text" name="title" value="${result.title }" style="width:100%;"/></td>
			</tr>
			<tr>
				<th><font color="red">*</font>일자</th>
				<td>
					<input type="text"  name="scDay"  id="scDay"  style="width:20%;"  value="${result.scDay }"  readonly  title="일자" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<select name="startTime" title="시작 시간" >
						<option value="07:00" <c:if test="${result.startTime eq '07:00'}">selected</c:if> >07:00</option>
						<option value="08:00" <c:if test="${result.startTime eq '08:00'}">selected</c:if> >08:00</option>
						<option value="09:00" <c:if test="${result.startTime eq '09:00'}">selected</c:if> >09:00</option>
						<option value="10:00" <c:if test="${result.startTime eq '10:00'}">selected</c:if> >10:00</option>
						<option value="11:00" <c:if test="${result.startTime eq '11:00'}">selected</c:if> >11:00</option>
						<option value="12:00" <c:if test="${result.startTime eq '12:00'}">selected</c:if> >12:00</option>
						<option value="13:00" <c:if test="${result.startTime eq '13:00'}">selected</c:if> >13:00</option>
						<option value="14:00" <c:if test="${result.startTime eq '14:00'}">selected</c:if> >14:00</option>
						<option value="15:00" <c:if test="${result.startTime eq '15:00'}">selected</c:if> >15:00</option>
						<option value="16:00" <c:if test="${result.startTime eq '16:00'}">selected</c:if> >16:00</option>
						<option value="17:00" <c:if test="${result.startTime eq '17:00'}">selected</c:if> >17:00</option>
						<option value="18:00" <c:if test="${result.startTime eq '18:00'}">selected</c:if> >18:00</option>
						<option value="19:00" <c:if test="${result.startTime eq '19:00'}">selected</c:if> >19:00</option>
						<option value="20:00" <c:if test="${result.startTime eq '20:00'}">selected</c:if> >20:00</option>
						<option value="21:00" <c:if test="${result.startTime eq '21:00'}">selected</c:if> >21:00</option>
						<option value="22:00" <c:if test="${result.startTime eq '22:00'}">selected</c:if> >22:00</option>								
					</select>
					<select name="endTime" title="종료 시간" >
						<option value="08:30" <c:if test="${result.endTime eq '08:00'}">selected</c:if> >08:00</option>
						<option value="09:00" <c:if test="${result.endTime eq '09:00'}">selected</c:if> >09:00</option>
						<option value="10:00" <c:if test="${result.endTime eq '10:00'}">selected</c:if> >10:00</option>
						<option value="11:00" <c:if test="${result.endTime eq '11:00'}">selected</c:if> >11:00</option>
						<option value="12:00" <c:if test="${result.endTime eq '12:00'}">selected</c:if> >12:00</option>
						<option value="13:00" <c:if test="${result.endTime eq '13:00'}">selected</c:if> >13:00</option>
						<option value="14:00" <c:if test="${result.endTime eq '14:00'}">selected</c:if> >14:00</option>
						<option value="15:00" <c:if test="${result.endTime eq '15:00'}">selected</c:if> >15:00</option>
						<option value="15:00" <c:if test="${result.endTime eq '16:00'}">selected</c:if> >16:00</option>
						<option value="17:00" <c:if test="${result.endTime eq '17:00'}">selected</c:if> >17:00</option>
						<option value="18:00" <c:if test="${result.endTime eq '18:00'}">selected</c:if> >18:00</option>
						<option value="19:00" <c:if test="${result.endTime eq '19:00'}">selected</c:if> >19:00</option>
						<option value="20:00" <c:if test="${result.endTime eq '20:00'}">selected</c:if> >20:00</option>
						<option value="21:00" <c:if test="${result.endTime eq '21:00'}">selected</c:if> >21:00</option>
						<option value="22:00" <c:if test="${result.endTime eq '22:00'}">selected</c:if> >22:00</option>
					</select>
				</td>
			</tr>
			<c:if test="${pathBbsId eq 'calendar'}">
				<tr>
					<th><font color="red">*</font>장소</th>
					<td><input type="text" id="location"  name="location" style="width:100%;" value="${result.location }" title="장소입력" /></td>
				</tr>
				<tr>
					<th><font color="red">*</font>내용</th>
					<td><textarea name="content"   rows="12" cols="20" id="content" title="일정 내용을 입력해 주세요.">${result.content }</textarea></td>
				</tr>
			</c:if>
		</tbody>
	</table>

</form>

<div class="page-btn">
	<a href="#!" onclick="javascript:fn_backList();">취소</a>
	<a href="#!" onclick="javascript:fn_save();">저장</a>
</div>
 