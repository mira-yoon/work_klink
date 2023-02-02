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
/* 목록 */
function fn_backList(){
	var scSection = $("#scSection").val();
	var reqUrl =  "/la/schedule/"+scSection+"/listSchedule";
	
	$("#frmSchedule").attr("action", reqUrl);
	$("#frmSchedule").submit();
}

/* 수정 */
function fn_update(){
	var scSection = $("#scSection").val();
	var reqUrl =  "/la/schedule/"+scSection+"/adminUpdateSchedule";
	
	$("#frmSchedule").attr("action", reqUrl);
	$("#frmSchedule").submit();
}
/* 삭제 */
function fn_delete(){
	var scSection = $("#scSection").val();
	if(confirm("해당 스케쥴을 삭제하시겠습니까?")){
		var reqUrl =  "/la/schedule/"+scSection+"/deleteSchedule";
	
		$("#frmSchedule").attr("action", reqUrl);
		$("#frmSchedule").submit();
	}
}
//-->
</script>

<form id="frmSchedule" method="post" name="frmSchedule">
	<input type="hidden" id="scSeq" name="scSeq" value="${result.scSeq }"/>
	<input type="hidden" id="scSection" name="scSection" value="${pathBbsId}"/>
	<div class="title-name-1">일정 상세보기</div>
	<table border="0" cellpadding="0" cellspacing="0" class="view-1">
		<tbody>
			<c:if test="${pathBbsId eq 'calendar'}">
				<tr>
					<th><font color="red">*</font>일정구분</th>
					<td>
						<c:if test="${result.scType eq 'TM' }"><span>Tech Meetup</span></c:if>
						<c:if test="${result.scType eq 'GM' }"><span>그룹 멘토링</span></c:if>
						<c:if test="${result.scType eq 'PE' }"><span>피칭교육</span></c:if>
						<c:if test="${result.scType eq 'PC' }"><span>피칭컨설팅</span></c:if>
						<c:if test="${result.scType eq 'PP' }"><span>피칭대회</span></c:if>
					</td>
				</tr>
			</c:if>
			<tr>
				<th>
					<c:if test="${pathBbsId eq 'calendar'}"><font color="red">*</font>제목</c:if>
					<c:if test="${pathBbsId eq 'meeting'}"><font color="red">*</font>예약자</c:if>
				</th>
				<td>${result.title }</td>
			</tr>
			<tr>
				<th><font color="red">*</font>일자</th>
				<td>
					${result.scDay }&nbsp;&nbsp; (${result.startTime }&nbsp; ~&nbsp;  ${result.endTime })
				</td>
			</tr>
			<c:if test="${pathBbsId eq 'calendar'}">
			<tr>
				<th><font color="red">*</font>장소</th>
				<td>${result.location }</td>
			</tr>
			<tr>
				<th><font color="red">*</font>내용</th>
				<td>${result.content }</td>
			</tr>
			</c:if>
		</tbody>
	</table>

</form>

<div class="page-btn">
	<a href="#!" onclick="javascript:fn_backList();">목록</a>
	<a href="#!" onclick="javascript:fn_update();">수정</a>
	<a href="#!" onclick="javascript:fn_delete();">삭제</a>
</div>
 