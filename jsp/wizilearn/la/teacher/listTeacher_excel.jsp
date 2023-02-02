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
        	<td colspan="7">
        	<h3>강사 목록</h3>
        	</td>
        </tr>
 
        <tr align="center">
          <td><h4>강사명</h4></td>
          <td><h4>연락처</h4></td>
          <td><h4>이메일</h4></td>
          <td><h4>연수 수</h4></td>
		  <td><h4>강의 수</h4></td>
		  <td><h4>평가결과</h4></td>
		  <td><h4>약력</h4></td>
        </tr>
      </table>
      <table width="50%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
      	<c:forEach var="result" items="${resultList}" varStatus="status">
	        <tr align="center" height="100" class="tableWhite2">
	        	<td>${result.name}</td>
	        	<td>${result.tel}</td>
	        	<td>${result.email}</td>
	        	<td>${result.courseCnt}</td>
				<td>${result.evaluationCnt}</td>
	        	<td>${result.rating}</td>
	        	<td>${result.history}</td>
	        </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
	        <tr align="center" height="30" class="tableWhite2">
	          <td colspan="7" rowspan="3"><h3>조회된 정보가 없습니다.</h3></td>
	        </tr>
        </c:if>
      </table>
    </td>
  </tr>
</table> 


 
