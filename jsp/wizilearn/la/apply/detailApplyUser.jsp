<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ 
taglib prefix="form" uri="http://www.springframework.org/tags/form"%><%@ 
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="pop-area">
				<c:if test="${not empty resultList}">
					<p class="subTxt1">Information on Apply</p>
					<table cellspacing="0" cellpadding="0" border="0" summary="" class="subT subT_btm">
						<colgroup>
							<col style="width:70px;" />

							<col style="width:200px;" />
							<col style="width:400px" />
		
							<col style="width:117px;" />

						</colgroup>
						<thead>
							<tr>
								<th scope="col">No</th>

								<th scope="col">Duration</th>
								<th scope="col">Course Title</th>
								
								<th scope="col">신청일</th>

							</tr>
						</thead>					
						<tbody>
		 					<c:forEach var="resultList" items="${resultList}" varStatus="status">
							<tr>
								<td>${status.count }</td>

								<td>${resultList.dayStart}~${resultList.dayEnd}</td>
								<td>${resultList.title}</td>
								
								<td>${resultList.applyDate}</td>

							</tr>
		 					</c:forEach>
						</tbody>
					</table>
				</c:if> 
				<p class="subTxt1">Personal Information</p>
					<table cellspacing="0" cellpadding="0" border="0" summary="" class="subT subT_btm">
					<colgroup>
						<col style="width:257px;">
						<col style="width:537px;">
					</colgroup>
					<tbody>
						<tr>
							<th class="dif">Course Year</th>
							<td>${fn:substring(result.dayStart,0,4)}</td>
						</tr>
						<tr>
							<th class="dif">Duration</th>
							<td>${result.dayStart}&nbsp;~&nbsp;${result.dayEnd}</td>
						</tr>
						<tr>
							<th class="dif">Course Title</th>
							<td>   ${result.title}</td>
						</tr>
 
						<tr>
							<th class="dif">Photo</th>
							<td>							
							<c:if test="${not empty result.photoFileName}">
							<a href="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=1&applyCd=${result.applyCd}"><img src="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=1&applyCd=${result.applyCd}" style="max-width: 470px;"  title="${result.photoFileName}" /></a>
							</c:if>
							</td>
						</tr>
						<tr>
							<th class="dif">Country</th>
							<td>${result.natName}</td>
						</tr>
						<tr>
							<th class="dif">First Name</th>
							<td>${result.firstNameStr}</td>
						</tr>
						<tr>
							<th class="dif">Last Name</th>
							<td>${result.lastNameStr}</td>
						</tr>
						<tr>
							<th class="dif">Business Phone</th>
							<td>${result.phoneStr}</td>
						</tr>
						<tr>
							<th class="dif">Mobile Phone</th>
							<td>${result.mobileStr}</td>
						</tr>
						<tr>
							<th class="dif">Business email</th>
							<td>${result.businessEmailStr}</td>
						</tr>
						<tr>
							<th class="dif">Private email</th>
							<td>${result.privateEmailStr}</td>
						</tr>
						<tr>
							<th class="dif" rowspan="2">Organization</th>
							<td>${result.organizationName}
							<c:if test="${not empty result.organizationType}">(${result.organizationType})</c:if> 
							 
							</td>
						</tr>
						<tr>
							<td>
								<c:if test="${result.organizationDetailType eq 'gov' }">Government (Ministry, Commission, Agency, etc)</c:if>
								<c:if test="${result.organizationDetailType eq 'sta'}">State Enterprise</c:if>
								<c:if test="${result.organizationDetailType eq 'pubOth'}">Other (${result.organizationEtcType})</c:if>
							</td>
						</tr>
						<tr>
							<th class="dif">Department</th>
							<td>${result.department}</td>
						</tr>
						<tr>
							<th class="dif">Position</th>
							<td>${result.position}</td>
						</tr>
						<tr>
							<th class="dif" rowspan="2">Gender</th>
							<td>
							<c:if test="${result.gender eq 'm'}" >male</c:if>
							<c:if test="${result.gender eq 'f'}" >female</c:if>
							</td>
						</tr>
						<tr>
							<td>
							<c:if test="${not empty result.disability}" >Disability : ${result.disability}</c:if>					 
							</td>
						</tr>
						<tr>
							<th class="dif">Date of Birth</th>
							<td>${result.birthdate}</td>
						</tr>
						<tr>
							<th class="dif">Organization Website (Optional)</th>
							<td>${result.website}</td>
						</tr>
						<tr>
							<th class="dif">Passport copy</th>
							<td>
							<c:if test="${not empty result.passportFileName}">
							<a href="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=2&applyCd=${result.applyCd}" ><img src="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=2&applyCd=${result.applyCd}"  style="max-width: 470px;" title="${result.passportFileName}" alt="${result.passportFileName}" /></a>
							</c:if>
							</td>
						</tr>
						<tr>
							<th class="dif">Business Card copy</th>
							<td>
								<c:if test="${not empty result.businessCardFileName}">
							<a href="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=3&applyCd=${result.applyCd}"><img src="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=3&applyCd=${result.applyCd}" style="max-width: 470px;"  title="${result.businessCardFileName}" alt="${result.businessCardFileName}" /></a>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
				<p class="subTxt1">Reference</p>
				<table cellspacing="0" cellpadding="0" border="0" summary="" class="subT subT_reapp">
					<colgroup>
						<col width="20%">
						<col width="80%">
					</colgroup>
					<tbody>
						<tr>
							<th>Name of the reference</th>
							<td>${result.referenceName}</td>
						</tr>
						<tr>
							<th>Nationality of the reference</th>
							<td>${result.referenceNationName}</td>
						</tr>
						<tr>
							<th>Organization of the reference</th>
							<td>${result.referenceOrganization}</td>
						</tr>
						<tr>
							<th>Position of the reference</th>
							<td>${result.referencePosition}</td>
						</tr>
						<tr>
							<th>Letter of Reference</th>
							<td><a href="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=4&applyCd=${result.applyCd}">${result.referenceFileName}</a></td>
						</tr>
					</tbody>
				</table>

				<p class="subTxt1">Application</p>
				<table cellspacing="0" cellpadding="0" border="0" summary="" class="subT td-cen">
					<tbody>
						<tr>
							<th>1. Please describe ICT projects in your organization or country based on the attached form.</th>
						</tr>
						<tr>
							<td><a href="<%=request.getScheme()+"://"+request.getServerName()%>/la/apply/getFile?downFileNo=5&applyCd=${result.applyCd}" >${result.ictFileName}</a></td>
						</tr>
						<tr>
							<th>2. Is there any Korean Companies you would like to have a business meeting with?</th>
						</tr>
						<tr>
							<td>${result.businessMeeting}</td>
						</tr>
						<tr>
							<th>3. Please describe current cooperation between Korean government/companies and your organization</th>
						</tr>
						<tr>
							<td>${result.cooperation}</td>
						</tr>
						<tr>
							<th>4. Please explain your job duty.</th>
						</tr>
						<tr>
							<td>${result.jobDuty}</td>
						</tr>
						<tr>
							<th>5. Please describe any topics, lectures or places of interest you would like to see in the course related to your tasks mentioned above.</th>
						</tr>
						<tr>
							<td>${result.courseRelatedTasks}</td>
						</tr>
						<tr>
							<th>6. What are you trying to achieve through this program?</th>
						</tr>
						<tr>
							<td>${result.achieve}</td>
						</tr>
					</tbody>
				</table> 
				<div class="page-btn" style="text-align:center;padding:10px;">
					<a href="#" onclick="javascript:self.close();">CLOSE</a>
					<a href="#" onclick="javascript:window.print();">PRINT</a>
				</div> 
</div>