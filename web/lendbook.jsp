<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>借书</title>
</head>
<body onload="check()">

<div class="container-fluid">
  <div class="row">
    <div class="col-lg-5  col-md-12 contentLeft contentLeft-border gap">
      <form id="formFind">
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
                <input type="hidden" name="submit" value="查询">
                <input class="btn btn-outline-primary btn-block" type="button" value="查询" onclick="showRight()">
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
      <div id="resultInfo" class="alert alert-secondary">图书查询结果</div>
      <form id="lendBook">
        <div id="cards" class="row">

        </div>
        <div id="choice" class="input-group invisible">
          <div class="container">
            <div class="row">
              <div class="col-6">
                <input class="btn btn-outline-primary btn-block" type="button" value="借书" onclick="showResult()">
              </div>
              <div class="col-6">
                <input class="btn btn-outline-primary btn-block" type="button" value="清空选择" onclick="clearAll()">
              </div>
            </div>
          </div>
        </div>
      </form>
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

    function mouseOver(obj){
        $(obj).addClass("border-primary");
    }
    function mouseOut(obj){
        $(obj).removeClass("border-primary");
    }
    function choose(obj){
        var checkbox = obj.firstElementChild;
        var id = obj.id;
        checkbox.checked = !checkbox.checked;
        console.log(checkbox.checked);
        if(checkbox.checked){
            $(obj).addClass("text-white bg-primary");
            $("#"+ id +" div h5").removeClass("text-muted");
        }else{
            $(obj).removeClass("text-white bg-primary");
            $("#"+ id +" div h5").addClass("text-muted");
        }
    }
    function clearAll(){
        //console.log("clicked");
        $(".card").each(function () {
            //console.log("remove class");
            $(this).removeClass("bg-primary text-white")
        });
        $(".card div h5").each(function () {
            //console.log("add class");
            $(this).addClass("text-muted");
        });
        $(".card input").each(function(){
            //console.log("changed false");
            this.checked = false;
        });
    }

    function parseJson(data){
        var jsonArray = [];
        var temp = "";
        for(var i=0;i<data.length;i++){
            if(data[i] !== '}'){
                temp += data[i];
            }else{
                temp += '}';
                jsonArray.push(temp);
                temp = "";
                i++;
            }
        }
        return jsonArray;
    }

    function createDiv(bookId, bookName, author, price, ps) {
        return "<div class=\"col-md-6 col-sm-12\">" +
            "<div id=\"" + "card" + bookId + "\" class=\"card\" style=\"margin-bottom: 20px;\" onmouseover='mouseOver(this);' onmouseout='mouseOut(this);' onmouseup='choose(this);'>\n" +
            "          <input type=\"checkbox\" class=\"custom-control-input invisible\"  name=\"lend_checkbox\" value=\"" + bookId + "\">\n" +
            "          <div class=\"card-body \">\n" +
            "            <h3 class=\"card-title mb-3\">书名： <span id=\"bookName\">" + bookName + "</span></h3>\n" +
            "            <h5 class=\"card-subtitle  mb-4 text-muted\">作者： <span id=\"author\">" + author + "</span></h5>\n" +
            "            <h5 class=\"card-subtitle  mb-3 text-muted\">价格： <span id=\"price\">" + price + "</span></h5>\n" +
            "            <p class=\"card-text\">备注： <span id=\"ps\">" + ps + "</span></p>\n" +
            "          </div>\n" +
            "        </div>" +
            "       </div>";
    }
    function showResult(){
        $.ajax({
            type: "get",
            url: "lendBook.status",
            data: $("#lendBook").serialize(),
            async: true,
            success: function(result){
                $("#resultInfo").removeClass("alert-secondary");
                if(result === "successful"){
                    $("#resultInfo").addClass("alert-success");
                    $("#resultInfo")[0].innerHTML = "借书成功!";
                }else{
                    if(result === "error"){
                        $("#resultInfo").addClass("alert-danger");
                        $("#resultInfo")[0].innerHTML = "系统出错，请重试!";
                    }else if(result === "overflow"){
                        $("#resultInfo").addClass("alert-danger");
                        $("#resultInfo")[0].innerHTML = "借书超过8本，请先还书!";
                    }else{
                        $("#resultInfo").addClass("alert-warnning");
                        $("#resultInfo")[0].innerHTML = "借书成功，但有重复借书，已忽略!";
                    }
                }
                $("#choice").addClass("invisible");
                $("#cards")[0].innerHTML = "";
            }
        });
    }
    function showRight(){
        $.ajax({
            type: "get",
            url: "findbook.do",
            data: $("#formFind").serialize(),
            async: true,
            success: function(result){
                //console.log("结果"+result);
                var jsonArray = parseJson(result);
                var json;
                json = JSON.parse(jsonArray[0]);
                $("#cards")[0].innerHTML = "<div id=\"cardDisplay\">\n" +
                    "\n" +
                    "        </div>";
                if(json.result === "查询到以下结果"){
                    //console.log("array[0]: " + jsonArray[0]);
                    $("#resultInfo").removeClass();
                    $("#resultInfo").addClass("alert alert-success");
                    $("#resultInfo")[0].innerHTML = json.result;
                    for(var i=1;i<jsonArray.length;i++){
                        json = JSON.parse(jsonArray[i]);
                        $("#cardDisplay").after(createDiv(json.bookId, json.bookName, json.author, json.price, json.ps));
                    }
                    $("#result").removeClass("invisible");
                    $("#choice").removeClass("invisible")
                }else if(json.result === "没有查到相关图书"){
                    $("#resultInfo").removeClass();
                    $("#resultInfo").addClass("alert alert-danger");
                    $("#resultInfo")[0].innerHTML = json.result;
                    $("#result").removeClass("invisible");
                }
            }
        });
    }
</script>
</body>
</html>