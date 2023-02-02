<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
  /* 타이틀 */
  $(document).ready(function () {
    $(document).attr("title", "Community > Community > Daily List : K-LINK");

    var $pagination = $("ul.pagination");
    $pagination.children("li").each(function () {
      var $this = $(this).children("a");

      if ($this.hasClass("select")) {
        $this.attr("title", "page" + $this.text() + "-selected");
      } else {
        $this.attr("title", "page" + $this.text());
      }
    });
  });

  /* 조회 */
  function fn_search(param1) {
    $("#pageIndex").val(param1);
    var reqUrl = "/lu/community/communityList";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").attr("target", "_self");
    $("#frmBbs").submit();
  }
  /* 상세 조회 */
  function fn_detail(seq) {

    $("#bbsNoticeId").val(seq);
    var reqUrl = "/lu/community/communityDetail";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").submit();

  }
  /* 상세 조회 */
  function fn_insert() {

    var reqUrl = "/lu/community/communityInsert";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").submit();

  }
</script>
<form id="frmBbs" name="frmBbs" method="post">
  <input type="hidden" name="bbsNoticeId" id="bbsNoticeId" />
  <input type="hidden" name="courseCd" id="courseCd" value="${comBbsNoticeVO.courseCd}" />
  <input type="hidden" name="pageIndex" id="pageIndex" value="${comBbsNoticeVO.pageIndex}" />
</form>
<div id="community">
  <h2 class="sr-only">Community Annual List</h2>
  <div class="board">

    <c:forEach var="result" items="${resultList }" varStatus="status">
      <c:if test="${status.first}">
        <ul class="card-board">
      </c:if>
      <c:if test="${not status.first}">
        <c:if test="${status.count mod 3 eq 1}">
          <ul class="card-board">
        </c:if>
      </c:if>

          <li>
            <a href="javascript:void(0)" onclick="javascript:fn_detail('${result.bbsNoticeId }'); return false;"
              title="Click here to see pictures">
              <div class="community-title">
                <span>
                  <c:out value="${result.title }" /></span>
                <div class="lookup" title="the view count">
                  <span class="sr-only">the view count</span>
                  <i class="fa fa-globe" aria-hidden="true"></i>
                  <c:out value="${result.readCnt }" />
                </div>
              </div>

              <div class="community-img">
                <c:if test="${empty result.bbsFileId}">
                  <span>No Image</span>
                </c:if>
                <c:if test="${not empty result.bbsFileId}">
                  <img src="/commbiz/bbs/getImage.do?bbsFileId=${result.bbsFileId}" alt="${result.title } thumnail image">
                </c:if>
              </div>
            </a>
          </li>

      <c:if test="${status.count mod 3 eq 0}">
        </ul>
      </c:if>
      <c:if test="${status.count mod 3 ne 0}">
        <c:if test="${status.last}">
          </ul>
        </c:if>
      </c:if>
    </c:forEach>
    <c:if test="${empty resultList}">
      <ul class="card-board" style="height:200px;padding:20px;">
        <center>No posts have been submitted.</center>
      </ul>

    </c:if>

    <div class="btn-box">
      <a href="javascript:void(0)" onclick="javascript:fn_insert(); return false;" class="btn-list">Register</a>
    </div>
    <c:if test="${not empty resultList}">

      <div id="number">
        <ul class="pagination">
          <ui:pagination paginationInfo="${paginationInfo}" type="uimage" jsFunction="fn_search" />
        </ul>
      </div>
    </c:if>
  </div>
</div><!-- E : community -->