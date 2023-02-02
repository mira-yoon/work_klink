<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ 
taglib prefix="form" uri="http://www.springframework.org/tags/form"%><%@ 
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
<!--

	$(document).ready(function() {
		
		com.datepicker('searchStartDay');
		com.datepicker('searchEndDay');
		
		$("#allCheck").on("click", function() {
			if ($(this).is(":checked")) {
				$("input[name=applyCdArr]").prop("checked", true);
			} else {
				$("input[name=applyCdArr]").prop("checked", false);
			}
		});
		
		$("#step2").on("click", function() {
			if ($(this).is(":checked")) {
				$("input[class=check1]").prop("checked", true);
			} else {
				$("input[class=check1]").prop("checked", false);
			}
		});
		
		$("#step3").on("click", function() {
			if ($(this).is(":checked")) {
				$("input[class=check2]").prop("checked", true);
			} else {
				$("input[class=check2]").prop("checked", false);
			}
		});
		
		$("#step4").on("click", function() {
			if ($(this).is(":checked")) {
				$("input[class=check3]").prop("checked", true);
			} else {
				$("input[class=check3]").prop("checked", false);
			}
		});
		
	});
	
	/* 이전 목록 조회 */
	function fn_goList(){
		location.href="/la/apply/listApply";
	}
	
	/* 리스트 조회 */
	function fn_search( param1 ){
		$("#pageIndex").val( param1 ); 
		var reqUrl = "/la/apply/listApplyUser";
		$("#frmApply").attr("action", reqUrl);
		$("#frmApply").attr("target","_self");
		$("#frmApply").submit();
	}
	
	/* 엑셀다운 */
	function fn_excel(){
		var reqUrl = "/la/apply/listApplyUserExcelDown";
		$("#frmApply").attr("action", reqUrl);
		$("#frmApply").attr("target", "_blank");
		$("#frmApply").submit();
	}
	
	/* 선택엑셀다운로드*/
	function fn_select_excel(){
		var cnt = $("input[name=SELECT]:checkbox:checked").length;
		if( cnt == 0 ){
			alert("선택된 목록이 없습니다.");
			return false;
		}
		var reqUrl = "/la/apply/listApplyUserSelectExcelDown";
		$("#frmApply").attr("action", reqUrl);
		$("#frmApply").attr("target", "_blank");
		$("#frmApply").submit();
	}
	
	var dateInput_chk = false;
	var temp;
	//날짜 입력 폼 호출.
	function dateInput(applyCd,obj,mode,isInput,theDay){
		var today = new Date();
		var beforeDay = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
		if(theDay != ''){
			beforeDay = theDay;
		}
		if(dateInput_chk){
			doCancel();
		}
		if(isInput=='on'){
			if(!confirm('입력된 날짜를 수정하시겠습니까?')){
				return false;
			}
		}
		if(!dateInput_chk){
			temp = $(obj).parent().html();
			$(obj).parent().html('<input type="text" id="tempDate" value="'+beforeDay+'" style="width:68px;font-size: 12px;"/>'
					+'<input type="button" value="확인" onclick="doDate(\''+applyCd+'\',\''+mode+'\')" style="height:18px;"/>'
					+'<input type="button" value="취소" id="cancelBtn" onclick="doCancel()" style="height:18px;"/>');
			dateInput_chk = true;
			com.datepicker('tempDate');
			//setCalendar2("tempDate","2004:"+(today.getFullYear()+1),(today.getFullYear()+1)+"1231");
			$("#tempDate").focus();
		}
	}
	//날짜 입력 Ajax
	function doDate(applyCd,mode){
		$("#dateApplyCd","#frmDate").val(applyCd);
		$("#mode","#frmDate").val(mode);
		var input_date = $("#tempDate").val();
		if(mode === "start") {
			$("#dayStart").val(input_date); 
		} else if(mode === "end") {
			$("#dayEnd").val(input_date);
		}
		
		var reqUrl = "/la/apply/updateApplyJoinDate";
		var params = $("#frmDate").serialize();
		
		$.ajax({
			url:reqUrl,
			type:"post",
			data:params,
			dataType:"json",
			success:function(data){
				var result = data.msg;
				if(result == "success"){
					alert("수정되었습니다.");
					fn_search('1');
				}else{
					alert("작업 진행중 오류가 발행하였습니다.");
				}
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		});
	}
	//날짜 입력폼 감추고 기존 html복귀.
	function doCancel(){
		if(confirm("현재 입력을 취소하시겠습니까?")){
			$("#cancelBtn").parent().html( $(temp) );
			dateInput_chk = false;
			return true;
		}else{
			return false;
		}
	}
	
	/* 삭제 */
	function fn_del() {
		if(!confirm("삭제하시겠습니까?")) return false;
		
		var applyArr = [];
		var check=true;
		$("input[name='applyCdArr']:checked").each(function() {
			check=false;
			applyArr.push($(this).val());
			console.log($(this).val());
		});
		if(check){
			alert("대상을 선택하세요");
			return;
		}
		var reqUrl = "/la/apply/deleteApplyUserInfo";
		
		$.ajax({
			url:reqUrl,
			type:"post",
			data:{ applyCds:applyArr },
			dataType:"json",
			success:function(data){
				var result = data.msg;
				if(result == "success"){
					alert("삭제되었습니다.");
					fn_search('1');
				}else{
					alert("작업 진행중 오류가 발행하였습니다.");
				}
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		});
	}
	
	/* 상태수정 */
	function fn_update_status(){
		if(!confirm("수정하시겠습니까?")) return false;
		
		var applyArr = [];
		var check=true;
		$("input[name='applyCdArr']:checked").each(function() {
			check=false;
			applyArr.push($(this).val());
			console.log($(this).val());
		});
		if(check){
			alert("대상을 선택하세요");
			return;
		}
	    var statusMdCd = $("#statusModCd").val();
	    console.log(statusMdCd);
	    var courseCd = $("#courseCd").val();
	    
	    var reqUrl = "/la/apply/updateApplyStatus";
		
		$.ajax({
			url:reqUrl,
			type:"post",
			data:{ statusModCd:statusMdCd, applyCds:applyArr, courseCd:courseCd },
			dataType:"json",
			success:function(data){
				var result = data.msg;
				if(result == "success"){
					alert("수정되었습니다.");
					fn_search('1');
				}else{
					alert("작업 진행중 오류가 발행하였습니다.");
				}
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		});
	}
	
	/* 연락여부 수정 */
	function fn_update_apply_contactYn(){
		if(!confirm("수정하시겠습니까?")) return false;
		
		var applyArr = [];
		var check=true;
		$("input[name='applyCd']:checked").each(function() {
			check=false;
			applyArr.push($(this).val());
			console.log($(this).val());
		});
		if(check){
			alert("대상을 선택하세요");
			return;
		}
	    var contactYn = $("#contactYn").val();
	    console.log(contactYn);
	    var courseCd = $("#courseCd").val();
	    
	    var reqUrl = "/la/apply/updateApplyContactYn";
		
		$.ajax({
			url:reqUrl,
			type:"post",
			data:{ contactYn:contactYn, applyCds:applyArr, courseCd:courseCd },
			dataType:"json",
			success:function(data){
				var result = data.msg;
				if(result == "success"){
					alert("수정되었습니다.");
					fn_search('1');
				}else{
					alert("작업 진행중 오류가 발행하였습니다.");
				}
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		});
	}

	/* 참석일저장 */
	function fn_daystartupdate() {

		var applyArr = [];
		var check=true;
		$("input[name='applyCdArr']:checked").each(function() {
			check=false;
			applyArr.push($(this).val());
			console.log($(this).val());
		});
		if(check){
			alert("대상을 선택하세요");
			return;
		}
		 
		var reqUrl = "/la/apply/updateDayStart";
	 
		$.ajax({
			url:reqUrl,
			type:"post",
			data:{ applyCds:applyArr,dayStart:$("#searchStartDay").val(),courseCd:'${applyVO.courseCd}' },
			dataType:"json",
			success:function(data){
				var result = data.msg;
				if(result == "success"){
					alert("저장되었습니다.");
					fn_search('1');
				}else{
					alert("작업 진행중 오류가 발행하였습니다.");
				}
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		});
	 
	}
	/* 종료일저장 */
	function fn_dayendupdate() {
		
		var applyArr = [];
		var check=true;
		$("input[name='applyCdArr']:checked").each(function() {
			check=false;
			applyArr.push($(this).val());
			console.log($(this).val());
		});
		if(check){
			alert("대상을 선택하세요");
			return;
		}
		 
		var reqUrl = "/la/apply/updateDayStart";
	 
		$.ajax({
			url:reqUrl,
			type:"post",
			data:{ applyCds:applyArr,dayEnd:$("#searchEndDay").val(),courseCd:'${applyVO.courseCd}' },
			dataType:"json",
			success:function(data){
				var result = data.msg;
				if(result == "success"){
					alert("저장되었습니다.");
					fn_search('1');
				}else{
					alert("작업 진행중 오류가 발행하였습니다.");
				}
			},
			error:function(e){
				console.log("ERROR!!!!!!!!!!!");
			}
		});
	}
	
	/* 메일보내기 */
	function fn_mailSend(){
		 		
		var check=true;
		var rowid = "";
		$("input[name='applyCdArr']:checked").each(function() {
			check=false;
			rowid += $(this).val()+",";
		});
		
		if (check) {
			alert("선택한 학습자가 없습니다.");
			return false;
		} else {
			popOpenWindow( "", "sendMail", 540, 460, 100, 100, ',scrollbars=yes' );
			//alert(checkedVals);
			$("#applyCd").val( rowid );
			
			var reqUrl = CONTEXT_ROOT + "/la/popup/goPopupApplyUserMailSendList.do";
			
			$("#frmMailPop").attr("target","sendMail");
			$("#frmMailPop").attr("action", reqUrl);
			$("#frmMailPop").submit();
		}
	}
	function goPopup(applyCd){
		popOpenWindow( "", "applyUser", 840, 860, 100, 100, ',scrollbars=yes' );

		$("#applyCd").val( applyCd );
		
		var reqUrl = CONTEXT_ROOT + "/la/apply/goPopupApplyUser.do";
		
		$("#frmMailPop").attr("target","applyUser");
		$("#frmMailPop").attr("action", reqUrl);
		$("#frmMailPop").submit();
	}
 

//-->
</script>
<form id="frmMailPop" name="frmMailPop" method="post">
	<input type="hidden" name="applyCd" id="applyCd" />
	<input type="hidden" name="sendSuccess" id ="sendSuccess" value ="N"/>
	<input type="hidden" name="sendMemIdGubunFlag" id ="sendMemIdGubunFlag" value ="multi"/>
</form>

<form name="frmApply" id="frmApply"  target="_self" method="post" >
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex}"/>
	<input type="hidden" name="courseCd" id="courseCd" value="${applyVO.courseCd}" />
  	<ul class="search-list-1" style="margin-top:7px;">
		<li>
			<span style="width: 15%;"> 접수상태</span>
			<select name="statusCd" onchange="goSearch(1)" class="selectype">
				${codeSelect}
			</select>
		</li>
		<li>
			<span style="width: 15%;">검색</span>
			<select name="searchType" class="selectype">
				<option value="">--검색조건--</option>
				<option value="USERID" <c:if test="${'USERID' == applyVO.searchType}"> selected </c:if>>사용자ID</option>
				<option value="NAT_NAME_KR" <c:if test="${'NAT_NAME_KR' == applyVO.searchType}"> selected </c:if>>국가명(한글)</option>
				<option value="NATION" <c:if test="${'NATION' == applyVO.searchType}"> selected </c:if>>국가명(영어)</option>
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" value="${applyVO.searchKeyword }" class="typeTxt" style="width: 400px;" />
		</li>
	</ul>

       	<div class="search-btn-area"><a href="#" onclick="javascript:fn_search(1);">조회</a></div>
        	<ul class="board-info">
				<li class="info-area"><span>전체 : </span> <c:out value="${totalCount}" /> 건</li>
				<li class="btn-area">
					<select id="statusModCd" name="statusModCd" class="selectype">
						${codeModSel}
					</select>
					<a href="#" onclick="fn_update_status()" >선택 수정</a>
					<select id="contactYn" name="contactYn" class="selectype">
						<option value="">연락여부</option>
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
					<a href="#" onclick="fn_update_apply_contactYn()">선택 수정</a>
					
					<!--a href="#" onclick="javascript:fn_del();">삭제</a -->
					<a href="#" onclick="javascript:fn_excel();">엑셀다운</a>
					<a href="#" onclick="javascript:fn_mailSend();">E-MAIL</a>
					<a href="#" onclick="javascript:fn_goList();">목록</a>
					<select name="pageSize" id="pageSize" title="목록 갯수 설정하기"  onchange="javascript:fn_search('1');" >
						<option value="30" <c:if test="${pageSize=='30' }" > selected</c:if> >30 개</option>
						<option value="50" <c:if test="${pageSize=='50' }" > selected</c:if> >50 개</option>
						<option value="100" <c:if test="${pageSize=='100' }" > selected</c:if> >100 개</option>
					</select>
				</li>
			</ul>

			<input type="hidden" name="excelCourseCd2" id="excelCourseCd2" value="${courseCd}" />
			<input type="hidden" name="applyCdValues2" id="applyCdValues2" />
			<input type="hidden" name="SELECT" value="DAY_END" />
			<input type="hidden" name="searchType2" id="searchType2" value="${searchType}" />
			<input type="hidden" name="searchKeyword2" id="searchKeyword2" value="${searchKeyword}" />

	<!--         <input type="hidden" name="SELECT" value="PASSPORT_FILE_NAME" /> -->
	<!-- 20150106 추가 -->
	<div class="step_chk">
		<dl>
			<dt><input type="checkbox" id="step2"/><label for="step2"> STEP 2. Basic Information</label></dt>
			<dd>
				<span><input type="checkbox" name="SELECT" class="check1" id="CourseYear" value="DAY_START"/><label for="CourseYear"> Course Year</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Duration" value="DAY_START START_S"/><label for="Duration"> Duration</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Title" value="TITLE"/><label for="Title"> Course Title</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Photo" value="PHOTO_FILE_NAME"/><label for="Photo"> Photo</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Country" value="NAT_NAME"/><label for="Country"> Country</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="FirstName" value="FIRST_NAME" /><label for="FirstName"> First Name</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="LastName" value="LAST_NAME"/><label for="LastName"> Last Name</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="BusinessPhone" value="PHONE"/><label for="BusinessPhone"> Business Phone</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="MobilePhone" value="MOBILE"/><label for="MobilePhone"> Mobile Phone</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="BusinessEmail" value="BUSINESS_EMAIL"/><label for="BusinessEmail"> Business email</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="PrivateEmail" value="PRIVATE_EMAIL"/><label for="PrivateEmail"> Private email</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Organization" value="ORGANIZATION_NAME"/><label for="Organization"> Organization</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="OrganizationType" value="ORGANIZATION_TYPE"/><label for="OrganizationType"> OrganizationType</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="OrganizationDetailType" value="ORGANIZATION_DETAIL_TYPE"/><label for="OrganizationDetailType"> OrganizationDetailType</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="OrganizationEtcType" value="ORGANIZATION_ETC_TYPE"/><label for="OrganizationEtcType"> OrganizationEtcType</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Department" value="DEPARTMENT"/><label for="Department"> Department</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Position" value="POSITION"/><label for="Position"> Position</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Gender" value="GENDER"/><label for="Gender"> Gender</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Disability" value="DISABILITY"/><label for="Disability"> Disability</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Birth" value="BIRTHDATE"/><label for="Birth"> Date of Birth</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Website" value="WEBSITE"/><label for="Website"> Organization Website</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Passport" value="PASSPORT_FILE_NAME"/><label for="Passport"> Passport copy</label></span>
				<span><input type="checkbox" name="SELECT" class="check1" id="Businesscard" value="BUSINESSCARD_FILE_NAME"/><label for="Businesscard"> Business Card copy</label></span>
			</dd>
		</dl>

		<dl>
			<dt><input type="checkbox" id="step3"/><label for="step3">STEP 3. Reference</label></dt>
			<dd>
				<span><input type="checkbox" name="SELECT" class="check2" id="ReferenceName" value="REFERENCE_NAME"/><label for="ReferenceName"> Name of the reference</label></span>
				<span><input type="checkbox" name="SELECT" class="check2" id="ReferenceNation" value="REFERENCE_NATION_NAME"/><label for="ReferenceNation"> Nationality of the reference</label></span>
				<span><input type="checkbox" name="SELECT" class="check2" id="ReferenceOrganization" value="REFERENCE_ORGANIZATION"/><label for="ReferenceOrganization"> Organization of the reference</label></span>
				<span><input type="checkbox" name="SELECT" class="check2" id="ReferencePosition" value="REFERENCE_POSITION"/><label for="ReferencePosition"> Position of the reference</label></span>
				<span><input type="checkbox" name="SELECT" class="check2" id="ReferenceLetter" value="REFERENCE_FILE_NAME"/><label for="ReferenceLetter"> Letter of Reference</label></span>
			</dd>
		</dl>

		<dl class="mar0">
			<dt><input type="checkbox" id="step4"/><label for="step4">STEP 4. Application</label></dt>
			<dd>
				<p><input type="checkbox" name="SELECT" class="check3" id="ictProject" value="ICT_FILE_NAME"/><label for="ictProject"> 1. Please describe ICT projects in your organization or country based on the attached form.</label></p>
				<p><input type="checkbox" name="SELECT" class="check3" id="businessMeeting" value="BUSINESS_MEETING"/><label for="businessMeeting"> 2. Is there any Korean Companies you would like to have a business meeting with?</label></p>
				<p><input type="checkbox" name="SELECT" class="check3" id="cooperation" value="COOPERATION"/><label for="cooperation"> 3. Please describe current cooperation between Korean government/companies and your organization</label></p>
				<p><input type="checkbox" name="SELECT" class="check3" id="JobDuty" value="JOB_DUTY"/><label for="JobDuty"> 4. Please explain your job duty.</label></p>
				<p><input type="checkbox" name="SELECT" class="check3" id="courseRelatedTasks" value="COURSE_RELATED_TASKS"/><label for="courseRelatedTasks"> 5. Please describe any topics, lectures or places of interest you would like to see in the course related to your tasks mentioned above.</label></p>
				<p><input type="checkbox" name="SELECT" class="check3" id="achieve" value="ACHIEVE"/><label for="achieve"> 6. What are you trying to achieve through this program?</label></p>
			</dd>
		</dl>
		<a href="#" class="btn-down" onclick="javascript:fn_select_excel();">선택사항 다운로드</a>
	</div>

	<input type="text" class="date" name="searchStartDay" id="searchStartDay" /><a href="#" class="date-text" onclick="javascript:fn_daystartupdate();">참석일저장</a>
	<input type="text" class="date" name="searchEndDay" id="searchEndDay" /><a href="#" class="date-text" onclick="javascript:fn_dayendupdate();">종료일저장</a>
	
	<table cellspacing="0" cellpadding="0" border="0" summary="" class="list-1">
		<caption>연수 관리</caption>
		<colgroup>
			<col style="width: 3%" />
			<col style="width: 5%" />
			<col style="width: 10%" />
			<col style="width: 14%" />
			<col style="width: 13%" />
			<col style="width: 8%" />
			<col style="width: 9%" />
			<col style="width: 9%" />
			<col style="width: 8%" />
			<col style="width: 8%" />
			<col style="width: 7%" />
			<col style="width: auto%" />
		</colgroup>
		<thead>
		<tr>
			<th scope="col"><input type="checkbox" id="allCheck" /></th>
			<th scope="col">No</th>
			<th scope="col">회원명</th>
			<th scope="col">회원아이디</th>
			<th scope="col">국가명</th>
			<th scope="col">신청상태</th>
			<th scope="col">접수상태</th>
			<th scope="col">접수일자</th>
			<th scope="col">수정일자</th>
			<th scope="col">참석일자</th>
			<th scope="col">종료일자</th>
			<th scope="col">연락여부</th>
			<!--th scope="col">점수</th -->
		</tr>
		</thead>
		<tbody>
		
		<c:choose>
	        <c:when test="${!empty resultList}">
	        	<c:forEach var="resultList" items="${resultList}"  varStatus="status">
					<tr>
						<td><input type="checkbox" name="applyCdArr" value="${resultList.applyCd}" /></td>
						<td class="no">${totalCount-((pageIndex-1) * pageSize + status.count)+1}</td>
						<td>
							<a href="#" onclick="javascript:goPopup('${resultList.applyCd}');">${resultList.firstNameStr}  ${resultList.lastNameStr}</a>
						</td>
						<td>
							<a href="#" onclick="javascript:goPopup('${resultList.applyCd}');">${resultList.userId}</a>
						</td>
						<td class="title">
							<a href="#" onclick="javascript:goPopup('${resultList.applyCd}');">${resultList.natName}</a>
						</td>
						<td>
							<c:if test="${resultList.stepCd eq 'SS'}" >신청완료</c:if>
							<c:if test="${resultList.stepCd ne 'SS'}" >작성중</c:if>
						</td>
						<td><c:if test="${resultList.stepCd eq 'SS'}" >${resultList.statusCdName}</c:if></td>
						<td><c:if test="${resultList.stepCd eq 'SS'}" >${resultList.applyDate}</c:if></td>
						<td><c:if test="${resultList.stepCd eq 'SS'}" >${resultList.modDate}</c:if></td>
						<td><c:if test="${resultList.stepCd eq 'SS'}" >${resultList.dayStart}</c:if></td>
						<td><c:if test="${resultList.stepCd eq 'SS'}" >${resultList.dayEnd}</c:if></td>
						<td><c:if test="${resultList.stepCd eq 'SS'}" >${resultList.contactYn}</c:if></td>
						<!--
							td><c:if test="${resultList.stepCd eq 'SS'}" >
							<a href="#" onclick="fn_evaluation_select('${resultList.applyCd}', '${resultList.evaluationYn}'); return false;">
							<c:if test="${resultList.evaluationYn eq 'Y'}" >
								${resultList.total}
							</c:if>
							<c:if test="${resultList.evaluationYn ne 'Y'}" >
								<img src="/images/wizilearn/adm/inc/kljjs.gif" alt="점수입력"/>
							</c:if>
							</a></c:if>
						</td
						-->
					</tr>
	        	</c:forEach>
	        </c:when>
	        <c:otherwise>
	          	<tr>
					<td colspan="12">신청자 목록이 없습니다.</td>
				</tr>
	        </c:otherwise>
	    </c:choose>
		</tbody>
	</table>
	</form>
	
	<form id="frmDate" name="frmDate" action="/la/apply/updateApplyJoinDate" method="post" target="_self">
		<input type="hidden" name="applyCd" id="dateApplyCd" value="" />
		<input type="hidden" name="courseCd" id="dateCourseCd" value="${applyVO.courseCd}" />
		<input type="hidden" name="dayStart" id="dayStart" value="" />
		<input type="hidden" name="dayEnd" id="dayEnd" value="" />
	</form>
	
	<div class="page-num">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" /> 
	</div>
	
	<div id="window" style="display: none;"></div>
	
