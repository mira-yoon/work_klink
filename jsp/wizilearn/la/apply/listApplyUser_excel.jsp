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
        	<td colspan="10">
        	<h3>연수과정 신청자 목록</h3>
        	</td>
        </tr>
 
        <tr align="center">
          <td><h4>No</h4></td>
          <td><h4>Course Year</h4></td>
          <td><h4>Duration</h4></td>
          <td><h4>Course Title</h4></td>
		  <td><h4>Photo</h4></td>
		  <td><h4>Country</h4></td>
		  <td><h4>First Name</h4></td>
		  <td><h4>Last Name</h4></td>
		  <td><h4>Business Phone</h4></td>
		  <td><h4>Mobile Phone</h4></td>
		  <td><h4>Business email</h4></td>
		  <td><h4>Private email</h4></td>
		  <td><h4>Organization</h4></td>
		  <td><h4>OrganizationType</h4></td>
		  <td><h4>OrganizationDetailType</h4></td>
		  <td><h4>OrganizationEtcType</h4></td>		  
		  <td><h4>Department</h4></td>
		  <td><h4>Position</h4></td>
		  <td><h4>Gender</h4></td>
		  <td><h4>Disability</h4></td>		  
		  <td><h4>Date of Birth</h4></td>
		  <td><h4>Organization Website</h4></td>
		  <td><h4>Passport copy</h4></td>
		  <td><h4>Business Card Copy</h4></td>		  
		  <td><h4>Name of the reference</h4></td>
		  <td><h4>Nationality of the reference</h4></td>
		  <td><h4>Organization of the reference</h4></td>
		  <td><h4>Position of the reference</h4></td>
		  <td><h4>Letter of Reference</h4></td>
		  <td><h4>ICT projects</h4></td>
		  <td><h4>cooperation</h4></td>
		  <td><h4>job duty</h4></td>
		  <td><h4>achieve</h4></td>
		  <td><h4>Business Meeting</h4></td>
		  <td><h4>Etc (Lecture, Place,..)</h4></td>
        </tr>
      </table>
      <table width="50%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
      	<c:forEach var="result" items="${resultList}" varStatus="status">
	        <tr align="center" height="100" class="tableWhite2">
	        	<td>${status.count}</td>
	        	<!-- <td><img src="/images/sub/02.gif"></td> -->
	        	<td>${fn:substring(result.dayStart,0,4)}</td>
	        	<td>${result.dayStart}~${result.dayEnd}</td>
	        	<td>${result.title}</td>
	        	<%-- <td><img src="/lu/apply/getFile?downFileNo=2&applyCd=${result.applyCd}" /></td> --%>
	        	<%--td>${result.photoFilePath}${result.photoSaveName}</td--%>
	        	<td><img src="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=1&applyCd=${result.applyCd}" /></td>
	        	<td>${result.natName}</td>
	        	<td>${result.firstNameStr}</td>
	        	<td>${result.lastNameStr}</td>
	        	<td>${result.phoneStr}</td>
	        	<td>${result.mobileStr}</td>
	        	<td>${result.businessEmailStr}</td>
	        	<td>${result.privateEmailStr}</td>
	        	<td>${result.organizationName}</td>
	        	<td>${result.organizationType}</td>
	        	<td>${result.organizationDetailType}</td>
	        	<c:choose>
	        	<c:when test="${'pubOth' eq result.organizationDetailType }">
	        		<td>Other</td>
	        	</c:when>
	        	<c:when test="${':ass' eq result.organizationDetailType }">
	        		<td>Association</td>
	        	</c:when>
	        	<c:when test="${':com' eq result.organizationDetailType }">
	        		<td>Company</td>
	        	</c:when>
	        	<c:when test="${'sta' eq result.organizationDetailType }">
	        		<td>State Enterprise</td>
	        	</c:when>
	        	<c:otherwise>
	        		<td></td>
	        	</c:otherwise>
	        	</c:choose>
	        	
	        	<td>${result.department}</td>
	        	<td>${result.position}</td>
	        	<c:choose>
	        	<c:when test="${'m' eq result.gender }">
	        		<td>male</td>
	        	</c:when>
	        	<c:when test="${'f' eq result.gender }">
	        		<td>female</td>
	        	</c:when>
	        	<c:otherwise>
	        		<td></td>
	        	</c:otherwise>
	        	</c:choose>	        	
	        	<td>${result.disability}</td>
	        	<td>${result.birthdate}</td>
	        	<td>${result.website}</td>
	        	<%--td>${result.passportFilePath}${result.passportSaveName}</td--%>
	        	<td><img src="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=2&applyCd=${result.applyCd}" /></td>
	        	<%--td>${result.businessCardFilePath}${result.businessCardSaveName}</td--%>
	        	<td><img src="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=3&applyCd=${result.applyCd}" /></td>
	        	<td>${result.referenceName}</td>
				<td>${result.referenceNationName}</td>
				<td>${result.referenceOrganization}</td>
				<td>${result.referencePosition}</td>
				<%--td>${result.referenceFileName}</td--%>
				<td><a href="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=4&applyCd=${result.applyCd}">${result.referenceFileName}</a></td>
				<td><a href="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=5&applyCd=${result.applyCd}">${result.ictFileName}</a></td>
				<td>${result.cooperation}</td>
				<td>${result.jobDuty}</td>
				<td>${result.achieve}</td>
				<td>${result.businessMeeting }</td>
				<td>${result.courseRelatedTasks}</td>
	        </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
	        <tr align="center" height="30" class="tableWhite2">
	          <td colspan="35" rowspan="3"><h3>조회된 정보가 없습니다.</h3></td>
	        </tr>
        </c:if>
      </table>
    </td>
  </tr>
</table> 


 
