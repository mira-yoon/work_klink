<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript">
	$(function() {
		fn_couse_select($("#dayStart").val());
		//$(".lectureFrm_").ajaxForm(callback);
		//$(".lectureFrm_").submit(function(){return false;});
	});
	
	function onlyNum() {
		var x = event.which || event.keyCode;
		if(x < 48 || 57 < x) {
			if(event.preventDefault) {
				event.preventDefault();
			} else {
				event.returnValue = false;
			}
		}
	}
	
	function fn_couse_select(year) {
		if(year == '') {
			alert('년도를 선택해 주세요.');
			return;
		}
		$.ajax({
			dataType: "json",
			url: '/la/teacher/listYearCourse',
			data: $('#frmPrgm').serialize(),
			error: function (jqXHR, textStatus, errorThrown) {
				alert(textStatus + " / " +errorThrown);
			},
			success: function(data){
				var json = data;
				if(json.length > 0) {
					$('#searchCourseResult').find('option').remove();
					for(var i =0; i < json.length; i++) {
						var _str = "<option value=\"";
						_str += json[i].courseCd + "\">";
						_str += json[i].title;
						_str += "</option>";
						$('#searchCourseResult').append(_str);
					}
				}
			}
		});
	}
	
	function fn_day_select(elm) {
		$(elm).siblings().removeClass('on');
		$(elm).addClass('on');
		var f= $(elm).closest("form");
		f[0].teachDay.value = $(elm).text();
	}
	
	function fn_evaluation_add(mode) {
		console.log(mode);
		var isAdd = true;
		var f = document.frmEval;
		f.mode.value = mode;
		if(mode === 'first') {
			var _option_v = $("#searchCourseResult option:selected").val();
			if(_option_v == '') {
				alert('프로그램을 선택해 주세요.');
				return false;
			}
			f.courseCd.value = _option_v;
			$('#programs').find('table').each(function() {
				var idName = $(this).attr('id');
				if(idName !== 'undefined') {
					if(_option_v == idName) {
						alert('이미 등록된 연수정보가 있습니다.');
						isAdd = false;
						return false;
					}
				}
			});
		} else {
			isAdd = true;
			f.courseCd.value = mode;
		}
		
		console.log(isAdd);
		if(isAdd) {
			var reqUrl = "/la/teacher/courseView";
			//var params = $("#frmDate").serialize();
			$.ajax({
				url:reqUrl,
				type:"post",
				data:{"courseCd" : f.courseCd.value},
				dataType:"json",
				success:function(data){
					var arr = data.dayList;
					var html = "";
						html += "<form name='frmReg'  method='post' enctype='multipart/form-data' class=" + data.courseCd + ">                               ";
						html += "<input type='hidden' name='courseCd' value='" + data.courseCd + "'/>                                                        ";
						html += "<input type='hidden' name='courseYear' value='" + data.year + "'/>                                                          ";
						html += "<input type='hidden' name='startTime' value=''/>                                                                            ";
						html += "<input type='hidden' name='endTime' value=''/>                                                                              ";
						html += "<input type='hidden' name='teachDay' value=''/>                                                                             ";
						html += "<input type='hidden' name='hisSeq' value=''/>                                                                               ";
						html += "<table border='0' cellpadding='0' cellspacing='0' class='view-2 " + data.courseCd + "'>                         ";
						html += "	<caption>프로그램 관리</caption>                                                                                              ";
						html += "	<colgroup>                                                                                                               ";
						html += "		<col style='width:15%'>                                                                                              ";
						html += "		<col style='width:12%'>                                                                                              ";
						html += "		<col style='width:30%'>                                                                                              ";
						html += "		<col style='width:12%'>                                                                                              ";
						html += "		<col style='width:31%'>                                                                                              ";
						html += "	</colgroup>                                                                                                              ";
						html += "	<tbody>                                                                                                                  ";
						
					if(mode === 'first') {
						html += "	<tr>                                                                                                                     ";
						html += "		<th>프로그램 명</th>                                                                                                     ";
						html += "		<td colspan='3' style='border-right:0'>" + data.title + "</td>                                                       ";
						html += "		<td style='border-left:0;text-align:right;padding-right:5px'>                                                        ";
						html += "			<span><a href='#none' onclick='fn_evaluation_add(\"" + data.courseCd + "\");' title='강의추가'>강의추가</a></span>    ";
						html += "		</td>                                                                                                                ";
						html += "	</tr>                                                                                                                    ";
					}
					
						html += "	<tr>                                                                                                                     ";
						html += "		<th rowspan='2'>강의 정보</th>                                                                                          ";
						html += "		<th>일자</th>                                                                                                          ";
						
						html += "		<td>                                                                                                                 ";
					arr.forEach(function(currentValue, index, array){
						html += "        <span onclick='fn_day_select(this);'>" + currentValue + "</span>                                                                                   ";	
					});
						html += "		</td>                                                                                                                ";
						html += "		<th>시간</th>                                                                                                          ";
						html += "		<td>                                                                                                                 ";
						html += "			<select name='timeGubun'>                                                                                        ";
						html += "				<option>AM</option>                                                                                          ";
						html += "				<option>PM</option>                                                                                          ";
						html += "			</select>                                                                                                        ";
						html += "			<select name='startTime1'>                                                                                       ";
						html += "				<c:forEach var='hour' begin='1' end='12'>                                                                    ";
						html += "					<fmt:formatNumber var='hh1' value='${hour}' pattern='00'/>                                               ";
						html += "					<option value='${hh1}'>${hh1}</option>                                                                   ";
						html += "				</c:forEach>                                                                                                 ";
						html += "			</select> :                                                                                                      ";
						html += "			<input type='text' name='startTime2' style='width:27px' maxlength='2' onkeypress='onlyNum();'> ~                 ";
						html += "			<select name='endTime1'>                                                                                         ";
						html += "				<c:forEach var='hour' begin='1' end='12'>                                                                    ";
						html += "					<fmt:formatNumber var='hh1' value='${hour}' pattern='00'/>                                               ";
						html += "					<option value='${hh1}'>${hh1}</option>                                                                   ";
						html += "				</c:forEach>                                                                                                 ";
						html += "			</select> :                                                                                                      ";
						html += "			<input type='text' name='endTime2' style='width:27px' maxlength='2' onkeypress='onlyNum();'>                     ";
						html += "		</td>                                                                                                                ";
						html += "	</tr>                                                                                                                    ";
						html += "	<tr>                                                                                                                     ";
						html += "		<th>첨부파일</th>                                                                                                       ";
						html += "		<td colspan='3'>                                                                                                     ";
						html += "			<input type='file' name='file'>                                                                                  ";
						html += "		</td>                                                                                                                ";
						html += "	</tr>                                                                                                                    ";
						html += "	<tr>                                                                                                                     ";
						html += "		<th>강의 평가</th>                                                                                                      ";
						html += "		<td colspan='4'>                                                                                                     ";
						html += "			<p><input type='text' name='rating' style='width:30%'></p>                                                                                                     ";
						html += "			<p><input type='text' name='lectureComment' style='width:80%'></p>                                               ";
						html += "		</td>                                                                                                                ";
						html += "	</tr>                                                                                                                    ";
						html += "	</tbody>                                                                                                                 ";
						html += "</table>                                                                                                                    ";
						html += "</form>                                                                                                                     ";
					
					if(mode == 'first') {
						$("#programs").append(html);
					} else {
						if($('form.' + mode).length > 0) {  // 입력이나 수정일시
							$('form.' + mode).last().after(html);
						} else if($('table#' + mode).length > 0) {
							$('table#' + mode).last().after(html);
						}
					}
					
					
					
					
				},
				error:function(e){
					console.log("ERROR!!!!!!!!!!!");
				}
			});
		}
		
		
		

		/* if(isAdd) {
			$.ajax({
				contentType: "application/x-www-form-urlencoded",
				dataType: "html",
				url: '/pages/admin/program/teacherHistoryEvalutionAjaxFrm.jsp',
				data: $(f).serialize(),
				error: function (jqXHR, textStatus, errorThrown) {
					alert(textStatus + " / " +errorThrown);
				},
				success: function(html){
					if(mode == 'first') {
						$("#programs").append(html);
					} else {
						if($('form.' + mode).length > 0) {  // 입력이나 수정일시
							$('form.' + mode).last().after(html);
						} else if($('table.' + mode).length > 0) {
							$('table.' + mode).last().after(html);
						}
					}
				}
			});
		} */
	}
	
	/**
	 * 강사 강의정보 등록
	 */
	function fn_evalution_reg() {
		var $_regForms = $('form[name=frmReg]')
				, isValidation = false;
		if($_regForms.length == 0) {
			alert('입력된 강의정보가 없습니다.');
			return;
		}
		$_regForms.each(function(idx) {
			var f = $(this);
			if(!validationEvalutionFrm(f[0])) {
                isValidation = false;
				return false;
			} else {
				isValidation = true;
				return true;
			}
		});
		if(isValidation) {
			
			var reqUrl = "/la/teacher/insertTeacherEvaluation";
			
			$_regForms.each(function (index) {				
				var f = $(this)[0];
				f.hisSeq.value = $('#hisSeq').val();
				f.startTime.value = f.startTime1.value + ':' + f.startTime2.value;
				f.endTime.value = f.endTime1.value + ':' + f.endTime2.value;
				var formData = new FormData(f);
				
				$.ajax({
					url:reqUrl,
					type:"post",
					processData:false,
					contentType:false,
					data:formData,
					success:function(data){
						if(data.result) {
							alert(data.msg);
							location.reload();
						} else {
							alert(data.msg);
						}
						
					}
				});
			});
		}
	}
	
	/**
	 * 강사 강의정보 삭제
	 * @param seq
	 */
	function fn_evaluation_del(seq) {
		if(confirm('선택하신 강의를\n삭제하시겠습니까?')) {
			console.log(seq);
			var f = document.frmProc;
			f.seq.value = seq;
			
			var reqUrl = "/la/teacher/deleteTeacherEvaluation";
			
			$.ajax({
				dataType: "json",
				url:reqUrl,
				type:"post",
				data:$('#frmProc').serialize(),
				success:function(data){
					if(data.result) {
						alert(data.msg);
						location.reload();
					} else {
						alert(data.msg);
					}
					
				}
			});
		}
	}
	
	function fn_evaluation_delAll(hSeq, cd) {
		if(confirm('선택하신 연수를\n삭제하시겠습니까?')) {
			var f = document.frmProc;
			//numberformat 처리 쿼리에서 사용안함
			f.seq.value = 0;
			f.hisSeq.value = hSeq;
			f.courseCd.value = cd;
			
			var reqUrl = "/la/teacher/deleteTeacherProgram";
			
			$.ajax({
				dataType: "json",
				url:reqUrl,
				type:"post",
				data:$('#frmProc').serialize(),
				success:function(data){
					if(data.result) {
						alert(data.msg);
						location.reload();
					} else {
						alert(data.msg);
					}
					
				}
			});
		}
	}
	
	function validationEvalutionFrm(frm) {
		/* if(frm.teachDay.value == '') {
			alert('강의일자를 선택해 주세요.');
			frm.teachDay.focus();
			return false;
		}
		if(frm.startTime2.value == '') {
			alert('강의시간을 입력해 주세요.');
			return false;
		}
		if(frm.endTime2.value == '') {
			alert('강의시간을 입력해 주세요.');
			return false;
		}
		if(frm.rating.value == '') {
			alert('강의 평가점수를 선택해 주세요.');
			return false;
		} */
		return true;
	}
	
	function fn_update_view(courseCd, exec) {
		var f = document.frmProc;
		f.exec.value = exec;
		f.selectCourseCd.value = courseCd;
		f.submit();
	}
	
	/**
	 * 강사 강의정보 수정
	 */
	function fn_evalution_upt(courseCd) {

		var $_regForms = $('form[name=' + 'frmModify_' + courseCd +']')
	     , isValidation = false;
		if($_regForms.length == 0) {
			alert('입력된 강의정보가 없습니다.');
			return;
		}
		$_regForms.each(function() {
			var f = $(this);
			if(!validationEvalutionFrm(f[0])) {
				isValidation = false;
                return false;
			} else {
				isValidation = true;
				return true;
			}
		});
		if(isValidation) {
			var reqUrl = "/la/teacher/updateTeacherEvaluation";
			
			$_regForms.each(function (index) {				
				var f = $(this)[0];
				f.hisSeq.value = $('#hisSeq').val();
				f.startTime.value = f.startTime1.value + ':' + f.startTime2.value;
				f.endTime.value = f.endTime1.value + ':' + f.endTime2.value;
				var formData = new FormData(f);
				
				$.ajax({
					url:reqUrl,
					type:"post",
					processData:false,
					contentType:false,
					data:formData,
					success:function(data){
						if(data.result) {
							alert(data.msg);
							location.reload();
						} else {
							alert(data.msg);
						}
						
					}
				});
			});
		}
	}


<!--
	$("input:text[numberonly]").on("keyup", function() {
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
		
	$(document).ready(function() { 
		com.datepickerDateFormat('memBirth'); 
	
	});	
	
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
//-->
</script>
<form id="frmTeacher" name="frmTeacher" method="post"  enctype="multipart/form-data">
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>"/> 
	<input type="hidden" id="hisSeq" name="hisSeq" value="<c:out value='${result.hisSeq}'/>"/>
	<input type="hidden" id="deleteYn" name="deleteYn" value="${result.deleteYn }"/>
	<div class="title-name-1">강사 이력</div>
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th>이름</th>
				<td colspan="3">
					<input type="text" id="name" name="name" value="${result.name}"/>
				</td>
			</tr> 
			<tr>
				<th>연락처</th>
				<td>
					<input type="text" id="tel" name="tel" value="${result.tel}"/>
				</td>
				<th>이메일</th>
				<td>
					<input type="text" id="email" name="email" value="${result.email}"/>
				</td>
			</tr>
			<tr>
				<th>연수 수</th>
				<td>
					${result.courseCnt}
				</td>
				<th>강의 수</th>
				<td>
					${result.evaluationCnt}
				</td>
			</tr>
			<tr>
				<th>약력</th>
				<td colspan="3">
					<textarea id="history" name="history">${result.history}</textarea>
				</td>
			</tr> 
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="#!" onclick="fn_save();">수정</a>
</div>

<div class="title-name-1">평가 관리</div>
<div id="programs">
<form id="frmPrgm" name="frmPrgm" method="post">
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<colgroup>
			<col style="width:15%">
			<col style="width:50%">
			<col style="width:35%">
		</colgroup>
		<tbody>
			<tr>
				<th>프로그램 등록</th>
				<td>				
					· 연도
	                <select name="dayStart" id="dayStart" style="width:60px;" onchange="fn_couse_select(this.value);">
	                	${yearSelect}
	                </select>					
                	<select style="width:450px;" id="searchCourseResult"></select>
				</td>
				<td>
					<a href="#none" onclick="fn_evaluation_add('first');" class="btn">선택완료</a>
				</td>
			</tr>
		</tbody>
	</table>
</form>
	
<c:set var="rowNum" value="1" />
<c:forEach var="eval" items="${resultList}" varStatus="status">
<c:choose>
	<c:when test="${'update' ne exec or eval.courseCd ne selectCourseCd}">
		<table border="0" cellpadding="0" cellspacing="0" id="${eval.courseCd}" class="view-2">
			<caption>프로그램 관리</caption>
			<colgroup>
				<col style="width:15%">
				<col style="width:12%">
				<col style="width:30%">
				<col style="width:12%">
				<col style="width:31%">
			</colgroup>
			<tbody>
			<c:if test="${rowNum == 1}">
				<tr>
					<th>프로그램 명</th>
					<td colspan="3" style="border-right:0">${eval.title}</td>
					<td style="border-left:0;text-align:right;padding-right:5px">
						<span><a href="#none" onclick="fn_evaluation_add('${eval.courseCd}');" title="강의추가">강의추가</a></span>
						<span><a href="#none" title="수정" onclick="fn_update_view('${eval.courseCd}', 'update');">수정</a></span>
						<span><a href="#none" onclick="fn_evaluation_delAll('${eval.hisSeq}', '${eval.courseCd}');" title="연수삭제">연수삭제</a></span>
					</td>
				</tr>
			</c:if>
			<tr>
				<th rowspan="2">강의 정보<img src="/pages/admin/images/tbldel.gif" alt="삭제" onclick="fn_evaluation_del('${eval.seq}');"></th>
				<th>일자</th>
				<td>
					<c:forEach var="dayStr" items="${eval.dayList}" varStatus="status">
						<c:choose>
							<c:when test="${dayStr eq eval.teachDay}">
								<span class="on">${dayStr}</span>
							</c:when>
							<c:otherwise>
								<span>${dayStr}</span>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</td>
				<th>시간</th>
				<td>
					<strong>${eval.timeGubun}</strong> ${eval.startTime}~${eval.endTime}
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<span class="flename">${eval.orgFileName}</span>
					<c:if test="${not empty eval.saveFileName and not empty eval.filePath}">
						<span>
							<a href="#" onclick="fn_download('${eval.filePath}', '${eval.saveFileName}', 
								'${eval.orgFileName}'); return false;" title="첨부파일 다운">첨부파일 다운</a>
						</span>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>강의 평가</th>
				<td colspan="4">
					<p><span class="star_rating"><span style="width:${eval.rating}0%"></span></span>
						<span class="star-rating_score">${eval.rating}</span></p>
					<p>${eval.lectureComment}</p>
				</td>
			</tr>
			</tbody>
		</table>
	</c:when>
	<c:otherwise>
		<form name="frmModify_${eval.courseCd}"  method="post" enctype="multipart/form-data" class="${eval.courseCd}">
			<input type="hidden" name="courseCd" value="${eval.courseCd}"/>
			<input type="hidden" name="seq" value="${eval.seq}"/>
			<input type="hidden" name="startTime" value=""/>
			<input type="hidden" name="endTime" value=""/>
			<input type="hidden" name="teachDay" value=""/>
			<input type="hidden" name="hisSeq" value=""/>
		<table border="0" cellpadding="0" cellspacing="0" class="view-2 ${eval.courseCd}">
			<caption>프로그램 관리</caption>
			<colgroup>
				<col style="width:15%">
				<col style="width:12%">
				<col style="width:30%">
				<col style="width:12%">
				<col style="width:31%">
			</colgroup>
			<tbody>
			<c:if test="${rowNum == 1}">
				<tr>
					<th>프로그램 명</th>
					<td colspan="3" style="border-right:0">${eval.title}</td>
					<td style="border-left:0;text-align:right;padding-right:5px">
						<span><a href="#none" onclick="fn_evaluation_add('${eval.courseCd}');" title="강의추가">강의추가</a></span>
						<span><a href="#none" title="수정" onclick="fn_evalution_upt('${eval.courseCd}');">수정완료</a></span>
						<span><a href="#none" onclick="fn_evaluation_delAll('${eval.hisSeq}', '${eval.courseCd}');" title="연수삭제">연수삭제</a></span>
					</td>
				</tr>
			</c:if>
			<tr>
				<th rowspan="2">강의 정보<img src="/pages/admin/images/tbldel.gif" alt="삭제" onclick="fn_evaluation_del('${eval.seq}');"></th>
				<th>일자</th>
				<td>
					<c:forEach var="dayStr" items="${eval.dayList}" varStatus="status">
						<c:choose>
							<c:when test="${dayStr eq eval.teachDay}">
								<span onclick="fn_day_select(this);" class="on">${dayStr}</span>
							</c:when>
							<c:otherwise>
								<span onclick="fn_day_select(this);">${dayStr}</span>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</td>
				<th>시간</th>
				<td>
					<select name="timeGubun">
						<option>AM</option>
						<option>PM</option>
					</select>
					<c:set var="startTime" value="${fn:split(eval.startTime,':')}" />
					<c:set var="endTime" value="${fn:split(eval.endTime,':')}" />
					<select name="startTime1">
						<c:forEach var="hour" begin="1" end="12">
							<fmt:formatNumber var="hh1" value="${hour}" pattern="00"/>
							<option value="${hh1}" <c:if test="${hh1 eq startTime[0]}">selected</c:if> >${hh1}</option>
						</c:forEach>
					</select> :
					<input type="text" name="startTime2" style="width:27px" maxlength="2" onkeypress="onlyNum();" value="${startTime[1]}"> ~
					<select name="endTime1">
						<c:forEach var="hour" begin="1" end="12">
							<fmt:formatNumber var="hh1" value="${hour}" pattern="00"/>
							<option value="${hh1}" <c:if test="${hh1 eq endTime[0]}">selected</c:if> >${hh1}</option>
						</c:forEach>
					</select> :
					<input type="text" name="endTime2" style="width:27px" maxlength="2" onkeypress="onlyNum();" value="${endTime[1]}">
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3" class="pprgrmTime ttleft">
					<input type="file" name="file">
				</td>
			</tr>
			<tr>
				<th>강의 평가</th>
				<td colspan="4">
					<p><input type="text" name="rating" style="width:30%" value="${eval.rating}"></p>
					<p><input type="text" name="lectureComment" style="width:80%" value="${eval.lectureComment }"></p>
				</td>
			</tr>
			</tbody>
		</table>
		</form>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${rowNum < eval.rNo }">
		<c:set var="rowNum" value="${rowNum+1 }" />
	</c:when>
	<c:when test="${rowNum eq eval.rNo}">
		<c:set var="rowNum" value="1" />
	</c:when>
</c:choose>
</c:forEach>
</div>

<div class="page-btn">
	<c:if test="${'update' ne exec}">
		<a href="#none" onclick="fn_evalution_reg(); return false;">등록</a>
	</c:if>
	<a href="#none" onclick="fn_search();">목록</a>
</div>

<form name="frmEval" id="frmEval" method="post">
	<input type="hidden" name="courseCd" />
	<input type="hidden" name="mode" value=""/>
</form>

<form name="frmProc" id="frmProc" method="post">
	<input type="hidden" name="action" />
	<input type="hidden" name="exec" value=""/>
	<input type="hidden" name="seq" value=""/>
	<input type="hidden" name="hisSeq" value="${result.hisSeq}"/>
	<input type="hidden" name="courseCd" value=""/>
	<input type="hidden" name="selectCourseCd" value=""/>
</form>