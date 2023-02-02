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
        	<h3>국가별 로그인 현황</h3>
        	</td>
        </tr>
 
        <tr align="center">
          <td><h4>순위</h4></td>
		  <td><h4>국가</h4></td>
		  <td><h4>회원ID</h4></td>
		  <td><h4>회원명</h4></td>
		  <td><h4>회원구분</h4></td>
		  <td><h4>건수</h4></td>
		  <td><h4>비교율</h4></td>
        </tr>
      </table>
      <table width="50%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
      	<c:forEach var="result" items="${resultList}" varStatus="status">
	        <tr align="center" class="tableWhite2">
				<td>${result.rank }</td>
				<td>${result.nationDTO.natName }[${result.nationDTO.natNameKr }]</td>
				<td>${result.userDTO.memId }</td>
				<td>${result.userDTO.memNameStr }${result.userDTO.memLastNameStr }</td>
				<td>
					<c:choose>
						<c:when test="${result.userDTO.authGroupId eq 'UT01' }">
							관리자
						</c:when>
						<c:when test="${result.userDTO.authGroupId eq 'UT02' }">
							강사
						</c:when>
						<c:when test="${result.userDTO.authGroupId eq 'UT03' }">
							일반회원
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
				</td>
				<td>${result.cnt }</td>
				<td>${result.ratio }%</td>
	        </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
	        <tr align="center" height="30" class="tableWhite2">
	          <td colspan="7" rowspan="16"><h3>조회된 정보가 없습니다.</h3></td>
	        </tr>
        </c:if>
      </table>
    </td>
  </tr>
</table> 


 
