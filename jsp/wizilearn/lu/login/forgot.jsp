<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
  /* 타이틀 */
  $(document).ready(function() {
    $(document).attr("title","Memberships > Forgot your ID/PWD : K-LINK");
  });

  /* 공백 입력 체크 */
  function isEmptyValue(obj) {
    var returnValue = false;
    if (obj.value.replace(/^\s*|\s*$/g, "") == "") {
      returnValue = true;
    }
    return returnValue;
  }

  /* 정규식 체크 */
  function isRegexCheck(value, regex) {
    var returnValue = false;
    returnValue = regex.test(value);
    return returnValue;

  }
  /*
   * 공백 포함여부 체크
   * true : 포함
   * false : 미포함
  */
  function isContainEmpty(value) {
    var p = /[\s]/g;
    if (p.test(value))
      return true;
    return false;
  }

  function fn_passwordfind() {

    var memId = $("#memId", "#forgotPasswordFrm").val();
    var email = $("#email", "#forgotPasswordFrm").val();

    // 아이디체크
    var regex = /^[a-z0-9]{5,200}$/;
    if (memId == '') {
      alert("UserId is required.");
      $("#memId", "#forgotPasswordFrm").focus();
      return false;
    } else if (isContainEmpty(memId)) {
      alert("Can't enter spaces in the UserId");
      $("#memId", "#forgotPasswordFrm").focus();
      return false;
    } else if (!isRegexCheck(memId, regex)) {
      alert("UserId is the Latin small letter, number 6-12 digits.");
      $("#memId", "#forgotPasswordFrm").focus();
      return false;
    }
    // 이메일체크
    var regex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    if (email == '') {
      alert("Email is required.");
      $("#email", "#forgotPasswordFrm").focus();
      return false;
    } else if (isContainEmpty(email)) {
      alert("Can't enter spaces in the Email");
      $("#email", "#forgotPasswordFrm").focus();
      return false;
    } else if (!isRegexCheck(email, regex)) {
      alert("Email format is invalid.");
      $("#email", "#forgotPasswordFrm").focus();
      return false;
    }

    var reqUrl = "/lu/findPassword.do";
    $("#forgotPasswordFrm").attr("action", reqUrl);
    $("#forgotPasswordFrm").attr("target", "_self");
    $("#forgotPasswordFrm").submit();
  }


  function fn_findMemId() {

    $.ajax({
      type: "POST",
      contentType: "application/x-www-form-urlencoded",
      dataType: "json",
      url: "/lu/findMemId.do",
      data: $("#forgotIdFrm").serialize(),
      error: function (jqXHR, textStatus, errorThrown) {
        $("#id-find").hide();
        alert("Please check your email address.");
      },
      success: function (data) {
        $("#id-find").show();
        $("#searchName").html(data.data);
      }
    });

  }

</script>
<div id="forgot">
  <p class="guide">To renew your ID/password, enter User ID and e-mail address you provided when signing up. Your password will be automatically sent. Check your-email for your ID and password. If you are an instructor, ask the K-LINK staff.</p>

  <form name="forgotPasswordFrm" id="forgotIdFrm" method="post" target="_self">
    <div class="forgot-box">
      <div class="title">
        <span><i class="fa fa-user" aria-hidden="true"></i>Forgot your ID?</span>
        <p>LEADERS’ INFORMATION NETWORK</p>
      </div>
      <table>
        <caption class="sr-only">Find your ID</caption>
        <tr>
          <th scope="row">E-mail</th>
          <td>
            <div class="input-box">
              <input type="text" title="E-mail address" aria-label="E-mail address" name="email" />
            </div>
          </td>
        </tr>
      </table>
      <div class="btn-box">
        <button type="button" class="btn-blue" onclick="javascript:fn_findMemId();">Submit</button>
      </div>
      <div class="id-find" id="id-find" style="display:none;">
        <p>Your ID : <span id="searchName">[wizilearn]</span></p>
      </div>
    </div>
  </form>

  <form name="forgotPasswordFrm" id="forgotPasswordFrm" method="post" target="_self">
    <div class="forgot-box">
      <div class="title">
        <span><i class="fa fa-lock" aria-hidden="true"></i>You Have to Sign in.</span>
        <p>LEADERS’ INFORMATION NETWORK</p>
      </div>
      <table>
        <caption class="sr-only">Find your password</caption>
        <tr>
          <th scope="row">User ID</th>
          <td>
            <div class="input-box">
              <input type="text" title="User ID" aria-label="User ID" id="memId" name="memId" placeholder="User ID" />
            </div>
          </td>
        </tr>
        <tr>
          <th scope="row">E-mail</th>
          <td>
            <div class="input-box">
              <input type="text" title="E-mail address" aria-label="E-mail address" id="email" name="email" placeholder="E-mail" />
            </div>
          </td>
        </tr>
      </table>
      <div class="btn-box">
        <button type="submit" class="btn-blue" onclick="javascript:fn_passwordfind();">Submit</button>
      </div>
    </div>
  </form>

</div><!-- E : forgot -->
