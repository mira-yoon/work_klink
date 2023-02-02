<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">

  /* 타이틀 */
  $(document).ready(function() {
    $(document).attr("title","My Page > My Info > Withdrawal : K-LINK");
  });

  function fn_Withdrawal() {

    if ($('input:checkbox[name=agree]').is(':checked') == false) {
      alert("Please check your consent.");
      return;
    } else if (!$('#password').val()) {
      alert("Please enter a password.");
      $("#password").focus();
      return false;
    } else {
      var reqUrl = "/lu/mypage/secession";
      $("#frmLogin").attr("action", reqUrl);
      $("#frmLogin").submit();
    }
  }
</script>
<div id="Withdrawal">
  <p>Before you request to withdraw your membership, please refer to the following announcement</p>
  <ul>
    <li>1. Your ID will be immediately deleted and cannot be used when rejoining once you applied for membership withdrawal.</li>
    <li>2. All your postings and replies on bulletin boards will remain eben after you withdraw your membership.</li>
    <li>3. Mailing service will continue after the membership withdrawal. If you do not want to receive any mails from K-LINK, uncheck ‘mailing’ box at My page - My info.</li>
    <li>4. Thank you for having been a member of K-LINK, we hope to see you again.</li>
  </ul>
  <form action="/lu/mypage/secession" id="frmLogin" name="frmLogin" method="post">
    <table>
      <caption class="sr-only">Membership Withdrawal</caption>
      <tr>
        <th class="row">User ID</th>
        <td>${result.memId}</td>
      </tr>
      <tr>
        <th class="row">Password</th>
        <td>
          <div class="input-box">
            <input type="password" title="password" aria-label="password" name="memPassword" id="password" autocomplete="off" />
          </div>
        </td>
      </tr>
    </table>
    <input type="checkbox" title="Check if you agree." aria-label="Check if you agree." id="agree" name="agree" value="Y" />
    <label for="agree">I have read terms and conditions; I agree that my ID can not be reused and all data relateed can not be restored.</label>
  </form>
  <div class="btn-box">
    <a href="#" class="btn-blue" onclick="javascript:fn_Withdrawal();">Confirm</a>
    <a href="/lu/mypage/myInfo.do" class="btn-white">Cancel</a>
  </div>
</div><!-- E : withdrawal -->