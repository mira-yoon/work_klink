<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

  /* 타이틀 */
	$(document).ready(function () {
		$(document).attr("title", "Q&A > FAQ : K-LINK");
    var $pagination = $("ul.pagination");
    $pagination.children("li").each(function() {
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
    var reqUrl = "/lu/faq/listBbs";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").attr("target", "_self");
    $("#frmBbs").submit();
  }
  /* 상세 조회 */
  function fn_detail(seq) {
    document.frmBbs.bbsNoticeId.value = seq;
    var reqUrl = "/lu/faq/detailBbs";
    $("#frmBbs").attr("action", reqUrl);
    $("#frmBbs").attr("target", "_self");
    $("#frmBbs").submit();
  }

</script>
<div id="faq">
  <div class="board">
    <div class="search-box">
      <form id="frmBbs" name="frmBbs" method="post">
        <input type="hidden" name="bbsNoticeId" id="bbsNoticeId" />
        <input type="hidden" name="pageIndex" id="pageIndex" value="${comBbsNoticeVO.pageIndex}" />
        <div class="select">
          <label class="ir_so">Please choose an option</label>
          <select name="searchType" title="Please choose an option." aria-label="Please choose an option.">
            <option value="ALL" <c:if test="${comBbsNoticeVO.searchType eq 'ALL' }">selected</c:if> >All</option>
            <option value="SUB" <c:if test="${comBbsNoticeVO.searchType eq 'SUB' }">selected</c:if> >Subject</option>
            <option value="CON" <c:if test="${comBbsNoticeVO.searchType eq 'CON' }">selected</c:if> >Content</option>
          </select>
        </div>
        <div class="text-input">
          <input type="text" title="Type your search." aria-label="Type your search." name="searchKeyword" value="${comBbsNoticeVO.searchKeyword}" />
        </div>
        <button class="btn-search" type="submit" onclick="javascript:fn_search('1');">
          <i class="fa fa-search" title="Search" aria-label="Search"></i>
          <span>Search</span>
        </button>
        <div class="total">
          <p>Total : <span>${totalCount}</span></p>
        </div>
      </form>
    </div>
    <table>
      <caption class="sr-only">FAQ List</caption>
      <thead>
        <tr>
          <th scope="col" style="width:8%;">No.</th>
          <th scope="col">Question</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="result" items="${resultList }" varStatus="status">
          <tr>
            <td class="num">
              <c:out value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}" />
            </td>
            <td class="title"><a href="#" onclick="javascript:fn_detail('${result.bbsNoticeId}')">
                <c:out value="${result.title }" /></a></td>
          </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
          <tr>
            <td colspan="2">등록된 공지사항이 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
    <div id="number">
      <ul class="pagination">
        <ui:pagination paginationInfo="${paginationInfo}" type="uimage" jsFunction="fn_search" />
      </ul>
    </div>
  </div>
</div><!-- E : faq -->
