<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript" src="/cheditor/cheditor.js"></script>
<script type="text/javascript">
<!-- 

	$(document).ready(function() {

		com.datepicker('dayStart');
		com.datepicker('dayEnd');
		com.datepicker('applyStart');
		com.datepicker('applyEnd');
	});
 

	/* 리스트 조회 */
	function fn_search( pageNo ){
		$("#pageIndex").val( pageNo );

		var reqUrl = CONTEXT_ROOT + "/la/course/courseList";
		$("#frmCourse").attr("action", reqUrl);
		$("#frmCourse").submit();
	}
	 

	 function fn_insert(){
			var regExp = /^(19|20)\d{2}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[0-1])$/;//날짜 정규식 체크

			//폼체크
			if( $("#dayStart").val().length != 10 || !regExp.test($("#dayStart").val()) ){
				$("#dayStart").focus();
				return false;
			}
			if( $("#dayEnd").val().length != 10 || !regExp.test($("#dayEnd").val())){
				$("#dayEnd").focus();
				return false;
			}
			if( $("#dayStart").val().replace('-','') > $("#dayEnd").val().replace('-','') ){
				alert('종료일자는 시작일자보다 이전일 수 없습니다.');
				$("#dayEnd").focus();
				return false;
			}
			if( $("#applyStart").val().length != 10 || !regExp.test($("#applyStart").val()) ){
				$("#applyStart").focus();
				return false;
			}
			if( $("#applyEnd").val().length != 10 || !regExp.test($("#applyEnd").val())){
				$("#applyEnd").focus();
				return false;
			}
			if( $("#applyStart").val().replace('-','') > $("#applyEnd").val().replace('-','') ){
				alert('종료일자는 시작일자보다 이전일 수 없습니다.');
				$("#applyEnd").focus();
				return false;
			}
			if( $("#coursetitle").val()==''){
				alert("과정명을 입력해주세요");
				$("#coursetitle").focus();
				return false;
			}
			if( $("#curriculum").val()==''){
				alert("간략설명을 입력해주세요");
				$("#curriculum").focus();
				return false;
			}
			if( $("#participant").val() == '' || $("#participant").val() == 0 ){
				alert("모집인원을 입력해주세요");
				$("#participant").focus();
				return false;
			}
			if( $("#orgCd").val() == ''){
				alert("수행기관을 선택해주세요");
				$("#orgCd").focus();
				return false;
			}
			if( myeditor1.outputBodyHTML() == ''){
				alert($("#courseText").attr('title')+"을(를) 입력해주세요");
				$("#courseText").focus();
				return false;
			}
			/*
			if( myeditor2.outputBodyHTML() == ''){
				alert($("#scheduleText").attr('title')+"을(를) 입력해주세요");
				$("#scheduleText").focus();
				return false;
			}
			if( myeditor3.outputBodyHTML() == ''){
				alert($("#lecturerText").attr('title')+"을(를) 입력해주세요");
				$("#lecturerText").focus();
				return false;
			}
			*/
			$("#courseText").val(myeditor1.outputBodyHTML());
			$("#scheduleText").val(myeditor2.outputBodyHTML());
			$("#lecturerText").val(myeditor3.outputBodyHTML());
			
			
			var reqUrl = CONTEXT_ROOT + "/la/course/courseInsert";
			$("#frmCourse").attr("action", reqUrl);
			$("#frmCourse").submit();		 
	 }

//-->
</script> 
<form name="frmCourse" id="frmCourse"    method="post"  enctype="multipart/form-data" > 
            	<input type="hidden" id="menuId" name="menuId" value="${courseVO.menuId }" />
				<table cellspacing="0" cellpadding="0" border="0"  class="view-1" summary="공개여부,등록일,조회수,상단고정,작성자 표입니다.">
					<caption>연수 관리</caption>
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th class="view-th">과정상태 (*)</th>
							<td class="view-td" colspan="2">
								<input type="radio" name="statusCd" value="CT01" checked="checked"/>대기중
								<input type="radio" name="statusCd" value="CT02" />접수중
								<input type="radio" name="statusCd" value="CT03" />교육완료
							</td>
							<td style="color:#909090;"><span> ( * : 필수항목 ) </span></td>
						</tr>
						<tr>
							<th class="view-th">메인 등록 (*)</th>
							<td class="view-td" colspan="3">
								<input type="radio" name="mainYn" value="Y"  checked="checked" />사용
								<input type="radio" name="mainYn" value="N" />사용안함
							</td>
						</tr>
						<tr>
							<th class="view-th">과정명 (*)</th>
							<td class="view-td" colspan="3">
								<input type="text" name="title" id="coursetitle" maxlength="200" style="width:620px;"/>
							</td>
						</tr>
						<tr>
							<th class="view-th">간략설명 (*)</th>
							<td class="view-td" colspan="3">
								<textarea rows="8" cols="75" name="curriculum" id="curriculum" maxlength="4000" onkeyup="return ismaxlength(this)" style="margin-top: 10px;margin-bottom: 10px;" ></textarea><br/>
							</td>
						</tr>
						<tr>
							<th class="view-th">교육시작일자 (*)</th>
							<td class="view-td" >
								<input type="text" name="dayStart" id="dayStart"  title="교육시작일자" maxlength="10"/>
							</td>
							<th class="view-th">교육종료일자 (*)</th>
							<td class="view-td" >
								<input type="text" name="dayEnd" id="dayEnd"  title="교육종료일자" maxlength="10"/>
							</td>
						</tr>
						<tr>
							<th class="view-th">접수시작일자 (*)</th>
							<td class="view-td" >
								<input type="text" name="applyStart" id="applyStart" title="접수시작일자" maxlength="10"/>
							</td>
							<th class="view-th">접수종료일자 (*)</th>
							<td class="view-td" >
								<input type="text" name="applyEnd" id="applyEnd" title="접수종료일자" maxlength="10"/>
							</td>
						</tr>
						<tr>
							<th class="view-th">모집인원 (*)</th>
							<td class="view-td" >
								<input type="text" name="participant" id="participant" value="0" maxlength="2"/>
							</td>
							<th class="view-th">수행기관 (*)</th>
							<td class="view-td" >
								<select name="orgCd" id="orgCd" style="width:160px;">
									${orgBox}
								</select>
							</td>
						</tr>
						<tr>
							<th class="view-th">STEP 3 양식 (*)</th>
							<td class="view-td" >
								<div style="padding-top: 5px; padding-bottom: 5px;">
									<input type="radio" name="step3_file01_use_yn" value="Y" />노출
									<input type="radio" name="step3_file01_use_yn" value="N" checked="checked" />비노출
								</div>
								<!--div style="padding-bottom: 5px;">
									<input type="file" name="step3_file01" id="step3_file01" onchange="" title="file upload"/>
								</div-->
								
							</td>
							<th class="view-th">STEP 4 양식 (*)</th>
							<td class="view-td" >
								<div style="padding-top: 5px; padding-bottom: 5px;">
									<input type="radio" name="step4_file01_use_yn" value="Y" />노출
									<input type="radio" name="step4_file01_use_yn" value="N" checked="checked"/>비노출
								</div>
								<!-- div style="padding-bottom: 5px;">
									<input type="file" name="step4_file01" id="step4_file01" onchange="" title="file upload"/>	
								</div-->
							</td>
						</tr>
						<tr>
							<th class="view-th" colspan="4">과정소개 (*)</th>
						</tr>
						<tr>
							<td class="view-td"  colspan="4">
								<textarea name="courseText" id="courseText" cols="50" rows="10" title="과정소개" ></textarea>
								<script type="text/javascript">
								var myeditor1 = new cheditor();              // 에디터 개체를 생성합니다.
								myeditor1.config.editorHeight = '200px';     // 에디터 세로폭입니다.
								myeditor1.config.editorWidth = '100%';        // 에디터 가로폭입니다.
								myeditor1.inputForm = 'courseText';             // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
								myeditor1.run();                             // 에디터를 실행합니다.
								</script>
							</td>
						</tr>
						<tr>
							<th class="view-th" colspan="4">과정스케쥴</th>
						</tr>
						<tr>
							<td class="view-td"  colspan="4">
								<textarea name="scheduleText" id="scheduleText" cols="50" rows="10" title="과정스케쥴" ></textarea>
								<script type="text/javascript">
								var myeditor2 = new cheditor();              // 에디터 개체를 생성합니다.
								myeditor2.config.editorHeight = '200px';     // 에디터 세로폭입니다.
								myeditor2.config.editorWidth = '100%';        // 에디터 가로폭입니다.
								myeditor2.inputForm = 'scheduleText';             // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
								myeditor2.run();                             // 에디터를 실행합니다.
								</script>
							</td>
						</tr>
						<tr>
							<th class="view-th" colspan="4">주요일정 및 강사 </th>
						</tr>
						<tr>
							<td class="view-td"  colspan="4">
								<textarea name="lecturerText" id="lecturerText" cols="50" rows="10" title="주요일정 및 강사" ></textarea>
								<script type="text/javascript">
								var myeditor3 = new cheditor();              // 에디터 개체를 생성합니다.
								myeditor3.config.editorHeight = '200px';     // 에디터 세로폭입니다.
								myeditor3.config.editorWidth = '100%';        // 에디터 가로폭입니다.
								myeditor3.inputForm = 'lecturerText';             // textarea의 id 이름입니다. 주의: name 속성 이름이 아닙니다.
								myeditor3.run();                             // 에디터를 실행합니다.
								//window.scrollTo(0,0);
								</script>
							</td>
						</tr>
						
					</tbody>
				</table>  
				
</form>				

			<div class="page-btn">
				<a href="#insert" onclick="javascript:fn_insert();">등록</a>				
			</div>
		 	