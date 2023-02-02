<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
	var oEditors = [];

	$(document).ready(function() {
		initEditor();
		com.datepickerDateFormat('ntceBgnde');
		com.datepickerDateFormat('ntceEndde');
		//input 숫자만 허용
		$("input:text[numberonly]").on("keyup", function() {
	 	  $(this).val($(this).val().replace(/[^0-9]/g,""));
		});
	});	
	function fn_validation(){
		var popupTitle = $("#popupTitle").val();
		var popupWidthPosi = $("#popupWidthPosi").val();
		var popupHeightPosi = $("#popupHeightPosi").val();
		var popupHeightSize = $("#popupHeightSize").val();
		var popupWidthSize = $("#popupWidthSize").val();
		var ntceBgnde = $("#ntceBgnde").val();
		var ntceEndde = $("#ntceEndde").val();
		
		if(popupTitle == ''){
			alert("제목을 입력해주세요.");
			return;
		}
		if(popupWidthPosi == ''){
			alert("LEFT 항목을 입력해주세요.");
			return;
		}
		if(popupHeightPosi == ''){
			alert("TOP 항목을 입력해주세요.");
			return;
		}
		if(popupHeightSize == ''){
			alert("팝업창 높이를 입력해주세요.");
			return;
		}
		if(popupWidthSize == ''){
			alert("팝업창 폭을 입력해주세요.");
			return;
		}
		if(ntceBgnde == ''){
			alert("게시 시작일 입력해주세요.");
			return;
		}
		if(ntceEndde == ''){
			alert("게시 종료일 입력해주세요.");
			return;
		}
		fn_save();
	}
	
	function fn_save(){
		var reqUrl = "/la/popup/updatePopup";
		var data =oEditors.getById["popupContent"].getIR();
		var text = data.replace(/[<][^>]*[>]/gi, "");
		if(text=="" && data.indexOf("img") <= 0){
			alert("내용은 필수 입력사항 입니다.");
			oEditors.getById["nttCn"].exec("FOCUS"); 
			return false;
		}
		$("#popupContent").val(data);
		
		$("#frmComPopup").attr("action", reqUrl);
		$("#frmComPopup").attr("target","_self");
		$("#frmComPopup").submit();
	}

	/* 화면이 로드된후 에디터 기본옵션 설정 초기화 */ 
	function initEditor() {
		//Smart Editor
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "popupContent",
			sSkinURI: "/smarteditor/SmartEditor2Skin.html",	
			htParams : {
				bUseToolbar : true,
				bUseVerticalResizer : true,
				bUseModeChanger : true,
				fOnBeforeUnload : function(){
				}
			}, 
			fOnAppLoad : function(){
				//oEditors.getById["textAreaContent"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
			fCreator: "createSEditor2"
		});
	} 
	/* 리스트 조회 */
	function fn_search(){		 
		var reqUrl = "/la/popup/listPopup";
		$("#frmComPopup").attr("action", reqUrl);
		$("#frmComPopup").attr("target","_self");
		$("#frmComPopup").submit();
	}
	
</script>
<form id="frmComPopup" name="frmComPopup" method="post" enctype="multipart/form-data" >
	<input type="hidden" id="menuId" name="menuId" value="<c:out value='${menuId}'/>">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" />
	<input type="hidden" id="popupId" name="popupId" value="${result.popupId }"/>
	<input type="hidden" id="deleteYn" name="deleteYn" value="N"/>
	
	<div class="title-name-1">팝업 수정</div>
	<p style="display:inline-block; text-align:left; margin-top:10px;"><font color="red">*</font> 는 필수입력사항입니다.</p>
	<table border="0" cellpadding="0" cellspacing="0" class="view-2">
		<tbody>
			<tr>
				<th><font color="red">*</font>제목</th>
				<td><input type="text" name="popupTitle" id="popupTitle" value="${result.popupTitle}" style="width:100%;"/></td>
			</tr>
			<tr>
				<th width="100px"><font color="red">*</font>게시 기간</th>
				<td>
					<input type="text" name="ntceBgnde" id="ntceBgnde"  value="${result.ntceBgnde}" style="width:80px;" /> ~
					<input type="text" name="ntceEndde" id="ntceEndde"  value="${result.ntceEndde}" style="width:80px;" />
				</td>
			</tr>
			<tr>
				<th><font color="red">*</font>공개여부</th>
				<td>
					<input type="radio" name="useYn" value="Y" <c:if test="${result.useYn eq 'Y' }">checked</c:if>/>공개
					<input type="radio" name="useYn" value="N" <c:if test="${result.useYn eq 'N' }">checked</c:if>/>비공개
				</td>
			</tr>
			<tr>
				<th><font color="red">*</font>그만보기 여부</th>
				<td>
					<input type="radio" name="stopviewYn" value="Y" <c:if test="${result.stopviewYn eq 'Y' }">checked</c:if>/>사용
					<input type="radio" name="stopviewYn" value="N" <c:if test="${result.stopviewYn eq 'N' }">checked</c:if>/>미사용
				</td>
			</tr>
			<tr> 
				<th><font color="red">*</font>팝업 위치</th>
				<td>
					LEFT : <input type="text" id="popupWidthPosi" name="popupWidthPosi" value="${result.popupWidthPosi}" numberOnly=""/>px,   TOP : <input type="text" id="popupHeightPosi" name="popupHeightPosi" value="${result.popupHeightPosi}" numberOnly=""/>px
				</td>
			</tr>
			<tr>
				<th><font color="red">*</font>팝업 사이즈</th>
				<td>
					폭 : <input type="text" id="popupWidthSize" name="popupWidthSize" value="${result.popupWidthSize}" numberOnly=""/>px,   높이 : <input type="text" id="popupHeightSize" name="popupHeightSize" value="${result.popupHeightSize}" numberOnly=""/>px
				</td>
			</tr>
			<tr>
				<th><font color="red">*</font>내용</th>
				<td ><textarea name="popupContent" id="popupContent" style="width:85%;"><c:out value="${result.popupContent}" escapeXml = "false"/></textarea></td>
			</tr>
		</tbody>
	</table>
</form>

<div class="page-btn">
	<a href="#!" onclick="fn_validation();">저장</a>
	<a href="#!" onclick="fn_search();">목록</a>
</div>