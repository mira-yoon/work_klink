<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

	$(document).ready(function () {

    /* 타이틀 */
		$(document).attr("title", "Notice > Details : K-LINK");

	});

  /* 목록 */
  function fn_search() {
    var reqUrl = "/lu/notice/listBbs";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").attr("target", "_self");
    $("#frmBbs").submit();
  }
  /* 상세 조회 */
  function fn_detail(seq) {

    document.frmBbs.bbsSeq.value = seq;

    var reqUrl = "/lu/notice/detailBbs";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").attr("target", "_self");
    $("#frmBbs").submit();
  }

  function fn_egov_downFile(bbsFileId, fileSn) {
    window.open("<c:url value='/commbiz/bbs/comBbsFileDown.do?importComBbsFileId=" + bbsFileId + "&importfileSn=" +
      fileSn + "'/>");
  }
</script>
<form id="frmBbs" name="frmBbs" method="post" enctype="multipart/form-data">
  <input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${pageIndex}'/>" />
  <input type="hidden" id="bbsSeq" name="bbsSeq" />
</form>

<div id="read">
  <div class="btn-box">
    <ul>
      <li><a href="#" class="btn-white" onclick="javascript:fn_search();">List</a></li>
    </ul>
  </div>
  <table>
    <caption class="sr-only">Notice Content</caption>
    <tr>
      <th scope="row">Title</th>
      <td colspan="3">${result.title }</td>
    </tr>
    <tr class="mobile-none">
      <th scope="row">Register</th>
      <td>${result.insertUser}</td>
      <th scope="row">Register Date</th>
      <td>${result.insertDate}</td>
    </tr>

    <tr class="mobile-on">
      <th scope="row">Register</th>
      <td colspan="3">${result.insertUser}</td>
    </tr>
    <tr class="mobile-on">
      <th scope="row">Register Date</th>
      <td colspan="3">${result.insertDate}</td>
    </tr>

    <c:if test="${not empty fileList }">
      <tr>
        <th scope="row">Attached Files</th>
        <td colspan="3">
          <c:forEach var="fileList" items="${fileList }" varStatus="status">
            <a href="#"
              onclick="javascript:fn_egov_downFile('${fileList.bbsFileId}','${fileList.fileSn}');">${fileList.orgFileName}</a>
            <br />
          </c:forEach>
        </td>
      </tr>
    </c:if>

    <tr>
      <td colspan="4">
        <div class="text-read">
          <c:out value="${result.content}" escapeXml="false" />
        </div>
      </td>
    </tr>
  </table>
  <div class="btn-box">
    <ul>
      <li><a href="#" class="btn-white" onclick="javascript:fn_search();">List</a></li>
    </ul>
  </div>
</div><!-- E : read -->
