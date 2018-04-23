<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>图书修改</title>
</head>
<body onload="check()">

<div class="container-fluid">
  <div class="row">
    <div class="col-lg-5  col-md-12 contentLeft contentLeft-border gap">
      <div class="alert alert-primary text-center">请查询要修改的图书</div>
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
      <form id="editBook">
        <div id="cards" class="row">

        </div>
        <div id="choice" class="input-group invisible">
          <div class="container">
            <div class="row">
              <div class="col">
                <input type="hidden" name="submit" value="修改">
                <input class="btn btn-outline-primary btn-block" type="button" value="修改" onclick="showEditPage()">
              </div>
            </div>
          </div>
        </div>
      </form>
    </div>
    <div id="edit" class="col-lg-7 col-md-12 contentRight gap hidden">

      <div id="editInfo" class="alert alert-primary">待修改图书信息</div>
      <div id="editCard" class="row">

      </div>
      <div id="editForm">
        <form id="editBookInfo">
        <div style="padding-left: 15px; padding-right: 15px; padding-top: 20px;">
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text">书名</span>
            </div>
            <input id="input_bookName" class="form-control" type="text" placeholder="请输入书名..." name="bookName">
          </div>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text">作者</span>
            </div>
            <input id="input_author" class="form-control" type="text" placeholder="请输入作者..." name="author">
          </div>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text">价格</span>
            </div>
            <input id="input_price" class="form-control" type="text" placeholder="请输入价格..." name="price">
          </div>
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text">备注</span>
            </div>
            <input id="input_ps" class="form-control" type="text" placeholder="请输入备注..." name="ps">
          </div>
          <div id="editChoice" class="input-group">
            <div class="container">
              <div class="row">
                <div class="col-6">
                  <input id="input_bookId" type="hidden" name="bookId" value="">
                  <input type="hidden" name="submit" value="修改">
                  <input class="btn btn-outline-primary btn-block" type="button" value="修改" onclick="showResult()">
                </div>
                <div class="col-6">
                  <input class="btn btn-outline-primary btn-block" type="reset" value="清空">
                </div>
              </div>
            </div>
          </div>
        </div>
      </form>
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

    function mouseOver(obj){
        $(obj).addClass("border-primary");
    }
    function mouseOut(obj){
        $(obj).removeClass("border-primary");
    }
    function choose(obj){
        var radio = obj.firstElementChild;
        var id = obj.id;
        clearAll();
        radio.checked = true;
        $(obj).addClass("text-white bg-primary");
        $("#"+ id +" div h5").removeClass("text-muted");

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
        var DIV = "<div class=\"col-md-6 col-sm-12\">" +
            "<div id=\"" + "card" + bookId + "\" class=\"card\" style=\"margin-bottom: 20px;\" onmouseover='mouseOver(this);' onmouseout='mouseOut(this);' onmouseup='choose(this);'>\n" +
            "          <input type=\"radio\" class=\"custom-control-input invisible\"  name=\"edit_radio\" value=\"" + bookId + "\">\n" +
            "          <div class=\"card-body \">\n" +
            "            <h3 class=\"card-title mb-3\">书名： <span id=\"bookName" + bookId + "\">" + bookName + "</span></h3>\n" +
            "            <h5 class=\"card-subtitle  mb-4 text-muted\">作者： <span id=\"author" + bookId + "\">" + author + "</span></h5>\n" +
            "            <h5 class=\"card-subtitle  mb-3 text-muted\">价格： <span id=\"price" + bookId + "\">" + price + "</span></h5>\n" +
            "            <p class=\"card-text\">备注： <span id=\"ps" + bookId + "\">" + ps + "</span></p>\n" +
            "          </div>\n" +
            "        </div>";
        return DIV;
    }
    function createCard (id) {
        var DIV = "<div class=\"col-12\">" +
            "<div class=\"card\" style=\"margin-bottom: 20px;\" >\n" +
            "          <div class=\"card-body \">\n" +
            "            <h3 class=\"card-title mb-3\">书名： <span id=\"span_bookName\">" + $("#bookName"+ id).text() + "</span></h3>\n" +
            "            <h5 class=\"card-subtitle  mb-4 text-muted\">作者： <span id=\"span_author\">" + $("#author" + id).text() + "</span></h5>\n" +
            "            <h5 class=\"card-subtitle  mb-3 text-muted\">价格： <span id=\"span_price\">" + $("#price" + id).text() + "</span></h5>\n" +
            "            <p class=\"card-text\">备注： <span id=\"span_ps\">" + $("#ps" + id).text() + "</span></p>\n" +
            "          </div>\n" +
            "        </div>";
        return DIV;
    }
    function showEditPage(){
        $("#result").addClass("hidden");
        $("#edit").removeClass("hidden");
        $("#editCard")[0].innerHTML = createCard($(".card input:checked").val());
    }
    function showResult() {
        $("#input_bookId").val($(".card input:checked").val());
        $.ajax({
            type: "get",
            url: "editbook.do",
            data: $("#editBookInfo").serialize(),
            async: true,
            success: function(result){
                $("#editForm").addClass("hidden");
                var jsonArray = parseJson(result);
                var json;
                json = JSON.parse(jsonArray[0]);
                if(json.result === "修改图书信息成功"){
                    $("#editInfo").removeClass("alert-primary");
                    $("#editInfo").addClass("alert-success");
                    $("#editInfo")[0].innerHTML = json.result;
                    json = JSON.parse(jsonArray[1]);
                    if("" !== json.bookName){ $("#span_bookName")[0].innerHTML = json.bookName; }
                    if("" !== json.author){ $("#span_author")[0].innerHTML = json.author; }
                    if("" !== json.price){ $("#span_price")[0].innerHTML = json.price; }
                    if("" !== json.ps){ $("#span_ps")[0].innerHTML = json.ps; }
                }else if(json.result === "修改图书信息失败"){
                    $("#editInfo").removeClass("alert-primary");
                    $("#editInfo").addClass("alert-danger");
                    $("#editInfo")[0].innerHTML = json.result;
                    $("#editCard")[0].innerHTML = "";
                }
            }
        });
    }
    function showRight(){
        $("#result").removeClass("hidden");
        $("#edit").addClass("hidden");
        $("#editCard")[0].innerHTML = "";
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
