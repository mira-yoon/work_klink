<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%><%@ 
taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ 
taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ 
taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
  
  $(document).ready(function () {
    /* 타이틀 */
    $(document).attr("title", "My Page > My Desk > View : K-LINK");
  });

  function printArea() {
    window.print();
  }

  /** 첨부파일 다운로드 */
  function fn_applyFileDown(seq) {

    $("#downFileNo").val(seq);
    var reqUrl = "/lu/apply/getFile";
    $("#frmApplyUserInfo").attr("action", reqUrl);
    $("#frmApplyUserInfo").submit();
  }
</script>
<form id="frmApplyUserInfo" name="frmApplyUserInfo" method="post" enctype="multipart/form-data">
  <input type="hidden" name="phone" id="phone" value="${applyUserInfoVO.phoneStr}" />
  <input type="hidden" name="mobile" id="mobile" value="${applyUserInfoVO.mobileStr}" />
  <input type="hidden" name="courseCd" id="courseCd" value="${applyUserInfoVO.courseCd}" />
  <input type="hidden" name="applyCd" id="applyCd" value="${applyUserInfoVO.applyCd}" />
  <input type="hidden" name="stepCd" id="stepCd" />
  <input type="hidden" name="downFileNo" id="downFileNo" />
</form>
<div id="apply">
  <div class="apply-pop">
    <div class="step-1 step-area">
      <h6>Step. 1 Terms and Conditions</h6>
      <div class="agree-text">
        <p>A qualified nominee must restrain from any activities that could be a hindrance to the training program such as :</p>
        <ul>
          <li>- Engaging in political activities, or any form of employment for profit or gain;</li>
          <li>- Extending the length of stay for personal conveniences;</li>
          <li>- Bringing any family members(dependents) to Korea;</li>
          <li>- And other actions that are not listed but could possibly cause interruptions to the training program.
          </li>
        </ul>
      </div>
    </div>

    <div class="step-2 step-area">
      <h6>Step. 2 Basic Information</h6>
      <table>
        <caption class="sr-only">Basic Information</caption>
        <tr>
          <th scope="row">Course Year</th>
          <td>${fn:substring(courseDetail.dayStart,0,4)}</td>
        </tr>

        <tr>
          <th scope="row">Duration</th>
          <td>${courseDetail.dayStart} ~ ${courseDetail.dayEnd}</td>
        </tr>

        <tr>
          <th scope="row">Course Title</th>
          <td>${courseDetail.title}</td>
        </tr>

        <tr>
          <th scope="row">Photo</th>
          <td>
            <div class="photo-area"><img src="/lu/apply/getFile?downFileNo=1&applyCd=${applyUserInfoVO.applyCd}" alt="profile photo" />
            </div>
          </td>
        </tr>

        <tr>
          <th scope="row">Nationality</th>
          <td> </td>
        </tr>

        <tr>
          <th scope="row">First Name</th>
          <td>${applyUserInfoVO.firstNameStr}</td>
        </tr>

        <tr>
          <th scope="row">Last Name</th>
          <td>${applyUserInfoVO.lastNameStr}</td>
        </tr>

        <tr>
          <th scope="row">Business Phone</th>
          <td class="phone">${applyUserInfoVO.phoneStr}
        </tr>

        <tr>
          <th scope="row">Mobile Phone</th>
          <td class="phone">${applyUserInfoVO.mobileStr}</td>
        </tr>

        <tr>
          <th scope="row">Business Email</th>
          <td>${applyUserInfoVO.businessEmailStr}</td>
        </tr>

        <tr>
          <th scope="row">Private Email</th>
          <td>${applyUserInfoVO.privateEmailStr}</td>
        </tr>

        <tr>
          <th scope="row">Organization</th>
          <td class="radio-select">${applyUserInfoVO.organizationName}</td>
        </tr>
        <tr>
          <th scope="row">Gender</th>
          <td class="radio-select">
            <c:if test="${applyUserInfoVO.gender eq 'm' }">Male</c:if>
            <c:if test="${applyUserInfoVO.gender eq 'f' }">Female</c:if>
          </td>
        </tr>

        <tr>
          <th scope="row">Date of Birth</th>
          <td class="birth">${applyUserInfoVO.birthdate}</td>
        </tr>

        <tr>
          <th scope="row">Organization<br />Website (Optional)</th>
          <td>${applyUserInfoVO.website}</td>
        </tr>

        <tr>
          <th scope="row">Passport copy</th>
          <td>
            <div class="photo-area"><img src="/lu/apply/getFile?downFileNo=2&applyCd=${applyUserInfoVO.applyCd}" alt="a copy of your passport" />
            </div>
          </td>
        </tr>

        <tr>
          <th scope="row">Business Card<br />copy</th>
          <td>
            <div class="photo-card"><img src="/lu/apply/getFile?downFileNo=3&applyCd=${applyUserInfoVO.applyCd}" alt="a copy of your business card" />
            </div>
          </td>
        </tr>
      </table>

      <h6>Reference</h6>
      <div class="step-text">
        <p>It is necessary to have someone as a reference (nominator) if you want to apply for the course. The reference could be divided into two types :</p>
        <p>EITHER guarantee and verification of the applicant’s ability from the superior (The reference should be in higher position than Department Head of the applicant’s organization or managerial position of the upper body.)</p>
        <p>OR guarantee from the business partner in Korea. (The reference should be someone from Korean government or Korean company that is cooperating with the applicant’s organization.)</p>
        <p>Please have the reference fill out 'Letter of Reference' and upload it. 'Letter of Reference' froms could be downloaded from the 'News & Notice' from 'News' section of the website.</p>
      </div>
      <table>
        <caption class="sr-only">Reference</caption>
        <tr>
          <th scope="row">Name of the Reference</th>
          <td>${applyUserInfoVO.referenceName}</td>
        </tr>

        <tr>
          <th scope="row">Nationality of the reference</th>
          <td>${ applyUserInfoVO.referenceNation}</td>
        </tr>

        <tr>
          <th scope="row">Organization of the reference</th>
          <td>${applyUserInfoVO.referenceOrganization}</td>
        </tr>

        <tr>
          <th scope="row">Position of the reference</th>
          <td>${applyUserInfoVO.referencePosition}</td>
        </tr>

        <tr>
          <th scope="row">Organization of the reference</th>
          <td class="app-con">
            <a href="#" onclick="javascript:fn_applyFileDown('4');">${applyUserInfoVO.referenceFileName}</a>
          </td>
        </tr>
      </table>

      <h6>Application</h6>
      <div class="step-text">
        <p>When you click the register button, all data you have typed will be electronically sent to an internal committee and your participation will be decided based on your given information.</p>
      </div>

      <div class="application">
        <span>1. Please describe ICT Projects in your organization or country based on the attached form.</span>
        <div class="app-con">
          <a href="#" onclick="javascript:fn_applyFileDown('5');">${applyUserInfoVO.ictFileName}</a>
        </div>

        <span>2. Is there any Korean Companies you would like to have a business meeting with?</span>
        <div class="app-con">${applyUserInfoVO.businessMeeting}</div>

        <span>3. Please describe current cooperation between Korean government/companies and your organization</span>
        <div class="app-con">${applyUserInfoVO.cooperation}</div>

        <span>4. Please explain your job duty..</span>
        <div class="app-con">${applyUserInfoVO.jobDuty}</div>

        <span>5. Please describe any topics, lectures or places of interest you would like to see in the course related to your tasks mentioned above.</span>
        <div class="app-con">${applyUserInfoVO.courseRelatedTasks}</div>

        <span>6. What are you trying to achieve through this program?</span>
        <div class="app-con">${applyUserInfoVO.achieve}</div>
      </div>
    </div>
  </div>
</div><!-- E: apply -->
