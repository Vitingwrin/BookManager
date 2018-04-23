<%@ page contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>图书添加</title>
</head>
<body onload="check()">

<div class="container-fluid">
	<div class="row">
    <div class="col-lg-5  col-md-12 contentLeft contentLeft-border gap">
      <form id="formAdd">
          <div class="input-group input-group-lg">
            <div class="input-group-prepend">
              <span class="input-group-text">书名</span>
            </div>
            <input class="form-control" type="text" placeholder="请输入书名..." name="bookName">
          </div>
          <div class="input-group input-group-lg">
            <div class="input-group-prepend">
              <span class="input-group-text">作者</span>
            </div>
            <input class="form-control" type="text" placeholder="请输入作者..." name="author">
          </div>
          <div class="input-group input-group-lg">
            <div class="input-group-prepend">
              <span class="input-group-text">价格</span>
            </div>
            <input class="form-control" type="text" placeholder="请输入价格..." name="price">
          </div>
          <div class="input-group input-group-lg">
            <div class="input-group-prepend">
              <span class="input-group-text">备注</span>
            </div>
            <input class="form-control" type="text" placeholder="请输入备注..." name="ps">
          </div>
          <div class="input-group">
            <div class="container">
              <div class="row">
                <div class="col-6">
                  <input type="hidden" name="submit" value="新增">
                  <input class="btn btn-outline-primary btn-block" type="button" value="新增" onclick="showRight()">
                </div>
                <div class="col-6">
                  <input class="btn btn-outline-primary btn-block" type="reset" value="清空">
                </div>
              </div>
            </div>
          </div>
      </form>
    </div>
    <div id="result" class="col-lg-7 col-md-12 contentRight gap invisible">
      <div id="resultInfo" class="alert alert-secondary">新增图书结果</div>
      <div class="card">
        <div class="card-body ">
          <h3 class="card-title mb-3">书名： <span id="bookName"></span></h3>
          <h5 class="card-subtitle  mb-4 text-muted">作者： <span id="author"></span></h5>
          <h5 class="card-subtitle  mb-3 text-muted">价格： <span id="price"></span></h5>
          <p class="card-text">备注： <span id="ps"></span></p>
        </div>
      </div>
    </div>
  </div>
</div>


<script type="text/javascript">
    function check() {
        console.log(document.referrer);
        if (document.referrer === "") {
            window.location.href = "login.jsp";
        }
    }
    function showRight(){
        $.ajax({
            type: "get",
            url: "addbook.do",
            data: $("#formAdd").serialize(),
            async: true,
            success: function(result){
                var json = JSON.parse(result);
                if(json.result === "新增图书成功"){
                    $("#resultInfo").removeClass();
                    $("#resultInfo").addClass("alert alert-success");
                    $("#resultInfo")[0].innerHTML = json.result;
                    $("#bookName")[0].innerHTML = json.bookName;
                    $("#author")[0].innerHTML = json.author;
                    $("#price")[0].innerHTML = json.price;
                    $("#ps")[0].innerHTML = json.ps;
                    $("#result").removeClass("invisible");
                }else if(json.result === "新增图书失败"){
                    $("#resultInfo").removeClass();
                    $("#resultInfo").addClass("alert alert-danger");
                    $("#resultInfo")[0].innerHTML = json.result;
                    $("#bookName")[0].innerHTML = json.bookName;
                    $("#author")[0].innerHTML = json.author;
                    $("#price")[0].innerHTML = json.price;
                    $("#ps")[0].innerHTML = json.ps;
                    $("#result").removeClass("invisible");
                }
            }
        });

    }
</script>
</body>
</html>