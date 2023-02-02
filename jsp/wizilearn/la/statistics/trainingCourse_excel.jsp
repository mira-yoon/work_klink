<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
  
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <table width="100%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
        <tr align="center">
        	<td colspan="11">
        	<h3>과정별 초청연수 현황</h3>
        	</td>
        </tr>
 
        <tr align="center">
          <td><h4>년도</h4></td>
          <td><h4>과정명</h4></td>
		  <td><h4>모집인원</h4></td>		  
		  <td><h4>신청중</h4></td>
		  <td><h4>접수</h4></td>
		  <td><h4>대기</h4></td>
		  <td><h4>승인</h4></td>
		  <td><h4>거부</h4></td>
		  <td><h4>참석</h4></td>
		  <td><h4>불참</h4></td>
		  <td><h4>과정상태</h4></td>
        </tr>
      </table>
      <table width="50%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
      	<c:forEach var="result" items="${resultList}" varStatus="status">
	        <tr align="center" class="tableWhite2">
				<td>${result.courseYear}</td>
				<td>${result.title}</td>
				<td>${result.participant}</td>
				<td>${result.writecnt}</td>
				<td>${result.applycnt}</td>
				<td>${result.waitcnt}</td>
				<td>${result.acceptcnt}</td>
				<td>${result.denycnt}</td>
				<td>${result.attendcnt}</td>
				<td>${result.abcentcnt}</td>
				<td>${result.cdname}</td>
	        </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
	        <tr align="center" height="30" class="tableWhite2">
	          <td colspan="11" rowspan="16"><h3>조회된 정보가 없습니다.</h3></td>
	        </tr>
        </c:if>
      </table>
    </td>
  </tr>
</table> 


 
