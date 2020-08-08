<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Bootshop online Shopping cart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
<!--Less styles -->
   <!-- Other Less css file //different less files has different color scheam
    <link rel="stylesheet/less" type="text/css" href="themes/less/simplex.less">
    <link rel="stylesheet/less" type="text/css" href="themes/less/classified.less">
    <link rel="stylesheet/less" type="text/css" href="themes/less/amelia.less">  MOVE DOWN TO activate
    -->
    <!--<link rel="stylesheet/less" type="text/css" href="themes/less/bootshop.less">
    <script src="themes/js/less.js" type="text/javascript"></script> -->
    
<!-- Bootstrap style --> 
    <link id="callCss" rel="stylesheet" href="themes/bootshop/bootstrap.min.css?ver=1" media="screen"/>
    <link href="themes/css/base.css?ver=1" rel="stylesheet" media="screen"/>
<!-- Bootstrap style responsive --> 
    <link href="themes/css/bootstrap-responsive.min.css?ver=1" rel="stylesheet"/>
    <link href="themes/css/font-awesome.css?ver=1" rel="stylesheet" type="text/css">
<!-- Google-code-prettify -->   
    <link href="themes/js/google-code-prettify/prettify.css?ver=1" rel="stylesheet"/>
<!-- fav and touch icons -->
    <link rel="shortcut icon" href="themes/images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="themes/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="themes/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="themes/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="themes/images/ico/apple-touch-icon-57-precomposed.png">
    
    <!-- Cutomizing CSS -->
    <link href="css/order.css" rel="stylesheet">
    <style type="text/css" id="enject"></style>
    
    <script>
    function inNumber(e){
    	
		if(event.keyCode >=48 && event.keyCode <= 57){
			return true;
		} else {
			event.returnValue=false;
		}
		
	}

	
	function qtyChange(qty, sort, cartNum){
		var changeUrl='CartQtyChange.book?cartNum=' + cartNum + "&qty=";
		var removeUrl='CartRemove.book?cartNum=' + cartNum;
		if(sort === "minus") {
			qty = qty-1;
			alert(qty);		
		} else if(sort === "plus"){
			qty = qty+1;
			alert(qty);
		} else {
			qty = sort.value;
		}
		
		if(qty == 0){
			console.log(qty);
			if(confirm('삭제하시겠습니까?')){
				location.href=removeUrl;				
			}
		} else if(qty < 0){
			console.log(qty);
			alert("수량을 1 ~ 99 사이의 값으로 입력하세요.");
			sort.value = 1;
			console.log(sort);
		} else if(qty > 0){
			console.log(qty);
			location.href=changeUrl+qty;
		}
	}
    
	function qtyRemove(cartNum){
		var removeUrl='CartRemove.book?cartNum=' + cartNum;
			if(confirm('삭제하시겠습니까?')){
				location.href=removeUrl;	
			}
	}
	
	// 체크박스 전체선택/전체해제
	function checkAll(checkBox) {
		if(checkBox.checked == true) {
			$(".checklist").prop("checked", true);
		} else {
			$(".checklist").prop("checked", false);
		}
	}
    
    </script>
  </head>
<body>
<div id="header">
<div class="container">
<div id="welcomeLine" class="row">
    <!-- <div class="span6"></div> -->
    <div class="">
	    <span style="padding-left: 30px;font-size: 15px;">
	    	<c:if test="${sessionScope.uID ne null}"> 
		        welcome ${sessionScope.uID}님
		    </c:if></span>
	    <div class="pull-right">
	    	<c:set var="strAdmin" value="<%= new String[]{\"admin\",\"admin1\",\"admin2\",\"admin3\",\"admin4\"} %>"/>
	    	<c:forEach var = "i" items="${strAdmin }">
	    		<c:if test="${sessionScope.uID.equals(i)}">
	    		 	<a href="AdminMain.adm">관리자</a> |
	    		</c:if>
	    	</c:forEach>
	    	<c:if test="${sessionScope.uID.equals('admin')}">
<!-- 		    <a href="AdminMain.adm">관리자</a> | -->
		    </c:if>
		    <c:if test="${sessionScope.uID ne null}"> 
		        <a href="LogoutPro.me">로그아웃</a> |
		    </c:if>
		    <c:if test="${sessionScope.uID eq null}">
		        <a href="Login.me">로그인</a> |
		    </c:if>
		    <c:if test="${sessionScope.uID ne null}">
	        </c:if>
	        <c:if test="${sessionScope.uID eq null}">
	        <a href="JoinForm.me">회원가입</a> |
	        </c:if>
	        <a href="OrderList.mo">마이페이지</a> |
	        <a href="helpCenter.jsp">고객센터</a>
	        <a href="BookCart.book"><span class="btn btn-mini btn-primary"><i class="icon-shopping-cart icon-white"></i> [ ${cartList.size()} ] 장바구니 </span> </a> 
	    </div>s
    </div>
</div>
<!-- Navbar ================================================== -->
<div id="logoArea" class="navbar">
<a id="smallScreen" data-target="#topMenu" data-toggle="collapse" class="btn btn-navbar">
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
</a>
  <div class="navbar-inner">
    <a class="brand" href="index.jsp"><img src="themes/images/logo.png?ver=1" alt="Bootsshop"/></a>
<!--    검색하는 창 -->
    <form class="form-inline navbar-search pull-right" method="post" action="products.html" >
        <input id="srchFld" class="srchTxt" type="text" />
        <button type="submit" id="submitButton" class="btn btn-primary">검색</button>
    </form>
    <ul id="topMenu" class="nav">
     <li><a href="">로드맵</a></li>
     <li><a href="BookList.book">교재구매</a></li>
     <li><a href="NoticeList.bo">이벤트</a></li>
    </ul>
  </div>
</div>
</div>
</div>
<!-- Header End====================================================================== -->

<div id="mainBody">
	<div class="container">
	<div class="row">

<!-- Sidebar ================================================== -->
    <div id="sidebar" class="span3" style="width: 120px;">
        <ul id="sideManu" class="nav nav-tabs nav-stacked">
            <li class="subMenu open"><a> 단계별</a>
                <ul>
                <li><a class="active" href="BookList.book?bk2=1"><i class="icon-chevron-right"></i>1단계 </a></li>
                <li><a href="BookList.book?bk2=2"><i class="icon-chevron-right"></i>2단계</a></li>
                <li><a href="BookList.book?bk2=3"><i class="icon-chevron-right"></i>3단계</a></li>
                </ul>
            </li>
            <li class="subMenu"><a> 분야별 </a>
            <ul style="display:none">
                <li><a href="BookList.book"><i class="icon-chevron-right"></i>JAVA</a></li>
                <li><a href="BookList.book"><i class="icon-chevron-right"></i>JSP</a></li>                                              
                <li><a href="BookList.book"><i class="icon-chevron-right"></i>DATABASE</a></li> 
                <li><a href="BookList.book"><i class="icon-chevron-right"></i>HTML / CSS</a></li>
            </ul>
            </li>
        </ul>
        <br/>
    </div>
<!-- Sidebar end=============================================== -->
	<div class="span9">
    <ul class="breadcrumb">
		<li><a href="index.jsp">Home</a> <span class="divider">/</span></li>
		<li class="active"> SHOPPING CART</li>
    </ul>
	<h3>  SHOPPING CART [ <small>${cartList.size()} Item(s) </small>]<a href="products.html" class="btn btn-large pull-right"><i class="icon-arrow-left"></i> Continue Shopping </a></h3>	
	<hr class="soft"/>
	
    <form class="form-horizontal" action="BookBuy.book" method="post">
    	<!-- 상품목록 보여주는 테이블 -->
		<table class="table table-bordered">
             <thead>
               <tr>
                 <th style="width: 70px;"><input type="checkbox" onclick="checkAll(this)">&nbsp;전체선택</th>
                 <th>상품</th>
                 <th>상품명</th>
                 <th>수량변경</th>
			  	 <th>가격</th>
                 <th>총가격</th>
			</tr>
             </thead>
             <tbody>
             <c:forEach var="cart" items="${cartList }" varStatus="status">         	      	
               <tr>
                 <td><input type="checkbox" class="checklist" name="cartNumList" value="${cart.cartNum }" checked="checked"></td>
                 <td> <img width="60" src="./upload/${cart.bookImage }" alt="상품이미지"/></td>
                 <td>${cart.bookTitle}</td>
			  <td>
				<div class="input-append">
					<input class="span1" style="max-width:34px;" value="${cart.bookEA }" size="16" type="text" required="required" id="qty<c:out value="${status.index}"/>"
					onkeypress="inNumber(this)" onkeyup="javascript:qtyChange(this.value,this,${cart.cartNum})">
					<button class="btn" type="button" onclick="qtyChange(${cart.bookEA },'minus', ${cart.cartNum})"><i class="icon-minus"></i></button>
					<button class="btn" type="button" onclick="qtyChange(${cart.bookEA },'plus', ${cart.cartNum})"><i class="icon-plus"></i></button>
					<button class="btn btn-danger" type="button" onclick="qtyRemove(${cart.cartNum })"><i class="icon-remove icon-white"></i></button>				
				</div>
			  </td>
                 <td>${cart.bookPrice}</td>
                 <td>${cart.bookPrice * cart.bookEA }</td>
               </tr>
             </c:forEach>  
			</tbody>
         </table>
		
			
		<!-- 결제 정보 테이블 -->	
		<table class="table table-bordered">
		 <tr><th>결제예정금액 </th></tr>
		 <tr> 
		 <td>
		   <div class="control-group">
			 <label class="control-label">총 상품금액 </label>
			 <div class="controls">
			   <input type="text" name="totalPrice" value="${totalPrice }" readonly="readonly">
			 </div>
		   </div>
		   <div class="control-group">
			 <label class="control-label">배송비 </label>
			 <div class="controls">
			   <c:choose>
			  	 <c:when test="${totalPrice >= 50000}">
					  	   <input type="text" name="shipPrice" value="0" readonly="readonly">
					   	  <c:set var="FinalPrice" value="${totalPrice }"></c:set>
			  	 </c:when>
			  	 <c:otherwise>
			  	   <input type="text" name="shipPrice" value="2500" readonly="readonly">
			  	   <c:set var="FinalPrice" value="${totalPrice + 2500 }"></c:set>
			  	 </c:otherwise>
			   </c:choose>
			 </div>
		   </div>
		   <div class="control-group">
			 <label class="control-label">최종 결제금액 </label>
			 <div class="controls">
			   <input type="text" name="FinalPrice" value="${FinalPrice }" readonly="readonly">
			 </div>
		   </div>
		 </td>
		 </tr>
          </table>		
             <div class="centerBtn">
               <input type="button" class="btn btn-large" onclick="location.href='Main.me'" value="쇼핑계속하기"> 
	     <input type="submit" class="btn btn-large" value="주문하기">
	   </div> 
   </form>				  
	
</div>
</div></div>
</div>
<!-- MainBody End ============================= -->
<!-- Footer ================================================================== -->
	<div  id="footerSection">
	<div class="container">
		<div class="row">
			<div class="span3">
				<h5>ACCOUNT</h5>
				<a href="login.html">YOUR ACCOUNT</a>
				<a href="login.html">PERSONAL INFORMATION</a> 
				<a href="login.html">ADDRESSES</a> 
				<a href="login.html">DISCOUNT</a>  
				<a href="login.html">ORDER HISTORY</a>
			 </div>
			<div class="span3">
				<h5>INFORMATION</h5>
				<a href="contact.html">CONTACT</a>  
				<a href="register.html">REGISTRATION</a>  
				<a href="legal_notice.html">LEGAL NOTICE</a>  
				<a href="tac.html">TERMS AND CONDITIONS</a> 
				<a href="faq.html">FAQ</a>
			 </div>
			<div class="span3">
				<h5>OUR OFFERS</h5>
				<a href="#">NEW PRODUCTS</a> 
				<a href="#">TOP SELLERS</a>  
				<a href="special_offer.html">SPECIAL OFFERS</a>  
				<a href="#">MANUFACTURERS</a> 
				<a href="#">SUPPLIERS</a> 
			 </div>
			<div id="socialMedia" class="span3 pull-right">
				<h5>SOCIAL MEDIA </h5>
				<a href="#"><img width="60" height="60" src="themes/images/facebook.png" title="facebook" alt="facebook"/></a>
				<a href="#"><img width="60" height="60" src="themes/images/twitter.png" title="twitter" alt="twitter"/></a>
				<a href="#"><img width="60" height="60" src="themes/images/youtube.png" title="youtube" alt="youtube"/></a>
			 </div> 
		 </div>
		<p class="pull-right">&copy; Bootshop</p>
	</div><!-- Container End -->
	</div>
<!-- Placed at the end of the document so the pages load faster ============================================= -->
	<script src="themes/js/jquery.js" type="text/javascript"></script>
	<script src="themes/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="themes/js/google-code-prettify/prettify.js"></script>
	
	<script src="themes/js/bootshop.js"></script>
    <script src="themes/js/jquery.lightbox-0.5.js"></script>
	
	<!-- Themes switcher section ============================================================================================= -->

</body>
</html>