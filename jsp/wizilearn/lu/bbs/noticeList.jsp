<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags" %><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
 taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

	/* 타이틀 */
	$(document).ready(function () {
		$(document).attr("title", "Notice > Notice : K-LINK");
	});

	/* 조회 */
	function fn_search(param1) {
		$("#pageIndex").val(param1);
		var reqUrl = "/lu/notice/listBbs";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").attr("target", "_self");
		$("#frmBbs").submit();
	}
	/* 상세 조회 */
	function fn_detail(seq) {

		$("#bbsNoticeId").val(seq);
		var reqUrl = "/lu/notice/detailBbs";
		$("#frmBbs").attr("action", reqUrl);
		$("#frmBbs").submit();
	}

</script>
<c:set var="today" value="<%=new java.util.Date()%>" />
<fmt:formatDate var="now" type="date" value="${today}" pattern="yyyyMMdd" />
<div id="notice">
	<div class="board">
		<div class="search-box">
			<form id="frmBbs" name="frmBbs" method="post">
				<input type="hidden" name="bbsNoticeId" id="bbsNoticeId" />
				<input type="hidden" name="pageIndex" id="pageIndex" value="${comBbsNoticeVO.pageIndex}" />
				<div class="select">
					<label class="ir_so">Please choose an option.</label>
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
					<p>Total : <span>${totalCount gt 7 ? totalCount - 7 : totalCount}</span></p>
				</div>
			</form>
		</div>
		<table>
			<caption class="sr-only">Notice List</caption>
			<thead>
				<tr>
					<th scope="col" class="num">No.</th>
					<th scope="col" class="title">Subject</th>
					<th scope="col" class="file">File</th>
					<th scope="col" class="date">Date</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList }" varStatus="status">
					<fmt:parseDate var="bdate" value="${result.insertDate}" pattern="yyyy.MM.dd" />
					<fmt:formatDate var="bdate" value="${bdate}" pattern="yyyyMMdd" />
					<c:set var="num" value="${totalCount - ((pageIndex-1) * pageSize + status.count)+1}" />
					<c:if test="${num gt 7}">
						<tr data-row-index="${status.index}">
							<c:choose>
								<c:when test="${'1' == result.bbsSort}">
									<td class="num">공지</td>
									<td class="title">
										<a href="#" class="notice" onclick="javascript:fn_detail('${result.bbsNoticeId}')">
											<c:if test="${now-bdate < 8}">
												<span
													style="font-size:9pt; color:#fff; border-radius:4px; padding:2px 4px; background:#3B78BA;">New</span>
											</c:if>
											<c:out value="${result.title }" />
										</a>
									</td>
								</c:when>
								<c:otherwise>
									<td class="num">
										<c:out value="${num}" />
									</td>
									<td class="title">
										<a href="#" onclick="javascript:fn_detail('${result.bbsNoticeId}')">
											<c:if test="${now-bdate < 8}">
												<span
													style="font-size:9pt; color:#fff; border-radius:4px; margin-right:4px; padding:2px 4px; background:#3B78BA;">New</span>
											</c:if>
											<c:out value="${result.title }" />
										</a>
									</td>
								</c:otherwise>
							</c:choose>
							<td class="file">
								<c:if test="${not empty result.bbsFileId}"><i class="fa fa-floppy-o" title="attached file"
										aria-hidden="true"><span class="sr-only">attached file</span></i></c:if>
							</td>
							<td class="date">
								<c:out value="${result.insertDate }" />
							</td>
						</tr>
					</c:if>
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="4">등록된 공지사항이 없습니다.</td>
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
</div>
<script type="text/javascript">
	"use strict";
	(function() {
		var $pagination = $("ul.pagination");
		$pagination.children("li").each(function(idx, e) {
			if (idx === 4) {
				$(e).hide();
			}
		});

		$pagination.children("li").each(function() {
			var $this = $(this).children("a");

			if ($this.hasClass("select")) {
				$this.attr("title", "page" + $this.text() + "-selected");
			} else {
				$this.attr("title", "page" + $this.text());
			}
		});

		// 첫 행 붉은색으로 표시
		var $row = $("tr[data-row-index=0]");
		var $num = $row.find("td.num");
		var $title = $row.find("td.title a");
		var $date = $row.find("td.date");
		var style = {
			color: "#e60000",
			fontWeight: "bold"
		};
		$num.css(style);
		$title.css(style);
		$date.css(style);
	})();
</script>
<!-- E: notice -->
