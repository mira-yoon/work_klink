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
    var tempPhone = $("#phone").val();
    var tempMobile = $("#mobile").val();
    
    var phonelist = tempPhone.split("-");
    $("#phone1").val(phonelist[0]);
    $("#phone2").val(phonelist[1]);
    $("#phone3").val(phonelist[2]);
    $("#phone4").val(phonelist[3]);
    
    var mobilelist = tempMobile.split("-");
    $("#mobile1").val(mobilelist[0]);
    $("#mobile2").val(mobilelist[1]);
    $("#mobile3").val(mobilelist[2]);
    $("#mobile4").val(mobilelist[3]);
    
    
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

	<c:if test="${ empty applyUserInfoVO.disability}">
	$("#disability").hide();
	</c:if>
	
	
});

function disabilityChk(){
	if( $("#disChk").prop("checked") ){
		$("#disability").show();
	} else {
		$("#disability").hide();
	}
}
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
function fn_save(type){
	
	$("#phone").val($("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val() + "-" +$("#phone4").val());
	$("#mobile").val($("#mobile1").val() + "-" + $("#mobile2").val() + "-" + $("#mobile3").val() + "-" +$("#mobile4").val());
	$("#stepCd").val(type);
	
	if(type=='SS'){
		if($("#photoFile").val()){
			if(!$("#file1").html()){
				alert("Please fill your Photo");
				return false;				
			}
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
			if(!$("#file2").html()){
			alert("Please fill your Passport Copy");
			return false;
			}
		}
		if( !$("#file_text3").val() ){
			if(!$("#file3").html()){
			alert("Please fill your Business Card copy");
			return false;
			}
		}
		if( !$("#file_text4").val()){
			if(!$("#file4").html()){
			alert("Please fill your Organization of the reference");
			return false;
			}
		}
		if( !$("#file_text5").val() ){
			if(!$("#file5").html()){
			alert("Please fill your ICT Projects");
			return false;
			}
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
	
	var reqUrl = "/lu/apply/updateApply";
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


/** 첨부파일 삭제처리 */
function fn_deleteApplyUserFile(seq){
	 
	if(confirm("Are you sure you want to delete the attachment?")){
		$.ajax({
			url:"/lu/apply/deleteApplyUserFile.do",
			type:"post",
			data:{"applyCd" : "${applyUserInfoVO.applyCd}","deleteFileNo":seq},
			dataType:"json",
			success:function(data){
				var result = data.data;
				if(result > 0){ 
					$("#file"+seq).html("");
					$("#inputfile"+seq).show();
					 
				}else{
					alert("Please click again.");
				}
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		})
	} 
}

/** 첨부파일 다운로드 */
function fn_applyFileDown(seq){
	 
 		$("#downFileNo").val(seq);
		var reqUrl = "/lu/apply/getFile";
		$("#frmApplyUserInfo").attr("action", reqUrl);
		$("#frmApplyUserInfo").submit();
}

function fn_delete(){
	
	if(confirm("Are you sure you want to cancel your application?\nAll information entered will not be restored.")){
		var reqUrl = "/lu/apply/deleteApply";
		$("#frmApplyUserInfo").attr("action", reqUrl);
		$("#frmApplyUserInfo").submit();		
	}else{
		return;
	}

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
<input type="hidden"  name="phone" id="phone" value="${applyUserInfoVO.phoneStr}"  />
<input type="hidden"  name="mobile" id="mobile" value="${applyUserInfoVO.mobileStr}"  />
<input type="hidden" name="courseCd" id="courseCd"  value="${applyUserInfoVO.courseCd}" />
<input type="hidden"  name="applyCd" id="applyCd" value="${applyUserInfoVO.applyCd}"/>
<input type="hidden"  name="stepCd" id="stepCd" />
<input type="hidden"  name="downFileNo" id="downFileNo" />

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
                        <div class="input-file" id="inputfile1" <c:if test="${not empty applyUserInfoVO.photoFileName}"> style="display:none;" </c:if> >
                          <input class="upload-name" id="file_text1" disabled="disabled">
                          <input type="file" id="photoFile" name="photoFile"  accept="image/*" class="upload-hidden" onchange="javascript:$('#file_text1').val(this.value);"  /> 
                          <label for="photoFile">Upload</label>
                        </div>
                        <c:if test="${not empty applyUserInfoVO.photoFileName}">
                        <div class="file-name" id="file1" >
                          <a href="#" onclick="javascript:fn_applyFileDown('1');" >${applyUserInfoVO.photoFileName}</a>
                          <c:if test="${courseDetail.todayType eq 'A' }">
                          <a href="#" onclick="javascript:fn_deleteApplyUserFile('1');"><i class="fa fa-times-circle"></i></a>
                          </c:if>
                        </div>
                        </c:if>
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
							<option value="${nation.natCd}"  <c:if test="${ applyUserInfoVO.natCd eq nation.natCd }" > selected </c:if>>${nation.natName }(${nation.natNameKr })</option>
							</c:if>
						</c:forEach>						                      
                    </select>
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>First Name</th>
                      <td>
                        <div class="input-box">
                          <input type="hidden" tite="first name" alt="first name" name="firstName" value="${applyUserInfoVO.firstNameStr}" />
                          ${applyUserInfoVO.firstNameStr}
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Last Name</th>
                      <td>
                        <div class="input-box">
                          <input type="hidden" tite="last name" alt="last name"  name="lastName"  value="${applyUserInfoVO.lastNameStr}"    />
                          ${applyUserInfoVO.lastNameStr}
                        </div>
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
                          <input type="text" title="Business Phone number" alt="Business Phone number" name="phone2" id="phone2" maxlength="4" numberonly />
                        </div>
                        <span>-</span>
                        <div class="input-box">
                          <input type="text" title="Business Phone number" alt="Business Phone number" name="phone3" id="phone3" maxlength="4" numberonly />
                        </div>
                        <span>-</span>
                        <div class="input-box">
                          <input type="text" title="Business Phone number" alt="Business Phone number" name="phone4" id="phone4" maxlength="4" numberonly />
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
                          <input type="text" title="Department" alt="Department" name="department" value="${applyUserInfoVO.department}" />
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th>Position</th>
                      <td>
                        <div class="input-box">
                          <input type="text" title="Position" alt="Position" name="position" value="${applyUserInfoVO.position}" />
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Business Email</th>
                      <td>
                        <div class="input-box">
                          <input type="text" title="Business Email" alt="Business Email" name="businessEmail" value="${applyUserInfoVO.businessEmailStr}" />
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Private Email</th>
                      <td>
                        <div class="input-box">
                          <input type="text" title="Private Email" alt="Private Email" name="privateEmail" value="${applyUserInfoVO.privateEmailStr}" />
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Organization</th>
                      <td class="radio-select">
						<input type="text" title="Organization" alt="Organization" name="organizationName"  id="organizationName" value="${applyUserInfoVO.organizationName}" />                   
 						<div class="radio-box">
						 <input type="radio" name="organizationType" id="public"   onclick="javascript:organizationTypeChk();" <c:if test="${applyUserInfoVO.organizationType eq 'public' }">checked</c:if> value="public"  /><label for="public"> Public </label>
						 <input type="radio" name="organizationType" id="private" onclick="javascript:organizationTypeChk();"  <c:if test="${applyUserInfoVO.organizationType eq 'private' }">checked</c:if> value="private" /><label for="private"> Private </label>
						</div>
						 <p>For the organzation, please write in full name. ex) Ministry of Informatization (O) / MOI (X)</p>
	
						<div id="organizationTd" <c:if test="${empty applyUserInfoVO.organizationType}">style="display:none;"</c:if>  >
							<!-- Public 선택시 -->
							<div  id="oraganizationPub"  <c:if test="${applyUserInfoVO.organizationType ne 'public' }">style="display:none;"</c:if>  >
								<input type="checkbox" name="organizationDetailType" id="orgGov" value="gov" <c:if test="${applyUserInfoVO.organizationDetailType eq 'gov' }">checked</c:if>  /><label for="orgGov">Government (Ministry, Commission, Agency, etc) </label>
								<input type="checkbox" name="organizationDetailType" id="orgSta" value="sta"  <c:if test="${applyUserInfoVO.organizationDetailType eq 'sta' }">checked</c:if> /><label for="orgSta">State Enterprise  </label>
								<input type="checkbox" name="organizationDetailType" id="orgPubOther" value="pubOth"  <c:if test="${applyUserInfoVO.organizationDetailType eq 'pubOth' }">checked</c:if> /><label for="orgPubOther">Others (Ex. Academy) </label>
							</div>
							<!--   Private 선택시 -->
							<div id="oraganizationPri" <c:if test="${applyUserInfoVO.organizationType ne 'private' }">style="display:none;"</c:if>  >
								<input type="checkbox" name="organizationDetailType" id="orgAss" value="ass"  <c:if test="${applyUserInfoVO.organizationDetailType eq 'ass' }">checked</c:if>  /><label for="orgAss">Association</label>
								<input type="checkbox" name="organizationDetailType" id="orgCom" value="com" <c:if test="${applyUserInfoVO.organizationDetailType eq 'com' }">checked</c:if>  /><label for="orgCom">Company</label>
								<input type="checkbox" name="organizationDetailType" id="orgPriOther" value="priOth" <c:if test="${applyUserInfoVO.organizationDetailType eq 'priOth' }">checked</c:if> /><label for="orgPriOther">Others (Ex. Academy)</label>
							</div>
							<input type="text" name="organizationEtcType" id="organizationEtcType"  <c:if test="${applyUserInfoVO.organizationDetailType ne 'pubOth' and applyUserInfoVO.organizationDetailType ne 'priOth'}">style="display:none;"</c:if>   value="${applyUserInfoVO.organizationEtcType}"/>
						</div>

                      </td>
                    </tr>
                    <tr>
                      <th>Gender</th>
                      <td class="radio-select">
                        <div class="radio-box">
                          <input type="radio" id="Male" name="gender" title="Male" alt="Male"  value="m" <c:if test="${applyUserInfoVO.gender eq 'm' }">checked</c:if> />
                          <label for="Male">Male</label>
                        </div>
                        
                        <div class="radio-box">
                          <input type="radio" id="Female" name="gender" title="Female" alt="Female"  value="f" <c:if test="${applyUserInfoVO.gender eq 'f' }">checked</c:if> />
                          <label for="Female">Female</label>
                        </div>
                        <p>※ According to the K-LINK regulation, females and people with disabilities are given advantages in ICT training program.</p>
                        <input name="disChk" id="disChk" value="Y" onclick="javascript:disabilityChk();" type="checkbox" title="" alt="">
                        <label for="disChk">Please check this box if you have disability. If yes, please write down your disability.</label>
                        <input type="text" name="disability" id="disability" value="${applyUserInfoVO.disability}" />
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Date of Birth</th>
                      <td class="birth">
                        <div class="input-box">
                          <input type="text" title="Birth Date" name="birthdate" id="birthdate" value="${applyUserInfoVO.birthdate}" alt="Birth Date" /> 
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Organization<br/>Website (Optional)</th>
                      <td>
                        <div class="input-box">
                          <input type="text" title="website" alt="website"  name="website" id="website" value="${applyUserInfoVO.website}" />
                        </div>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Passport copy</th>
                      <td>
                        <div class="input-file" id="inputfile2"  <c:if test="${not empty applyUserInfoVO.passportFileName}"> style="display:none;" </c:if>>
                          <input class="upload-name" id ="file_text2" disabled="disabled" />
                          <input type="file" name="passportFile" id="passportFile" accept="image/*" class="upload-hidden"  onchange="javascript:$('#file_text2').val(this.value);"  /> 
                          <label for="passportFile">Upload</label>
                        </div>
                        <c:if test="${not empty applyUserInfoVO.passportFileName}">
                        <div class="file-name" id="file2" >
                          <a href="#" onclick="javascript:fn_applyFileDown('2');" >${applyUserInfoVO.passportFileName }</a>
                          <c:if test="${courseDetail.todayType eq 'A' }">
                          <a href="#" onclick="javascript:fn_deleteApplyUserFile('2');"><i class="fa fa-times-circle"></i></a>
                          </c:if>
                        </div>
                        </c:if>
                        <p>For the photo, please upload file extension ONLY with 'JPEG, JPG, PNG, BMP'</p>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Business Card copy</th>
                      <td>
                        <div class="input-file" id="inputfile3" <c:if test="${not empty applyUserInfoVO.businessCardFileName}"> style="display:none;" </c:if>>
                          <input class="upload-name"  id ="file_text3" disabled="disabled" />
                          <input type="file" name="businessCardFile" id="businessCardFile" accept="image/*" class="upload-hidden" onchange="javascript:$('#file_text3').val(this.value);"  /> 
                          <label for="businessCardFile">Upload</label>
                        </div>
                        <c:if test="${not empty applyUserInfoVO.businessCardFileName}">
                        <div class="file-name" id="file3" >
                          <a href="#" onclick="javascript:fn_applyFileDown('3');" >${applyUserInfoVO.businessCardFileName}</a>
                          <c:if test="${courseDetail.todayType eq 'A' }">
                          	<a href="#" onclick="javascript:fn_deleteApplyUserFile('3');">
                          	<i class="fa fa-times-circle"></i></a>
                          </c:if>
                        </div>
                        </c:if>
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
                        <textarea name="referenceName" id="referenceName" >${applyUserInfoVO.referenceName}</textarea>
                      </td>
                    </tr>
                    
                    <tr>
                      <th>Nationality of the reference</th>
                      <td>
                        <div class="input-box">

 					<select id="referenceNation" name="referenceNation"> 
						<c:forEach var="nation" items="${nation}">
							<option value="${nation.natCd}" <c:if test="${ applyUserInfoVO.referenceNation eq nation.natCd }" > selected </c:if> >${nation.natName }(${nation.natNameKr })</option>
						</c:forEach>						                      
                    </select>
                                              
                        </div>
                      </td>
                    </tr>

                    <tr>
                      <th>Organization of the reference</th>
                      <td>
                        <textarea name="referenceOrganization" id="referenceOrganization">${applyUserInfoVO.referenceOrganization}</textarea>
                      </td>
                    </tr>

                    <tr>
                      <th>Position of the reference</th>
                      <td>
                        <textarea name="referencePosition" id="referencePosition">${applyUserInfoVO.referencePosition}</textarea>
                      </td>
                    </tr>

                    <tr>
                      <th>Organization of the reference</th>
                      <td class="app-con">
                        <div class="input-file"  id="inputfile4" <c:if test="${not empty applyUserInfoVO.referenceFileName}"> style="display:none;" </c:if> >
                          <input class="upload-name" id ="file_text4" disabled="disabled" />
                          <input type="file" name="letterFile" id="letterFile"   class="upload-hidden" onchange="javascript:$('#file_text4').val(this.value);"  /> 
                          <label for="letterFile">Upload</label>
                          <c:if test="${!empty courseFormFile_Step3File01 and !empty courseFormFile_Step3File01.courseFormFileName   }"><label for="sample3"><a href="/lu/course/getCourseFile?courseCd=${ courseDetail.courseCd}&downFileNo=3" >sample-file</a></label></c:if>
                        </div>
                        <c:if test="${not empty applyUserInfoVO.referenceFileName}">
                        <div class="file-name" id="file4" >
                          <a href="#" onclick="javascript:fn_applyFileDown('4');">${applyUserInfoVO.referenceFileName}</a>
                          <c:if test="${courseDetail.todayType eq 'A' }">
                          <a href="#" onclick="javascript:fn_deleteApplyUserFile('4');">
                          <i class="fa fa-times-circle"></i></a>
                          </c:if>
                        </div>
                        </c:if>
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
                      <div class="input-file" id="inputfile5" <c:if test="${not empty applyUserInfoVO.ictFileName}"> style="display:none;" </c:if> >
                        <input class="upload-name"  id ="file_text5" disabled="disabled" />
                        <input type="file" name="ictFile" id="ictFile" class="upload-hidden" onchange="javascript:$('#file_text5').val(this.value);"  /> 
                        <label for="ictFile">Upload</label>
                        <c:if test="${!empty courseFormFile_Step4File01 and !empty courseFormFile_Step4File01.courseFormFileName   }"><label for="sample4"><a href="/lu/course/getCourseFile?courseCd=${ courseDetail.courseCd}&downFileNo=4" >sample-file</a></label</c:if>
                      </div>

                      <c:if test="${not empty applyUserInfoVO.ictFileName}">
                        <div class="file-name" id="file5" >
                          <a href="#" onclick="javascript:fn_applyFileDown('5');" >${applyUserInfoVO.ictFileName}</a>
                          <c:if test="${courseDetail.todayType eq 'A' }"><a href="#" onclick="javascript:fn_deleteApplyUserFile('5');">
                          <i class="fa fa-times-circle"></i></a></c:if>
                        </div>
                      </c:if>                      
                    </div>

                    <span>2. Is there any Korean Companies you would like to have a business meeting with?</span>
                    <div class="app-con">
                      <textarea name="businessMeeting" id="businessMeeting">${applyUserInfoVO.businessMeeting}</textarea>
                    </div>

                    <span>3. Please describe current cooperation between Korean government/companies and your organization</span>
                    <div class="app-con">
                      <textarea name="cooperation" id="cooperation">${applyUserInfoVO.cooperation}</textarea>
                    </div>

                    <span>4. Please explain your job duty..</span>
                    <div class="app-con">
                      <textarea name="jobDuty" id="jobDuty">${applyUserInfoVO.jobDuty}</textarea>
                    </div>

                    <span>5. Please describe any topics, lectures or places of interest you would like to see in the course related to your tasks mentioned above.</span>
                    <div class="app-con">
                      <textarea name="courseRelatedTasks" id="courseRelatedTasks">${applyUserInfoVO.courseRelatedTasks}</textarea>
                    </div>

                    <span>6. What are you trying to achieve through this program?</span>
                    <div class="app-con">
                      <textarea name="achieve" id="achieve">${applyUserInfoVO.achieve}</textarea>
                    </div>
                  </div>
                </div>

</form>
              </div>
            </div>

<c:if test="${courseDetail.todayType eq 'A' }">
	<c:if test="${applyUserInfoVO.stepCd ne 'SS' }">             
            <div class="btn-box">            	
            	<div class="btn-white" onclick="javascript:fn_save('S2');">Temporary save</div>
			    <div class="btn-blue" onclick="javascript:fn_save('SS');">Apply</div>
			</div>
	</c:if>
	<c:if test="${applyUserInfoVO.stepCd eq 'SS' }">
            <div class="btn-box">            	
			    <div class="btn-blue" onclick="javascript:fn_save('SS');">Modify</div>
			    <div class="btn-blue" onclick="javascript:fn_delete();">DELETE</div>
			</div>	
	</c:if>
</c:if>
		  </div>
        </div><!-- E : main-contents --> 
    </div><!-- E : container -->