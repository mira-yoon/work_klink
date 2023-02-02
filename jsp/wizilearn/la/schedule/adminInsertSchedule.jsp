<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%><%@ 
page import="java.util.Date" %><%@ 
page import="java.util.Locale" %><%@ 
page import="org.apache.commons.lang3.time.DateUtils" %><%@ 
page import="org.apache.commons.lang.time.DateFormatUtils" %><%@ 
page import="kr.co.wizi.wizilearn.commbiz.util.BizUtil" %><%@ 
page import="kr.co.wizi.wizilearn.comm.vo.LoginInfo" %><%@ 
page import="kr.co.wizi.wizilearn.comm.service.Globals" %><%@ 
page import="kr.co.wizi.wizilearn.comm.vo.LoginVO" %><%@ 
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ 
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">
<!--
$(document).ready(function() {
	initHtml();	
});

function initHtml() {

		com.datepicker('scDay'); 

}
/* HTML Form 신규, 수정 */
function fn_formSave(){
	var scSection = $("#scSection").val();
	if (fn_formValidate()) {
		
		var reqUrl =  "/la/schedule/"+scSection+"/insertSchedule";
		
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
	<input type="hidden" id="scAuth" name="scAuth" value="ALL"/>
	<input type="hidden" id="scSection" name="scSection" value="${pathBbsId}"/>
	<c:if test="${pathBbsId eq 'meeting'}">
		<input type="hidden" id="scType" name="scType" value="M"/>
		<input type="hidden" id="location" name="location" value="NIPA 회의실"/>
		<input type="hidden" id="content" name="content" value="StartUp 회의"/>
	</c:if>
	<div class="title-name-1">일정 등록</div>
	<p style="display:inline-block; text-align:left; margin-top:10px;"><font color="red">*</font> 는 필수입력사항입니다.</p>
	<table border="0" cellpadding="0" cellspacing="0" class="view-1">
		<tbody>
			<c:if test="${pathBbsId eq 'calendar'}">
				<tr>
					<th><font color="red">*</font>일정구분</th>
					<td>
						<select name="scType"  id="scType" title="일정 구분" style="width:30%;"> 
							<option value="" selected>= 선택 =</option>
							<c:forEach var="codeList" items="${codeList }" varStatus="status">
								<option value="${codeList.codeCode }" class="choice" /><label>${codeList.codeName }</label>
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
				<td><input type="text" name="title" value="" style="width:100%;"/></td>
			</tr>
			<tr>
				<th><font color="red">*</font>일자</th>
				<td>
					<input type="text"  name="scDay"  id="scDay"  style="width:20%;"  value=""  readonly  title="일자" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<select name="startTime" title="시작 시간" >
						<option value="07:00" >07:00</option>
						<option value="08:00" >08:00</option>
						<option value="09:00" >09:00</option>
						<option value="10:00" >10:00</option>
						<option value="11:00" >11:00</option>
						<option value="12:00" >12:00</option>
						<option value="13:00" >13:00</option>
						<option value="14:00" >14:00</option>
						<option value="15:00" >15:00</option>
						<option value="16:00" >16:00</option>
						<option value="17:00" >17:00</option>
						<option value="18:00" >18:00</option>
						<option value="19:00" >19:00</option>
						<option value="20:00" >20:00</option>
						<option value="21:00" >21:00</option>
						<option value="22:00" >22:00</option>										
					</select>
					<select name="endTime" title="종료 시간" >
						<option value="08:00" >08:00</option>
						<option value="09:00" >09:00</option>
						<option value="10:00" >10:00</option>
						<option value="11:00" >11:00</option>
						<option value="12:00" >12:00</option>
						<option value="13:00" >13:00</option>
						<option value="14:00" >14:00</option>
						<option value="15:00" >15:00</option>
						<option value="16:00" >16:00</option>
						<option value="17:00" >17:00</option>
						<option value="18:00" >18:00</option>
						<option value="19:00" >19:00</option>
						<option value="20:00" >20:00</option>
						<option value="21:00" >21:00</option>
						<option value="22:00" >22:00</option>
					</select>
				</td>
			</tr>
			<c:if test="${pathBbsId eq 'calendar'}">
				<tr>
					<th><font color="red">*</font>장소</th>
					<td><input type="text" id="location"  name="location" style="width:100%;" value="" title="장소입력" /></td>
				</tr>
				<tr>
					<th><font color="red">*</font>내용</th>
					<td><textarea name="content"   rows="12" cols="20" id="content" title="일정 내용을 입력해 주세요."></textarea></td>
				</tr>
			</c:if>
		</tbody>
	</table>

</form>

<div class="page-btn">
	<a href="#!" onclick="javascript:fn_backList();">취소</a>
	<a href="#!" onclick="javascript:fn_formSave();">등록</a>
</div>
 