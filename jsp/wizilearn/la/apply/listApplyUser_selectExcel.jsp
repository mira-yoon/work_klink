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
          <c:if test="${fn:contains(colStr,'DAY_START')}">
          	<td><h4>Course Year</h4></td>
          </c:if>
          <c:if test="${fn:contains(colStr,'DAY_START START_S')}">
	          <td><h4>Duration</h4></td>
	      </c:if>
	      <c:if test="${fn:contains(colStr,'TITLE')}">
	          <td><h4>Course Title</h4></td>
	      </c:if>
	      <c:if test="${fn:contains(colStr,'PHOTO_FILE_NAME')}">
			  <td><h4>Photo</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'NAT_NAME')}">
			  <td><h4>Country</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'FIRST_NAME')}">
			  <td><h4>First Name</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'LAST_NAME')}">
			  <td><h4>Last Name</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'PHONE')}">
			  <td><h4>Business Phone</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'MOBILE')}">
			  <td><h4>Mobile Phone</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'BUSINESS_EMAIL')}">
			  <td><h4>Business email</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'PRIVATE_EMAIL')}">
			  <td><h4>Private email</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'ORGANIZATION_NAME')}">
			  <td><h4>Organization</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'ORGANIZATION_TYPE')}">
			  <td><h4>OrganizationType</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'ORGANIZATION_DETAIL_TYPE')}">
			  <td><h4>OrganizationDetailType</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'ORGANIZATION_ETC_TYPE')}">
			  <td><h4>OrganizationEtcType</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'DEPARTMENT')}">
			  <td><h4>Department</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'POSITION')}">
			  <td><h4>Position</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'GENDER')}">
			  <td><h4>Gender</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'DISABILITY')}">
			  <td><h4>Disability</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'BIRTHDATE')}">
			  <td><h4>Date of Birth</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'WEBSITE')}">
			  <td><h4>Organization Website</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'PASSPORT_FILE_NAME')}">
			  <td><h4>Passport copy</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'BUSINESSCARD_FILE_NAME')}">
			  <td><h4>Business Card Copy</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'REFERENCE_NAME')}">
			  <td><h4>Name of the reference</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'REFERENCE_NATION_NAME')}">
			  <td><h4>Nationality of the reference</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'REFERENCE_ORGANIZATION')}">
			  <td><h4>Organization of the reference</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'REFERENCE_POSITION')}">
			  <td><h4>Position of the reference</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'REFERENCE_FILE_NAME')}">
			  <td><h4>Letter of Reference</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'ICT_FILE_NAME')}">
			  <td><h4>ICT projects</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'COOPERATION')}">
			  <td><h4>cooperation</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'JOB_DUTY')}">
			  <td><h4>job duty</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'ACHIEVE')}">
			  <td><h4>achieve</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'BUSINESS_MEETING')}">
			  <td><h4>Business Meeting</h4></td>
          </c:if>
	      <c:if test="${fn:contains(colStr,'COURSE_RELATED_TASKS')}">
			  <td><h4>Etc (Lecture, Place,..)</h4></td>
          </c:if>
        </tr>
      </table>
      <table width="50%" border="1" cellspacing="1" cellpadding="1" class="tableBorder">
      	<c:forEach var="result" items="${resultList}" varStatus="status">
	        <tr align="center" height="100" class="tableWhite2">
	        	<td>${status.count}</td>
	        	<!-- <td><img src="/images/sub/02.gif"></td> -->
	        	<%-- <td><a href="http://localhost:8080/images/sub/01.gif">${result.photoSaveName}</a></td> --%>
          		<c:if test="${fn:contains(colStr,'DAY_START')}">
		          	<td>${fn:substring(result.dayStart,0,4)}</td>
          		</c:if>
				<c:if test="${fn:contains(colStr,'DAY_START START_S')}">
					<td>${result.dayStart}~${result.dayEnd}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'TITLE')}">
					<td>${result.title}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'PHOTO_FILE_NAME')}">
					<td>${result.photoFilePath}${result.photoSaveName}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'NAT_NAME')}">
					<td>${result.natName}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'FIRST_NAME')}">
					<td>${result.firstNameStr}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'LAST_NAME')}">
					<td>${result.lastNameStr}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'PHONE')}">
					<td>${result.phoneStr}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'MOBILE')}">
					<td>${result.mobileStr}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'BUSINESS_EMAIL')}">
					<td>${result.businessEmailStr}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'PRIVATE_EMAIL')}">
					<td>${result.privateEmailStr}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'ORGANIZATION_NAME')}">
					<td>${result.organizationName}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'ORGANIZATION_TYPE')}">
					<td>${result.organizationType}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'ORGANIZATION_DETAIL_TYPE')}">
					<td>${result.organizationDetailType}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'ORGANIZATION_ETC_TYPE')}">
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
				</c:if>
				<c:if test="${fn:contains(colStr,'DEPARTMENT')}">
					<td>${result.department}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'POSITION')}">
					<td>${result.position}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'GENDER')}">
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
				</c:if>
				<c:if test="${fn:contains(colStr,'DISABILITY')}">
					<td>${result.disability}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'BIRTHDATE')}">
					<td>${result.birthdate}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'WEBSITE')}">
					<c:choose>
					<c:when test="${empty result.website }">
						<td>-</td>
					</c:when>
					<c:otherwise>
						<td>${result.website}</td>
					</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="${fn:contains(colStr,'PASSPORT_FILE_NAME')}">
					<td>${result.passportFilePath}${result.passportSaveName}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'BUSINESSCARD_FILE_NAME')}">
					<td>${result.businessCardFilePath}${result.businessCardSaveName}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'REFERENCE_NAME')}">
					<td>${result.referenceName}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'REFERENCE_NATION_NAME')}">
					<td>${result.referenceNation}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'REFERENCE_ORGANIZATION')}">
					<td>${result.referenceOrganization}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'REFERENCE_POSITION')}">
					<td>${result.referencePosition}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'REFERENCE_FILE_NAME')}">
					<td>${result.referenceFileName}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'ICT_FILE_NAME')}">
					<td>${result.ictFilePath}@~~@${result.referenceSaveName}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'COOPERATION')}">
					<td>${result.cooperation}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'JOB_DUTY')}">
					<td>${result.jobDuty}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'ACHIEVE')}">
					<td>${result.achieve}</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'BUSINESS_MEETING')}">
					<td>${result.businessMeeting }</td>
				</c:if>
				<c:if test="${fn:contains(colStr,'COURSE_RELATED_TASKS')}">
					<td>${result.courseRelatedTasks}</td>
				</c:if>
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


 
