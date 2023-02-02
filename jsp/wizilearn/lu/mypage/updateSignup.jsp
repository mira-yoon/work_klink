<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

$(document).ready(function() {

	/* 타이틀 */
	$(document).attr("title","My Page > My Info > Modify : K-LINK");

	<c:if test="${empty result.memBirthStr}"> 
	com.datepicker('memBirth'); 
	alert('Please register your date of birth.');
	</c:if> 
	
});
/**
 * 비밀번호 체크 <br />
 * lang값이 "EN"일 경우 경고창 영문, "KR"입력시 국문 <br />
 * 1. 최소 8자리 이상 : 영자(대문자)/영자(소문자)/숫자/특수문자 중 3종류 이상으로 구성 <br />
 *    특수문자 : ~ ? ! \@ # $ % ^ & * ( ) _ - + =  [ ] [ ] | ; :‘ “ < > , . ? / <br />
 * 2. ‘12345678’과 같은 일련번호 구성 <br />
 * 3. ‘aaabbb’, ‘123123'과 같은 동일한 문자 반복 구성 <br />
 * 4. ‘qwerty’, ‘asdfgh’ 등과 같이 키보드상에서 연속한 위치에 존재하는 문자들의 집합으로 구성 <br />
 * 5. ‘security1’, ‘1security’ 등과 같이 숫자가 제일 앞이나 제일 뒤에 오는 구성 <br />
 * 
 * @param obj
 * @param lang
 * 
 */
function checkPassword(obj, lang) {
	var passwd = obj.value;
	

	// 1. 영자(대문자)/영자(소문자)/숫자/특수문자 중 3종류
	var cnt = 0;
	var reg1 = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi; // 특수문자 정규식
	if ( /[a-z]/.test(passwd) )	cnt++;
	if ( /[A-Z]/.test(passwd) )	cnt++;
	if ( /[0-9]/.test(passwd) )	cnt++;
	if ( reg1.test(passwd) ) cnt++;
//	if ( (passwd.length < 8 || passwd.length > 20) || cnt < 3 ) {	//8자리 이상, 20자리 이하, 3종류 이상
//	if ( passwd.length < 8 || cnt < 3 ) {	//8자리 이상, 3종류 이상
	if ( passwd.length < 10 || cnt < 3 ) {	//10자리 고정//2014.05.12 10자리 이상
		if( "KR" === lang ){
//			alert("비밀번호는 8~20자 영자(대문자)/영자(소문자)/숫자/특수문자 중 3종류 이상으로 구성되어야 합니다.");
//			alert("비밀번호는 8자 이상 영자(대문자)/영자(소문자)/숫자/특수문자 중 3종류 이상으로 구성되어야 합니다.");
			alert("비밀번호는 10자 이상 영자(대문자)/영자(소문자)/숫자/특수문자 중 3종류 이상으로 구성되어야 합니다.");
		}else if( "EN" === lang ){
//			alert("Password must be at least eight characters long, and must be composed of at least three kinds of (uppercase / lowercase / numbers / special characters).");
			alert("Password must be 10-digit over, and must be composed of at least three kinds of (uppercase / lowercase / numbers / special characters).");
		}
		obj.focus();
		return false;
	}

	// 2. 일련번호 구성 체크
	var req2 = ["01234567890"];
	var sliceLen1 = 4;
	var chkResult1 = patArrayChecker(req2, sliceLen1, passwd, true);

	if( chkResult1 ){
		if( "KR" === lang ){
			alert("비밀번호에 "+ sliceLen1 +"자리 이상의 일련번호가 포함되어 있습니다.");
		}else if( "EN" === lang ){
			alert("Password over the "+ sliceLen1 +"digit serial number is included.");
		}
		obj.focus();
		return false;
	}


	// 3. 동일한 문자 구성 체크

	var reg3 = /(\w|[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"])\1\1\1/; // 같은 영문자&숫자&특수문자 연속 4번 정규식
	if ( reg3.test(passwd) ) {
		if( "KR" === lang ){
			alert("비밀번호에 동일한 문자가 4자리이상 연속해서 포함되어 있습니다.");
		}else if( "EN" === lang ){
			alert("The same characters in the password must be at least 4 characters includes continuous.");
		}
		obj.focus();
		return false;
	}

	// 4. 키보드상의 연속 문자 구성 체크

	var req3 = ["qwertyuiop", "asdfghjkl", "zxcvbnm", "QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"];
	var sliceLen2 = 4;
	var chkResult2 = patArrayChecker(req3, sliceLen2, passwd, true);

	if( chkResult2 ){
		if( "KR" === lang ){
			alert("비밀번호에 키보드상 연속으로 나열된 문자가 포함되어 있습니다.");
		}else if( "EN" === lang ){
			alert("Characters listed in a row on the keyboard are included.");
		}
		obj.focus();
		return false;
	}
	

	// 5. 숫자가 제일 앞이나 제일 뒤에 오는 구성 체크
	var reg5 = /^[0-9]|[0-9]$/;		
	if ( reg5.test(passwd) ) {
		if( "KR" === lang ){
			alert("비밀번호에 숫자가 시작 혹은 끝에 포함되어 있습니다.");
		}else if( "EN" === lang ){
			alert("Please do not include a number at the beginning or end of your password.");
		}
		obj.focus();
		return false;
	}

	
	return true;//적용시
}

//1.정규식으로 변경할 문자열의 배열과 대상 문자열을 받아 비교한다.
//2.해당 문자열이 있을 시 true를 반환한다.
//ex) true == patArrayChecker(["asdfgh","123456"], 3, "1asdc", false)
//  false == patArrayChecker(["asdfgh","123456"], 3, "1c543z", false)
//  true == patArrayChecker(["asdfgh","123456"], 3, "1c543z", true)

function patArrayChecker(reqArray, reqSliceLen, reqWord, withReverse){
var patArray = overlapSliceArray( reqArray, reqSliceLen, withReverse);

//검사
for	(var i=0;i<patArray.length;i++){
		var regex = eval("/"+patArray[i]+"/");
		if ( regex.test(reqWord) ) {
			return true;
		}
	}
return false;
}

function overlapSliceArray( reqArray, reqSliceLen, withReverse ){
//문자열의 배열을 받아 각 문자열을 한글자씩 밀며 조각내어 부분 중첩된 문자열의 배열로 반환
//ex) (["abcdef", "356890"], 4, false) => ["abcd", "bcde", "cdef", "3568", "5689","6890"]
//reqSliceLen보다 길이가 작은 배열은 무시
var arrayCnt = reqArray.length;
var slicedArray = new Array();

for(var ai=0;ai<arrayCnt;ai++){
	var strLen = reqArray[ai].length;		

	if( strLen >= reqSliceLen ){
		for(var si=0;si<(strLen-reqSliceLen+1);si++){
			//정방향
			slicedArray.push(reqArray[ai].slice(si,si+reqSliceLen));				
			//역방향
			if( withReverse ){
				slicedArray.push(reqArray[ai].slice(si,si+reqSliceLen).split("").reverse().join(""));				
			}
		}
	}

}	
return slicedArray;
}



function doSave(){
	
	if( !checkPassword( document.getElementById("memPassword"), "EN" ) ){// 패스워드 정규식 체크
		$("#password").focus();
		return false;
	}
	 
	var memPassword = $("#memPassword").val();
	var memPasswordChk = $("#memPasswordChk").val();
	var memName = $("#memName").val();
	var memLastName = $("#memLastName").val();
	var orgName = $("#orgName").val();
	var depName = $("#depName").val();
	var memJob = $("#memJob").val();
	var telNo = $("#telNo").val();
	var hpNo = $("#hpNo").val();
	
	var memBirth = $("#memBirth").val();
	
	 
	if(!emailFlag){
		alert("You need to double check your email.");
		return;
	}
	/*
	if(!emailSubFlag){
		alert("You need to double check your sub email.");
		return;
	}
	*/
	if(memPassword == ''){
		alert("Please enter a password.");
		$("#memPassword").focus();
		return;
	}
	if(memPasswordChk == ''){
		alert("Please enter a password confirmation.");
		$("#memPasswordChk").focus();
		return;
	}
	if(memPassword != memPasswordChk){
		alert("The two passwords do not match.");
		$("#memPassword").focus();
		return;
	}
	if(memName == ''){
		alert("Please enter a First Name.");
		$("#memName").focus();
		return;
	}
	if(memLastName == ''){
		alert("Please enter a Last Name.");
		$("#memLastName").focus();
		return;
	}
	if(orgName == ''){
		alert("Type of Organization is required.");
		$("#orgName").focus();
		return;
	}
	if(depName == ''){
		alert("Please enter a department name.");
		$("#depName").focus();
		return;
	}
	if(memJob == ''){
		alert("Please enter a job.");
		$("#memJob").focus();
		return;
	}
	if(telNo == ''){
		alert("Business format is invalid.");
		$("#telNo").focus();
		return;
	}
	if(hpNo == ''){
		alert("Mobile format is invalid.");
		$("#hpNo").focus();
		return;
	}
	if(!memBirth){
		alert("Please enter your birth date.");
		return;
	}
	var reqUrl = "/lu/member/updateMember";
	$("#frmMember").attr("action", reqUrl);
	$("#frmMember").attr("target","_self");
	$("#frmMember").submit();
	
}
 

/**
 * 정규식 체크
 */
function isRegexCheck(value, regex) {
	var returnValue = false;
	returnValue = regex.test(value);
	return returnValue;
	 
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
var emailFlag = true;

function fn_findOverlapEmail(){
	var email = $("#email", "#frmMember").val();
	var emailText = document.getElementById('email');
	
	if(email != null && email != ''){
		$.ajax({
			url:"/lu/member/findOverlapEmail.do",
			type:"post",
			data:{"email" : email},
			dataType:"json",
			success:function(data){
				var result = data.data;
				if(result > 0){
					alert("This email is not available.");
					$("#email").val('');
				}else{
					emailText.readOnly = true;
					emailFlag = true;
					alert("Email available.");
				}
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		})
	}else{
		alert("Please enter your e-mail.");
		$("#email").focus();
	}
}

var emailSubFlag = true;

function fn_findOverlapEmailSub(){
	var email = $("#emailSub", "#frmMember").val();
	var emailText = document.getElementById('emailSub');
	
	if(email != null && email != ''){
		$.ajax({
			url:"/lu/member/findOverlapEmail.do",
			type:"post",
			data:{"email" : email},
			dataType:"json",
			success:function(data){
				var result = data.data;
				if(result > 0){
					alert("This email is not available.");
					$("#emailSub").val('');
				}else{
					emailText.readOnly = true;
					emailSubFlag = true;
					alert("Email available.");
				}
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		})
	}else{
		alert("Please enter your e-mail.");
		$("#emailSub").focus();
	}
}

function checkFile(param){
	
	 
	var fileName = $(param).val();
	$("#pictureName").val(fileName);
	var fileExt = fileName.slice(fileName.indexOf(".")+1).toLowerCase();
	
	if(fileExt == "exe"){
		alert("This file type cannot be registered.");
		$(param).val("");
		return false;
	}
	
	var fileSize = param.files[0].size;
	
	if(fileSize > 10000000){
		alert("You can not upload more than 10M size.");
		$(param).val("");
		return false;
	}else{
		var filesizeNumber = "";
		if(fileSize>1000000){
			filesizeNumber = ((fileSize/1000000).toFixed(2))+" M";
		}else if(fileSize>1000){
			filesizeNumber = ((fileSize/1000).toFixed(2))+" KB";
		}else{
			filesizeNumber = fileSize+" B";
		} 
	}
}


// $label에 focus된 것 처럼 보이게 하기 (for 웹접근성)
$(document).on('focusin focusout', ".upload-hidden", function (e) {
	var $btnUpload = $(this);
	var $label = $btnUpload.parent().find("label");
	e.type == 'focusin' ? $label.addClass('file-focus') : $label.removeClass('file-focus');
});

</script>
<div id="signUp">
	<form id="frmMember" name="frmMember" method="post" enctype="multipart/form-data">
		<input type="hidden" name="memSeq" value="${result.memSeq}" />
		<input type="hidden" name="memId" value="${result.memId}" />
		<table>
			<caption class="sr-only">Modify Information</caption>
			<tr>
				<th scope="row">User ID <span>*</span></th>
				<td>
					<div>
						${result.memId}
					</div>
				</td>
			</tr>

			<tr>
				<th scope="row">Password <span>*</span></th>
				<td>
					<div class="input-box"><input type="Password" title="Password" aria-label="Password"
							name="memPassword" id="memPassword" autocomplete="off" /></div>
					<p>Password must be 10 letters over : must include 3 types among upper cases, lower cases, numbers and
						special characters</p>
					<p>※ special characters : ~ ?! @ # $ % ^ & * ( ) _ - + = [ ] [ ] | \ ; :‘ “ <> , . ? / Password
							combination as below can not be used.</p>
					<ol class="guide-text">
						<li>1) serial numbers like ‘12345678’</li>
						<li>2) repeating same letters such as ‘aaabbb’, ‘123123'</li>
						<li>3) serial letters on keyboards like ‘qwerty’, ‘asdfgh’</li>
						<li>4) the case that numbers come first or last like ‘security1’, ‘1security’</li>
					</ol>
				</td>
			</tr>

			<tr>
				<th scope="row">Password Check <span>*</span></th>
				<td>
					<div class="input-box">
						<input type="Password" title="Password Check" aria-label="Password Check" name="memPasswordChk"
							id="memPasswordChk" autocomplete="off" />
					</div>
				</td>
			</tr>

			<tr>
				<th scope="row">Birth Date <span>*</span></th>
				<td>
					<div>
						<c:if test="${not empty result.memBirthStr}">
							${result.memBirthStr}
							<input type="hidden" name="memBirthStr" id="memBirth" value="${result.memBirthStr}" />
						</c:if>
						<c:if test="${empty result.memBirthStr}">
							<input type="text" title="Birth Date" aria-label="Birth Date" name="memBirthStr" id="memBirth" />
						</c:if>
					</div>
				</td>
			</tr>

			<tr>
				<th scope="row">Passport Copy</th>
				<td>
					<div class="input-file">
						<input type="text" id="pictureName" class="upload-name" disabled="disabled"
							title="the name of passport copy file" aria-label="the name of passport copy file" />
						<input type="file" accept="image/*" id="picture" name="file_atchFile" class="upload-hidden"
							onChange="javascript:checkFile(this);" aria-hidden="true" />
						<label for="picture">Upload</label>
					</div>
					<c:if test="${not empty result.memAtchfile}">
						<div class="picture-box">
							<img alt="picture-box" src="/commbiz/atchfle/getImage.do?atchFileId=${result.memAtchfile}" alt="the uploaded photo">
						</div>
					</c:if>
					<p>Please upload passport personal information page. Otherwise, your request would be rejected.</p>
				</td>
			</tr>

			<tr>
				<th scope="row">Given(First) Name <span>*</span></th>
				<td>
					<div>${result.memNameStr}
						<input type="hidden" name="memNameStr" value="${result.memNameStr}" id="firstName" />
					</div>
				</td>
			</tr>

			<tr>
				<th scope="row">Surname(Last) Name <span>*</span></th>
				<td>
					<div>${result.memLastNameStr}
						<input type="hidden" name="memLastNameStr" value="${result.memLastNameStr}" id="lastName" />
					</div>
				</td>
			</tr>

			<tr>
				<th scope="row">Nationality <span>*</span></th>
				<td>
					<div class="input-box">
						<label for="memNation" class="sr-only">Choose your nationality.</label>
						<select id="memNation" name="memNation" title="Choose your nationality." aria-label="Choose your nationality.">
							<c:forEach var="nation" items="${nation}">
								<option value="${nation.natCd}" <c:if test="${result.memNation eq nation.natCd }">selected
									</c:if> >${nation.natName }(${nation.natNameKr })</option>
							</c:forEach>
						</select>
					</div>
				</td>
			</tr>

			<tr>
				<th scope="row">Organization <span>*</span></th>
				<td>
					<div class="input-box">
						<input type="text" title="Organization" aria-label="Organization" name="orgName" id="orgName" value="${result.orgName}" />
					</div>
					<p>For the organzation, please write in full name. ex) Ministry of Informatization (O) / MOI (X)</p>
				</td>
			</tr>

			<tr>
				<th scope="row">Department / Division <span>*</span></th>
				<td>
					<div class="input-box">
						<input type="text" title="Department / Division" aria-label="Department / Division" name="depName" id="depName" value="${result.depName}" />
					</div>
				</td>
			</tr>

			<tr>
				<th scope="row">Job title / position<span>*</span></th>
				<td>
					<div class="input-box">
						<input type="text" title="Job title / position" aria-label="Job title / position" name="memJob" id="memJob" value="${result.memJob}" />
					</div>
				</td>
			</tr>

			<tr>
				<th scope="row">Type of Organization <span>*</span></th>
				<td class="radio-select">

					<c:forEach var="otlist" items="${otlist}">
						<div class="radio-box">
							<input type="radio" id="${otlist.codeName }" name="orgGubun" <c:if
								test="${otlist.codeCode eq result.orgGubun }"> checked </c:if> title="${otlist.codeName}"
							aria-label="${otlist.codeName}" value="${otlist.codeCode }" />
							<label for="${otlist.codeName }">${otlist.codeName }</label>
						</div>
					</c:forEach>

				</td>
			</tr>

			<tr>
				<th scope="row">Email <span>*</span></th>
				<td class="mail">
					<div class="input-box" title="your Email address" aria-label="your Email address">
						${result.emailStr}<input type="hidden" title="Email" aria-label="Email" id="email" name="emailStr" value="${result.emailStr}" /></div>

					<div class="check-box">
						<input type="checkbox" title="Check if you want mailing service." aria-label="Check if you want mailing service." name="mailingYn" id="mailingYn" value="Y" />
						<label for="mailingYn">Mailing</label>
					</div>
				</td>
			</tr>

			<tr>
				<th scope="row">Sub Email <span>*</span></th>
				<td>
					<div class="input-box"><input type="text" title="Sub Email address" aria-label="Sub Email address" id="emailSub" value="${result.emailSubStr}" name="emailSubStr" /></div>
					<a href="#" onclick="javascript:fn_findOverlapEmailSub();" class="btn-blue">Check</a>
				</td>
			</tr>

			<tr>
				<th scope="row">Mobile <span>*</span></th>
				<td>
					<div class="input-box"><input type="text" title="Mobile phone number" aria-label="Mobile phone number" name="hpNoStr" id="hpNo" value="${result.hpNoStr}" /></div>
					<p>Country code - City code - Number</p>
				</td>
			</tr>

			<tr>
				<th scope="row">Business Phone <span>*</span></th>
				<td>
					<div class="input-box"><input type="text" title="Business phone number"
							aria-label="Business phone number" name="telNoStr" id="telNo" value="${result.telNoStr}" /></div>
					<p>Country code - City code - Number</p>
				</td>
			</tr>
		</table>
	</form>
	<div class="btn-box">
		<a href="#" class="btn-blue" onclick="javascript:doSave();">Modify</a>
		<a href="/lu/mypage/myInfo.do" class="btn-white">Cancel</a>
	</div>
</div><!-- E : signUp -->