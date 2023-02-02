<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
<!--


$(document).ready(function(){
  
	com.datepicker('birthdate');
	
	var index = 0
	var slider = $(".slider").children().length
	
	$(".slider div.step-area").show();
	
	// input 숫자만 허용
    $("input:text[numberOnly]").on("keyup", function() {
		$(this).val($(this).val().replace(/[^0-9]/g,""));
    });

	//oragnization other 선택시
	$("input:checkbox[name='organizationDetailType']").bind('click',function() {

		$("input:checkbox[name='organizationDetailType']").not(this).prop("checked", false);
		if( $("input:checkbox[id='orgPubOther']").is(":checked") ){
			$("#organizationEtcType").show();
		} else if( $("input:checkbox[id='orgPriOther']").is(":checked") ){
			$("#organizationEtcType").show();
		} else {
			$("#organizationEtcType").hide();
		}
	});

	$("#disability").hide();
});

//oragnization 선택시
function organizationTypeChk(){
	var organizationTypeVal =  $('input:radio[name="organizationType"]:checked').val();
	$("#organizationEtcType").hide();
	$("#organizationTd").show();
	if( "public" == organizationTypeVal ) {
		$("#oraganizationPub").show();
		$("#oraganizationPri").hide();
		$('input:checkbox[name="organizationDetailType"]').each(function() {
			this.checked = false;
		});
	} else {
		$("#oraganizationPub").hide();
		$("#oraganizationPri").show();
		$('input:checkbox[name="organizationDetailType"]').each(function() {
			this.checked = false;
		});
	}
}

function disabilityChk(){
	if( $("#disChk").prop("checked") ){
		$("#disability").show();
	} else {
		$("#disability").hide();
	}
}
function fn_save(type){
	
	$("#phone").val($("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val() + "-" +$("#phone4").val());
	$("#mobile").val($("#mobile1").val() + "-" + $("#mobile2").val() + "-" + $("#mobile3").val() + "-" +$("#mobile4").val());
	$("#stepCd").val(type);
			
	
	if(type=='SS'){
		if( !$('#file_text1').val()){
			alert("Please fill your Photo");
			return false;
		}
		if( !valueValidation("firstName", "First Name") ) return false;
		if( !valueValidation("lastName", "Last Name") ) return false;
		if( !valueValidation("phone1", "Business Phone") ) return false;
		if( !valueValidation("phone2", "Business Phone") ) return false;
		if( !valueValidation("phone3", "Business Phone") ) return false;
		if( !valueValidation("phone4", "Business Phone") ) return false; 
		if( !valueValidation("mobile1", "Mobile Phone") ) return false;
		if( !valueValidation("mobile2", "Mobile Phone") ) return false;
		if( !valueValidation("mobile3", "Mobile Phone") ) return false;
		if( !valueValidation("mobile4", "Mobile Phone") ) return false; 
		if( !valueValidation("businessEmail", "Business email") ) return false;
		if( !emailValidation("businessEmail", "Business email") ) return false;
		if( !valueValidation("privateEmail", "Private email") ) return false;
		if( !emailValidation("privateEmail", "Private email") ) return false;
		if( !valueValidation("organizationName", "Organization") ) return false;
		//gender
		if( !$('input:radio[name="gender"]').is(':checked') ){
			alert("Please fill your Gender");
			$('input:radio[name="gender"]').focus();
			return false;
		}
		if( !$('#file_text2').val()){ 
			alert("Please fill your Passport Copy");
			return false; 
		}
		if( !$("#file_text3").val() ){ 
			alert("Please fill your Business Card copy");
			return false; 
		}
		if( !$("#file_text4").val()){
			alert("Please fill your Organization of the reference");
			return false;
		}
		if( !$("#file_text5").val() ){
			alert("Please fill your ICT Projects");
			return false;
		}
		//organization type
		if( !$('input:radio[name="organizationType"]').is(':checked') ){
			alert("Please fill your Organization");
			$('input:radio[name="organizationType"]').focus();
			return false;
		}

		//organization detail type
		var organizationTypeVal =  $('input:radio[name="organizationType"]:checked').val();
		if( "public" == organizationTypeVal ) {
			if( !$('input:checkbox[name=organizationDetailType]').is(':checked') ){
				alert("Please fill your Organization");
				$('input:checkbox[name="organizationDetailType"]').focus();
				return false;
			}
		} else {
			if( !$('input:checkbox[name=organizationDetailType]').is(':checked') ){
				alert("Please fill your Organization");
				$('input:checkbox[name="organizationDetailType"]').focus();
				return false;
			}
		}
		 
		//disability
		if( $('input:checkbox[name="disChk"]').is(':checked') ){
			if( !valueValidation("disability", "Disability") ) return false;
		}
		//organization etc type
		if( $("input:checkbox[id='orgPubOther']").is(":checked") || $("input:checkbox[id='orgPriOther']").is(":checked") ){
			if( !valueValidation("organizationEtcType", "Organization") ) return false;
		}
		if( !valueValidation("department", "Department") ) return false;
		if( !valueValidation("position", "Position") ) return false;
		 
 
		if( !textAreaValidation("referenceName", "Name of the reference") ) return false;
		if( !textAreaValidation("referenceOrganization", "Organization of the reference") ) return false;
		if( !textAreaValidation("referencePosition", "Position of the reference") ) return false;
		
		
		if( !textAreaValidation("businessMeeting", "2. Is there any Korean Companies you would like to have a business meeting with?")) return false;
		if( !textAreaValidation("cooperation", "3. Please describe current cooperation between Korean government/companies and your organization")) return false;
		if( !textAreaValidation("jobDuty", "4. Please explain your job duty.")) return false;
		if( !textAreaValidation("courseRelatedTasks", "5. Please describe any topics, lectures or places of interest you would like to see in the course related to your tasks mentioned above.")) return false;
		if( !textAreaValidation("achieve", "6. What are you trying to achieve through this program?")) return false;
	} 
	
	var reqUrl = "/lu/apply/insertApply";
	$("#frmApplyUserInfo").attr("action", reqUrl);
	$("#frmApplyUserInfo").submit();
	
}
 
//validation
function valueValidation(name, field){
	if( $("input[name=" + name + "]").val()==''){
		alert("Please fill your " + field);
		$("input[name=" + name + "]").focus();
		return false;
	}
	return true;
}
//validation
function textAreaValidation(name, field){
	if( $("textarea[name=" + name + "]").val()==''){
		alert("Please fill your " + field);
		$("textarea[name=" + name + "]").focus();
		return false;
	}
	return true;
}
//email validation
function emailValidation(name, filed){
	var email = $("input[name=" + name + "]").val();
	var regex = /^[0-9a-zA-Z]([-_\.0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	if ( email == '' ) {
		alert(filed + " is required.");
		$("input[name=" + name + "]").focus();
		return false;
	} else if ( isContainEmpty(email) ) {
		alert("Can't enter spaces in the " + filed);
		$("input[name=" + name + "]").focus();
		return false;
	} else if ( !isRegexCheck(email, regex) ) {
		alert(filed + " format is invalid.");
		$("input[name=" + name + "]").focus();
		return false;
	}
	return true;
}

/**
 * 공백 포함여부 체크
 * true : 포함
 * false : 미포함
 */
function isContainEmpty(value) {
	var p = /[\s]/g;
	if ( p.test(value) )
		return true;
	return false;
}
/**
 * 정규식 체크
 */
function isRegexCheck(value, regex) {
	var returnValue = false;
	returnValue = regex.test(value);
	return returnValue;
	 
}
//-->
</script>
         <div id="apply">
            <div class="step-num">
              <ul>
                <li>
                  <span>STEP.1</span>
                  <p>Terms and Conditions</p>
                </li>
                
                <li  class="step-on">
                  <span>STEP.2</span>
                  <p>Application</p>
                </li>
               
              </ul>
            </div>
            
            <div class="step">
              <div class="slider">
                 
<form id="frmApplyUserInfo" name="frmApplyUserInfo" method="post"   enctype="multipart/form-data" >
<input type="hidden"  name="phone" id="phone" />
<input type="hidden"  name="mobile" id="mobile" />
<input type="hidden" name="courseCd" id="courseCd"  value="${courseDetail.courseCd}" />
<input type="hidden"  name="stepCd" id="stepCd" />

                <div class="step-2 step-area"  >
                  <h6>Step. 2 Application</h6>
                  <div class="step-text">
                    <p>Please type in the basic information about you that would help us to figure out who you are as an applicant.</p>
                  
                  </div>
                  <table>
                    <tr>
                      <th>Course Year</th>
                      <td>${fn:substring(courseDetail.dayStart,0,4)}</td>
                    </tr>
                    
                    <tr>
                      <th>Duration</th>
                      <td>${courseDetail.dayStart} ~ ${courseDetail.dayEnd}</td>
                    </tr>
                    
                    <tr>
                      <th>Course Title</th>
                      <td>${courseDetail.title}</td>
                    </tr>
                    
                     
                    <tr>
                      <th>Photo</th>
                      <td>
                        <div class="input-file">
                          <input class="upload-name" id="file_text1" disabled="disabled" />
                          <input type="file" id="photoFile" name="photoFile"  accept="image/*" class="upload-hidden" onchange="javascript:$('#file_text1').val(this.value);"  /> 
                          <label for="photoFile">Upload</label>
                        </div>
                        <p>For the photo, please upload file extension ONLY with 'JPEG, JPG, PNG, BMP'</p>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Nationality</th>
                      <td>
                        <div class="input-box">
                    <select id="natCd" name="natCd"> 
						<c:forEach var="nation" items="${nation}">
							<c:if test="${nation.natCd ne 'N0907142252536207193' }" >
							<option value="${nation.natCd}"  <c:if test="${ loginVO.memNation eq nation.natCd }" > selected </c:if>>${nation.natName }(${nation.natNameKr })</option>
							</c:if>
						</c:forEach>						                      
                    </select>
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>First Name</th>
                      <td>
                          <input type="hidden" tite="first name" alt="first name" name="firstName" value="${loginVO.memNameStr}" />
                          ${loginVO.memNameStr}
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Last Name</th>
                      <td>
                          <input type="hidden" tite="last name" alt="last name"  name="lastName"  value="${loginVO.memLastNameStr}" />
                          ${loginVO.memLastNameStr}
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Business Phone</th>
                      <td class="phone">
                      	+
                        <div class="input-box">
                          <input type="text" title="country code" alt="country code" name="phone1" id="phone1" numberonly />
                        </div>
                        <span>-</span>
                        <div class="input-box">
                          <input type="text" title="Business Phone number" alt="Business Phone number"  name="phone2" id="phone2" maxlength="4" numberonly />
                        </div>
                        <span>-</span>
                        <div class="input-box">
                          <input type="text" title="Business Phone number" alt="Business Phone number" name="phone3" id="phone3" maxlength="4" numberonly />
                        </div>
                        <span>-</span>
                        <div class="input-box">
                          <input type="text" title="Business Phone number" alt="Business Phone number" name="phone4" id="phone4" maxlength="4" numberonly  />
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Mobile Phone</th>
                      <td class="phone">
                      	+
                        <div class="input-box">
                          <input type="text" title="country code" alt="country code" name="mobile1" id="mobile1" numberonly />
                        </div>
                        <span>-</span>
                        <div class="input-box">
                          <input type="text" title="Mobile Phone number" alt="Business Phone number" name="mobile2" id="mobile2" maxlength="4" numberonly />
                        </div>
                        <span>-</span>
                        <div class="input-box">
                          <input type="text" title="Mobile Phone number" alt="Business Phone number" name="mobile3" id="mobile3" maxlength="4" numberonly />
                        </div>
                        <span>-</span>
                        <div class="input-box">
                          <input type="text" title="Mobile Phone number" alt="Business Phone number" name="mobile4" id="mobile4" maxlength="4" numberonly />
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Department</th>
                      <td>
                        <div class="input-box">
                          <input type="text" title="Department" alt="Department" name="department" value="" />
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th>Position</th>
                      <td>
                        <div class="input-box">
                          <input type="text" title="Position" alt="Position" name="position" value="" />
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Business Email</th>
                      <td>
                        <div class="input-box">
                          <input type="text" title="Business Email" alt="Business Email" name="businessEmail" value="${loginVO.emailStr}" />
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Private Email</th>
                      <td>
                        <div class="input-box">
                          <input type="text" title="Private Email" alt="Private Email" name="privateEmail" value="" />
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Organization</th>
                      <td class="radio-select">
						<input type="text" title="Organization" alt="Organization" name="organizationName"  id="organizationName" value="" />                   
 						<div class="radio-box">
						 <input type="radio" name="organizationType" id="public" onclick="javascript:organizationTypeChk();"    value="public"  /><label for="public"> Public </label>
						 <input type="radio" name="organizationType" id="private" onclick="javascript:organizationTypeChk();"   value="private" /><label for="private"> Private </label>
						</div>
						 <p>For the organzation, please write in full name. ex) Ministry of Informatization (O) / MOI (X)</p>
	
							<!-- Public 선택시 -->
							<div  id="oraganizationPub"  style="display:none;">
								<input type="checkbox" name="organizationDetailType" id="orgGov" value="gov"  /><label for="orgGov">Government (Ministry, Commission, Agency, etc) </label>
								<input type="checkbox" name="organizationDetailType" id="orgSta" value="sta"  /><label for="orgSta">State Enterprise  </label>
								<input type="checkbox" name="organizationDetailType" id="orgPubOther" value="pubOth"  /><label for="orgPubOther">Others (Ex. Academy) </label>
							</div>
							<!--   Private 선택시 -->
							<div id="oraganizationPri" style="display:none;">
								<input type="checkbox" name="organizationDetailType" id="orgAss" value="ass"   /><label for="orgAss">Association</label>
								<input type="checkbox" name="organizationDetailType" id="orgCom" value="com"   /><label for="orgCom">Company</label>
								<input type="checkbox" name="organizationDetailType" id="orgPriOther" value="priOth" /><label for="orgPriOther">Others (Ex. Academy)</label>
							</div>
							<input type="text" name="organizationEtcType" id="organizationEtcType"   style="display:none;" value=""/>
						</div>

                      </td>
                    </tr>
                    <tr>
                      <th>Gender</th>
                      <td class="radio-select">
                        <div class="radio-box">
                          <input type="radio" id="Male" name="gender" title="Male" alt="Male"  value="m"  />
                          <label for="Male">Male</label>
                        </div>
                        
                        <div class="radio-box">
                          <input type="radio" id="Female" name="gender" title="Female" alt="Female"  value="f" />
                          <label for="Female">Female</label>
                        </div>
                        <p>※ According to the K-LINK regulation, females and people with disabilities are given advantages in ICT training program.</p>
                        <input name="disChk" id="disChk" value="Y" onclick="disabilityChk();" type="checkbox" title="" alt="">
                        <label for="disChk">Please check this box if you have disability. If yes, please write down your disability.</label>
                        <input type="text" name="disability" id="disability" value="" />

                      </td>
                    </tr>
                    
                    <tr>
                      <th>Date of Birth</th>
                      <td class="birth">
                        <div class="input-box">
                          <input type="text" title="Birth Date" name="birthdate" id="birthdate" value="${loginVO.memBirthStr}" alt="Birth Date" /> 
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Organization<br/>Website (Optional)</th>
                      <td>
                        <div class="input-box">
                          <input type="text" title="website" alt="website"  name="website" id="website" value="" />
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Passport copy</th>
                      <td>
                        <div class="input-file">
                          <input class="upload-name" id ="file_text2" disabled="disabled" />
                          <input type="file" name="passportFile" id="passportFile" accept="image/*" class="upload-hidden"  onchange="javascript:$('#file_text2').val(this.value);"  />
                          <label for="passportFile">Upload</label>
                        </div>

                        <p>For the photo, please upload file extension ONLY with 'JPEG, JPG, PNG, BMP'</p>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Business Card copy</th>
                      <td>
                        <div class="input-file">
                          <input class="upload-name"  id ="file_text3" disabled="disabled" />
                          <input type="file" name="businessCardFile" id="businessCardFile" accept="image/*" class="upload-hidden" onchange="javascript:$('#file_text3').val(this.value);"  />
                          <label for="businessCardFile">Upload</label>
                        </div>
 
                        <p>For the photo, please upload file extension ONLY with 'JPEG, JPG, PNG, BMP'</p>
                      </td>
                    </tr>
                  </table>
                </div>

                 <br />
                 <br />
                 
                <div class="step-3 step-area"> 
                  <div class="step-text">
                    <p>It is necessary to have someone as a reference (nominator) if you want to apply for the course. The reference could be divided into two types :</p>
                    <p>EITHER guarantee and verification of the applicant’s ability from the superior (The reference should be in higher position than Department Head of the applicant’s organization or managerial position of the upper body.)</p>
                    <p>OR guarantee from the business partner in Korea. (The reference should be someone from Korean government or Korean company that is cooperating with the applicant’s organization.)</p>
                    <p>Please have the reference fill out `Letter of Reference` and upload it. `Letter of Reference` froms could be downloaded from the `News & Notice` from `News` section of the website.</p>
                  </div>
                  <table>
                    <tr>
                      <th>Name of the Reference</th>
                      <td>
                        <textarea name="referenceName" id="referenceName" ></textarea>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Nationality of the reference</th>
                      <td>
                        <div class="input-box">

 					<select id="referenceNation" name="referenceNation"> 
						<c:forEach var="nation" items="${nation}">
							<option value="${nation.natCd}"  <c:if test="${'N0907142252536207193' eq nation.natCd }"> selected </c:if> >${nation.natName }(${nation.natNameKr })</option>
						</c:forEach>						                      
                    </select>
                                              
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Organization of the reference</th>
                      <td>
                        <textarea name="referenceOrganization" id="referenceOrganization"></textarea>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Position of the reference</th>
                      <td>
                        <textarea name="referencePosition" id="referencePosition"></textarea>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Organization of the reference</th>
                      <td class="app-con">
                        <div class="input-file">
                          <input class="upload-name" id ="file_text4" disabled="disabled" />
                          <input type="file" name="letterFile" id="letterFile"   class="upload-hidden" onchange="javascript:$('#file_text4').val(this.value);"  /> 
                          <label for="letterFile">Upload</label>
                          <c:if test="${!empty courseFormFile_Step3File01 and !empty courseFormFile_Step3File01.courseFormFileName   }"><label for="sample"><a href="/lu/course/getCourseFile?courseCd=${ courseDetail.courseCd}&downFileNo=3" >sample-file</a></label></c:if>
                        </div>

                      </td>
                    </tr>
                  </table>
                </div>
                
                <br />
                <br />
                 
                <div class="step-4 step-area"> 
                  <div class="step-text">
                    <p>When you click the register button, all data you have typed will be electronically sent to an internal committee and your participation  will be decided based on your given information.</p>
                  </div>
                  
                  <div class="application">
                    <span>1. Please describe ICT Projects in your organization or country based on the attached form.</span>
                    <div class="app-con">
                      <div class="input-file">
                        <input class="upload-name"  id ="file_text5" disabled="disabled" />
                        <input type="file" name="ictFile" id="ictFile" class="upload-hidden" onchange="javascript:$('#file_text5').val(this.value);"  /> 
                        <label for="ictFile">Upload</label>
                        <c:if test="${!empty courseFormFile_Step4File01 and !empty courseFormFile_Step4File01.courseFormFileName   }"><label for="sample"><a href="/lu/course/getCourseFile?courseCd=${ courseDetail.courseCd}&downFileNo=4" >sample-file</a></label</c:if>
                      </div>
                    </div>
                    
                    <span>2. Is there any Korean Companies you would like to have a business meeting with?</span>
                    <div class="app-con">
                      <textarea name="businessMeeting" id="businessMeeting"></textarea>
                    </div>
                    
                    <span>3. Please describe current cooperation between Korean government/companies and your organization</span>
                    <div class="app-con">
                      <textarea name="cooperation" id="cooperation"></textarea>
                    </div>
                    
                    <span>4. Please explain your job duty..</span>
                    <div class="app-con">
                      <textarea name="jobDuty" id="jobDuty"></textarea>
                    </div>
                    
                    <span>5. Please describe any topics, lectures or places of interest you would like to see in the course related to your tasks mentioned above.</span>
                    <div class="app-con">
                      <textarea name="courseRelatedTasks" id="courseRelatedTasks"></textarea>
                    </div>
                    
                    <span>6. What are you trying to achieve through this program?</span>
                    <div class="app-con">
                      <textarea name="achieve" id="achieve"></textarea>
                    </div>
                  </div>
                </div>
                 
</form>                 
              </div>
            </div>
            <div class="btn-box">
            	
            	<div class="btn-white" onclick="javascript:fn_save('S2');">Temporary save</div>
			    <div class="btn-blue" onclick="javascript:fn_save('SS');">Apply</div>
			</div>
		  </div>
        </div><!-- E : main-contents --> 
    </div><!-- E : container -->