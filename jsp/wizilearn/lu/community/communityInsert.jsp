<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

	/* 타이틀 */
  $(document).ready(function() {
    $(document).attr("title","Community > Community > Daily List > Register : K-LINK");
  });

	function fn_save() {
		if (confirm("Do you want to register?")) {
			var reqUrl = "/lu/community/insertCommunity";
			$("#frmBbs").attr("action", reqUrl);
			$("#frmBbs").attr("target", "_self");
			$("#frmBbs").submit();
		}
	}

	function fn_cancel() {
		var reqUrl = "/lu/community/communityList";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target", "_self");
		$("#frmBbs").submit();
	}

	function checkFile(param, addFileCntStr) {
		$("#file" + addFileCntStr).val($("#file_atchFileId" + addFileCntStr).val());

		var fileName = $("#file" + addFileCntStr).val();
		var bbsType = $("#bbsType").val();

		var fileExt = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();

		if (fileExt == "exe") {
			alert("This file type cannot be registered.");
			$("#file" + addFileCntStr).val("");
			return false;
		}

		var fileSize = param.files[0].size;

		if (fileSize > 10000000) {
			alert("You can not upload more than 10M size.");
			$("#file" + addFileCntStr).val("");
			return false;
		} else {
			var filesizeNumber = "";
			if (fileSize > 1000000) {
				filesizeNumber = ((fileSize / 1000000).toFixed(2)) + " M";
			} else if (fileSize > 1000) {
				filesizeNumber = ((fileSize / 1000).toFixed(2)) + " KB";
			} else {
				filesizeNumber = fileSize + " B";
			}
			$("#fileSizeName" + addFileCntStr).html(filesizeNumber + " / 10M");
		}
	}

	var addFileCnt = 1;

	function addFile() {
		//if(addFileCnt < 5){
		addFileCnt += 1;
		var htmlText = "";
		htmlText += "<div class=\"input-file-box\">"
		htmlText += "<input class=\"upload-name\" type=\"text\" id=\"file" + addFileCnt + "\" disabled=\"disabled\" title=\"the file name\" aria-label=\"the file name\" />";
		htmlText += "<input type=\"file\" name=\"file_atchFileId\" id=\"file_atchFileId" + addFileCnt + "\" class=\"upload-hidden\" onChange=\"javascript: checkFile(this,'" + addFileCnt + "');\" aria-hidden=\"true\" />";
		htmlText += "<label for=\"file_atchFileId" + addFileCnt + "\">Upload</label>";
		htmlText += "<span id=\"fileSizeName" + addFileCnt + "\" title=\"the file size\" aria-label=\"the file size\">0KB / 10M</span>";
		htmlText += "</div>"

		$("#fileaddhtml").append(htmlText);
		//}else{
		//	alert("You can register up to 5 attachments at a time.");
		//}
	}

	// $label에 focus된 것 처럼 보이게 하기 (for 웹접근성)
	$(document).on('focusin focusout', ".upload-hidden", function (e) {
		var $btnUpload = $(this);
		var $label = $btnUpload.parent().find("label");
		e.type == 'focusin' ? $label.addClass('file-focus') : $label.removeClass('file-focus');
	});

</script>
<div id="write">
	<div class="btn-box">
		<ul>
			<li><a href="#" onclick="javascript:fn_save();" class="btn-blue">Save</a></li>
			<li><a href="#" onclick="javascript:fn_cancel();" class="btn-blue">Cancel</a></li>
		</ul>
	</div>

	<form id="frmBbs" name="frmBbs" method="post" enctype="multipart/form-data">
		<input type="hidden" name="courseCd" id="courseCd" value="${comBbsNoticeVO.courseCd}" />
		<input type="hidden" name="useYn" id="useYn" value="Y" />
		<table>
			<caption class="sr-only">Writing program review</caption>
			<tr>
				<th scope="row">Title</th>
				<td><input type="text" title="Enter the title" name="title" aria-label="Enter the title" placeholder="Enter the title" /></td>
			</tr>

			<tr>
				<td colspan="2">
					<div class="text-write">
						<textarea name="content" id="content" title="Write down the content here." aria-label="Write down the content here."></textarea>
					</div>
				</td>
			</tr>
		</table>


		<div class="file">
			<div class="input-file" id="fileaddhtml">
				<div class="input-file-box">
					<input class="upload-name" type="text" id="file1" disabled="disabled" title="the file name" aria-label="the file name" />
					<input type="file" accept="image/*" name="file_atchFileId" id="file_atchFileId1" class="upload-hidden" onChange="javascript: checkFile(this,'1');" aria-hidden="true" />
					<label for="file_atchFileId1">Upload</label>
					<span id="fileSizeName1" title="the file size" aria-label="the file size">0KB / 10M</span>
				</div>
			</div>
			<a href="#" onclick="javascript:addFile();" class="btn-blue"> ADD </a>
		</div>

	</form>
</div><!-- E : write -->
