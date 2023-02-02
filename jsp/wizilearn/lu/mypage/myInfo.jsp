<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script>
  /* 타이틀 */
  $(document).ready(function () {
    $(document).attr("title", "My Page > My Info : K-LINK");
  });
</script>

<div id="myInfo">
  <table>
    <caption class="sr-only">My Information</caption>
    <tr>
      <th scope="row">User ID </th>
      <td>${result.memId}</td>
    </tr>

    <tr>
      <th scope="row">Birth Date </th>
      <td>${result.memBirthStr}</td>
    </tr>

    <c:if test="${not empty result.memAtchfile}">
      <tr>
        <th scope="row">Passport Copy </th>
        <td>
          <div class="picture-box">
            <img alt="picture-box" src="/commbiz/atchfle/getImage.do?atchFileId=${result.memAtchfile}" alt="a copy of your passport" />
          </div>
        </td>
      </tr>
    </c:if>

    <tr>
      <th scope="row">Name</th>
      <td>${result.memNameStr} ${result.memLastNameStr}</td>
    </tr>

    <tr>
      <th scope="row">Nationality </th>
      <td>${result.natName}</td>
    </tr>

    <tr>
      <th scope="row">Organization</th>
      <td>${result.orgName}</td>
    </tr>

    <tr>
      <th scope="row">Department / Division </th>
      <td>${result.depName}</td>
    </tr>

    <tr>
      <th scope="row">Job title / position </th>
      <td>${result.memJob}</td>
    </tr>

    <tr>
      <th scope="row">Type of Organization </th>
      <td>${result.orgGubunName}</td>
    </tr>

    <tr>
      <th scope="row">Email</th>
      <td>${result.emailStr}</td>
    </tr>

    <tr>
      <th scope="row">Sub Email </th>
      <td>${result.emailSubStr}</td>
    </tr>

    <tr>
      <th scope="row">Mobile</th>
      <td>${result.hpNoStr}</td>
    </tr>

    <tr>
      <th scope="row">Business Phone</th>
      <td>${result.telNoStr}</td>
    </tr>

  </table>
  <div class="btn-box">
    <a href="/lu/mypage/withdrawal.do" class="btn-blue">Membership Withdrawal</a>
    <a href="/lu/mypage/updateSignup.do" class="btn-blue">Modify</a>
  </div>
</div><!-- E : myInfo -->