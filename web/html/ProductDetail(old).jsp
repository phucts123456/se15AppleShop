<%-- 
    Document   : ProductDetail
    Created on : May 29, 2021, 6:23:15 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/mainP.css">
        <link rel="stylesheet" href="css/mainHoang.css">
        <link rel="stylesheet" href="css/base.css">
        <link rel="stylesheet" href="css/carticon.css">
        <link rel="stylesheet" href="css/cartListIcon.css">
        <link href="fonts/fontawesome-free-5.15.3-web/css/all.css" rel="stylesheet">
        <meta name="viewport" content="width=device-width, initial-scale=1">
         <script type="text/javascript" src="js/main.js"></script>
         
         <% 
          String uri = request.getRequestURI();
          int lastIndex = uri.lastIndexOf("/");
            String resource = uri.substring(lastIndex + 1);
        %>
        <title>Product Detail</title>
    </head>
    <body>
        <div class="page__product-detail">
            <header>
                 <div class="shop-logo">
                    <a href="Homepage.jsp" class="home-link" style="display: inline-block;">
                        <section class="header_item" id="shopLogo">
                            <h1><i class="fab fa-apple fa-2x"></i> SE15 Apple Store</h1>
                        </section>
                    </a>
                </div>
    
                <div class="login">
                    <ul class="header_item_list">
                        <!-- If user logged in suscessfully , the item below wil showup and hide item other li item  -->
                        <c:if test="${sessionScope.user != null }">
                        <li class="header_item header__navbar-user">
                                <span class="header_item_user-name">Hello,${sessionScope.user.name}</span>
                                <ul class="header__navbar-user--menu">
                                    <li class="header__navbar-user--item">
                                         <a href="UserDetailController?userid=${sessionScope.user.userID}">User detail</a>
                                    </li>
                                    
                                    <li class="header__navbar-user--item">
                                        <a href="cartForm.jsp">Order detail</a>
                                    </li>
                                     <li class="header__navbar-user--item">
                                        <a href="OrderHistoryController?userid=${sessionScope.user.userID.trim()}">Order History</a>
                                    </li>
                                     <li class="header__navbar-user--item">
                                        <a href="changePass.jsp">Update Password</a>
                                    </li>
                                    <li class="header__navbar-user--item">
                                        <a href="">Sign out</a>
                                    </li>
                                </ul>
                        </li>
                        </c:if>
                        <c:if test="${sessionScope.user == null }">
                        <li class="header_item">
                            <a href="loginForm.jsp" class="header_item-link">Login</a>
                        </li>
                        <li class="header_item">
                            <a href="signup.jsp" class="header_item-link">Signup</a>
                        </li>
                        </c:if>
                        
                        
                    </ul>
    
                </div> 
            </header>
                 <div class="nav">
                <div class="topnav">
                    <div class="product-page">
                        <a class="product-link" href="ViewProductController?categoryID=&status=True" class="header-nav__item-active">All</a>
                        <a class="product-link" href="ViewProductController?categoryID=MB&status=True">Mac</a>
                        <a class="product-link" href="ViewProductController?categoryID=ID&status=True">iPad</a>
                        <a class="product-link" href="ViewProductController?categoryID=IP&status=True">iPhone</a>
                        <a class="product-link" href="ViewProductController?categoryID=AW&status=True">Apple Watch</a>
                        <a class="product-link" href="ViewProductController?categoryID=AS&status=True">Accessories</a>
                    </div>
                    <div class="responsive-div" style="display: flex;">
                        <div class=" search-container">
                            <form action="" class="search-form">
                                <input type="text" placeholder="Search.." name="search">
                                <button type="submit"><i class="fa fa-search"></i></button>
                            </form>
                        </div>

                        <div class=" cart">
                            
                            <a class="cart-view" href="MainController?action=ViewCart">
                                <i class="carft-icon fas fa-shopping-cart"></i>
                                <c:forEach var="cartItem" items="${sessionScope.cart}">
                                    <c:set var="subtotalCount" value="${cartItem.quantity}"/>
                                    <c:set var="subtotal" value="${subtotal+cartItem.quantity}"/>
                                </c:forEach>
                                <span class="cart-items">${subtotal}</span>
                            
                            </a>
                            <c:choose>
                                <c:when test="${sessionScope.cart == null}">
                                     <div class="header__cart-list header__cart-list--no-cart">

                                         <img src="images/no-cart.png" alt="" class="header___cart--no-cart---img">
                                         <span class="header__cart-list--no-cart-msg">Empty Cart</span>

                                     </div>     
                                </c:when>
                                <c:otherwise>
                                    <div class="header__cart-list">                                                              
                                        <header class="header__cart-heading">
                                            <h4 >View cart</h4>
                                        </header>
                                        <ul class="header__cart-list--item">
                                            <c:forEach var="cartItem" items="${sessionScope.cart}">
                                                <li class="header__cart-item">
                                                    <img src="${cartItem.product.image}" alt="" class="header__cart-img">
                                                    <div class="header__cart-item--info">
                                                        <div class="header__cart-item--head">
                                                            <h5 class="header__cart-item--name">
                                                                ${cartItem.product.name}
                                                            </h5>
                                                            <div class="header__cart-item-price--wrap">
                                                            <span class="header__cart-item--price"><fmt:formatNumber type="number" maxFractionDigits = "0" value="${cartItem.product.price}"/>VND</span>
                                                            <span class="header__cart-item--multiplication">x</span>
                                                            <span class="header__cart-item--quantity">${cartItem.quantity}</span>
                                                            </div>
                                                        </div>
                                                        <div class="header__cart-item--body">
                                                            <span class="header__cart-item--description">
                                                                color:${cartItem.product.color} | ram-storage:${cartItem.product.ram}-${cartItem.product.storage}
                                                            </span>
                                                            <span class="header__cart-item--remove"><a 
                                                                    href="MainController?action=RemoveCart&page=<%=resource%>&productID=${cartItem.product.productID.trim()}&color=${cartItem.product.color.trim()}&ram=${cartItem.product.ram.trim()}&storage=${cartItem.product.storage.trim()}"
                                                            style="color:black;text-align: right;
                                                            padding:0;height: 20px;">Remove</a></span>
                                                        </div>
                                                    </div>
                                                                    
                                                </li>
                                            </c:forEach> 
                                        </ul>
                                        <a class="header__cart-view-cart btn btn__primary" href="MainController?action=ViewCart" style="background-color: #DDDDDD;color:black">View detail</a>
                                    </div> 
                                </c:otherwise>  
                        </c:choose>
                        </div>
                    </div>
                    
    
                </div>
            </div>
            <div class="page__product-detail__body">
                <div class="product-detail">
                    <div class="grid__row">
                        <div class="grid__column-6 product__left-info">
                            <div class="img__product-container">
                                <img class="img__product" src="${requestScope.product.image}" alt="iphone12">
                            </div>  
                        </div>
                        <div class="grid__column-6 product__right-info">
                            
                            <form  action="MainController" class="form-option" method="POST">  
                                <input type="text" name="productID" value="${requestScope.product.productID}" hidden>
                                <div class="info__product">
                                    <h4 class="tittle__product">${requestScope.product.name}</h4>
                                    <div class="color__product-option">
                                        <div class="color-option__container">
                                            
                                            <c:set var="i" value="1" scope="page"/>
                                            <c:forEach var="color" items="${requestScope.color}">
                                            <div class="option-color">
                                                <c:if test = "${color.color == requestScope.colorChosen}">
                                                    <input onClick="window.location = 'MainController?action=ProductDetail&productID=${product.productID.trim()}&color=${color.color}';" type="radio" class="input__radio-color" id="color-${i}" name="color" value="${color.color}" checked required>
                                                </c:if>
                                                <c:if test = "${color.color != requestScope.colorChosen}">
                                                    <input onClick="window.location = 'MainController?action=ProductDetail&productID=${product.productID.trim()}&color=${color.color}';" type="radio" class="input__radio-color" id="color-${i}" name="color" value="${color.color}" required>
                                                </c:if>
                                              
                                                <label class="label-color" for="color-${i}" >
                                                    <span class="img-span" style="background-color: ${color.color}" >
                                                        <i class="icon-check fas fa-check"></i>                                               
                                                    </span>
                                                </label>
                                                <c:set var="i" value="${i + 1}" scope="page"/>
                                            </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    
                                        <div class="list-hardware-option" >       
                                            <c:set var="i" value="1" scope="page"/>
                                            <c:forEach var="spec" items="${requestScope.spec}">
                                            <div class="hardware-item " >
                                                <c:if test = "${i == 1}">
                                                    <input class="input__radio-hardware" type="radio" name="hardware" id="hardware__option-${i}" value="${spec.ram}-${spec.storage}" checked required>
                                                </c:if>
                                                <c:if test = "${i != 1}">
                                                    <input class="input__radio-hardware" type="radio" name="hardware" id="hardware__option-${i}" value="${spec.ram}-${spec.storage}" required>
                                                </c:if>
                                                <label class="hardware__lable" for="hardware__option-${i}">
                                                    <span class="hardwar__span"><p>${spec.ram.trim()}-${spec.storage.trim()}
                                                            <br><strong><fmt:formatNumber type="number" maxFractionDigits = "0" value="${spec.price}" /> VND</strong></p></span>
                                                </label>
                                                <c:set var="i" value="${i + 1}" scope="page"/>
                                            </div>
                                            </c:forEach>
                                </div>
                                <div class="form-submit__container">
                                    <input type="submit" class="input__submit" name="action" value="Add to cart" style="font-size: 1.6rem;font-weight: 500;">
                                    <input type="submit" class="input__submit" name="action" value="Buy Now" style="font-size: 1.6rem;font-weight: 500;">
                                </div>
                            </form> 
                        </div>
                    </div>
                </div>                        
                <div class="container__description">
                    <h3 class="description__tittle">Description</h3>
                        <input id="ch" type="checkbox" onchange="textResize()" >
                        <label  for="ch" id="la"></label>   
                        <textarea class="input-des" id="input-des" readonly>
                                    ${requestScope.product.description}
                        </textarea>                  
                </div>
                <div class="container__review">
                    <h3 class="review__tittle">Comment</h3>
                    <span class="btn__edit-comment"><a href="youtube.com" style="text-decoration: none;color: var(--black-color);">
                            Edit mode</a></span>
                    <div class="form-comment__container">
                        <form action="MainController" class="form-review">
                            <lable for="reviewer-name" class="name-lable">Full Name</lable>
                            <input placeholder="Input your Name" type="text" id="reviewer-name" class="cName" name="reviewer-name">
                            <lable for="pComment" class="comment-lable">Comment</lable>
                            <textarea type="text"class="pComment" id="pComment" name="pComment" placeholder="Input detail your comment"></textarea>
                            <input type="hidden" name="productID" value="${requestScope.product.productID}"/>
                            <input type="submit" name="action" class="input__comment-submit" value="Submit comment">
                        </form>
                     </div>
                    <div class="review-list">
                        <div review-item__container>
                            <div class="reivew-row">
                                <span class="review__reviewer-name">
                                    Khach hang
                                </span>
                                <p class="review__reviewer-comment">
                                    Cho m??nh h??i Galaxy A51 ???? s??? d???ng h??n 1 n??m, 
                                    shop c?? xem x??t ??p d???ng ch????ng tr??nh tr??? gi?? ?????i 
                                    qua IP 12 b???n 256GB kh??ng ???? v?? c?? ??p d???ng th??m ch????ng 
                                    tr??nh tr??? g??p qua th??? t??n d???ng c???a HSBC kh??ng ???? v?? k?? h???n h???
                                    tr??? t???i ??a l?? bao nhi??u? m??nh c???m ??n shope.
                                </p>
                            </div>
                            <ul class="review-option">
                                <li class="review-option__item">Hide</li> 
                                <li class="review-option__item" 
                                    onclick="replybutton(this)">
                                    Reply
                                </li>
                                <form method="POST" class="reply-form d-none" id="comment-1-reply-form">
                                    <textarea class="input-reply" placeholder="Reply to comment" rows="4"></textarea>
                                    <button class="reply-submit" type="submit">Submit</button>
                                    <button type="button" onclick="closeForm(this)">Cancel</button>
                                </form>
                            </ul>
                            
                            
                            <div id ="reply-1" class="reply-item__container">
                                    <div class="reivew-row">
                                       <span class="review__reviewer-name">
                                           Customer
                                       </span>
                                       <p class="review__reviewer-comment">
                                        CellphoneS xin cha??o anh Huy??nh Thanh Bi??nh,
                                        Da?? tr??????ng h????p SAMSUNG GALAXY A51 6GB 128GB cu??a mi??nh ti??nh tra??ng ma??y co??n ??e??p, ca??c ch????c n??ng hoa??t ??????ng t????t, ma??n hi??nh ??e??p, CellphoneS h???? tr???? thu la??i khoa??ng 3.200.000 (co?? tr???? gia?? l??n ??????i iphone 12). Sau ??o?? mi??nh bu?? ch??nh l????ch ?????? ??????i l??n ??????i iphone 12. N????u ??u??ng hi??nh th????c, ch????c n??ng ma??y kh??ng l????i se?? ????????c nh????p la??i v????i m????c gia?? nh?? tr??n. Em m????i mi??nh ??????n c????a ha??ng ?????? ky?? thu????t vi??n th????m ??i??nh ma??y cho mi??nh nhe??.
                                        Da??, APPLE IPHONE 12 256GB ??EN CH??NH H??NG (VN/A) gia?? th????i ??i????m hi????n ta??i 25.000.000. Ky?? ha??n 12 tha??ng nhe?? a??.
                                        ????y chi?? la?? ba??ng ti??nh tham kha??o, anh vui lo??ng ra c????a ha??ng g????n nh????t ?????? bi????t th??ng tin chi??nh xa??c a??.
                                        S??? TI???N MUA TR??? G??P : 25.000.000
                                        NG??N H??NG : HSBC
                                        K??? H???N ( Th??ng ) : 12
                                        T???NG PH?? CHUY???N ?????I TR??? G??P: 1.500.000 ??
                                        PH?? M???I TH??NG : ( 1 ) 125.000 ??
                                        TI???N M??Y G??P M???I TH??NG : ( 2 ) 2.084.000
                                        T???NG TI???N G??P M???I TH??NG : (1) + (2) 2.209.000 ??
                                        T???NG TI???N MUA TR??? G??P : 26.500.000 ??
                                       </p>
                                   </div>
                                   <ul class="review-option">
                                       <li class="review-option__item">Hide</li> 
                                       <li class="review-option__item"
                                           onclick="replybutton(this)">Reply
                                       </li>
                                       <form method="POST" class="reply-form d-none" id="comment-1-reply-form">
                                            <textarea class="input-reply" placeholder="Reply to comment" rows="4"></textarea>
                                            <button class="reply-submit" type="submit">Submit</button>
                                            <button type="button" onclick="closeForm(this)" >Cancel</button>
                                        </form>
                                   </ul>
                                
                            </div>
                        </div>
                       <div review-item__container>
                            <li class="reivew-row">
                                <span class="review__reviewer-name">
                                    Thang anh 69
                                </span>
                                <p class="review__reviewer-comment">
                                        Ng??nh IT Vi???t Nam hi???n nay ??? ?????u c???a s??? ph??t tri???n. C?? th??? n??i IT l?? vua
                                    c???a c??c ngh???. V???a c?? ti???n, c?? quy???n. V???a ki???m ???????c nhi???u $ l???i ???????c x?? h???i
                                    tr???ng v???ng.
                                        Th???ng em m??nh h???c b??ch khoa c?? kh??, sinh n??m 96. T??? m??y m?? h???c code 
                                    r???i ??i l??m remote cho c??ng ty M??? 2 n??m nay.
                                    M???i t???i online 3-4 gi??? l?? xong vi???c. L????ng th??ng 3k6. 
                                    Nh??ng thu nh???p ch??nh v???n l?? t??? nh???n c??c project b??n ngo??i l??m th??m. 
                                    Tu???n l??m 2,3 c??i nh??? nh??ng 9,10k ti???n t????i th??c th???t kh??ng ph???i ????ng thu???. 
                                    L??m g???n ???????c 3 n??m m?? nh?? xe n?? ???? mua ????? c???. Ngh?? m?? th??m.
                                </p>
                            </li>
                            <ul class="review-option">
                                <li class="review-option__item">Hide</li> 
                                <li class="review-option__item"
                                    onclick="replybutton(this)">Reply
                                </li>
                                <form method="POST" class="reply-form d-none" id="comment-1-reply-form">
                                    <textarea class="input-reply" placeholder="Reply to comment" rows="4"></textarea>
                                    <button class="reply-submit" type="submit">Submit</button>
                                    <button type="button" onclick="closeForm(this)" >Cancel</button>
                                </form>
                            </ul>
                            
                             <div id ="reply-1" class="reply-item__container">
                                <li class="reivew-row">
                                    <span class="review__reviewer-name">
                                        Netizen
                                    </span>
                                    <p class="review__reviewer-comment">
                                       Tru???t
                                    </p>
                                </li>
                                <ul class="review-option">
                                    <li class="review-option__item">Hide</li>       
                                    <li class="review-option__item"
                                        onclick="replybutton(this)">Reply
                                    </li>
                                    <form method="POST" class="reply-form d-none" id="comment-1-reply-form">
                                    <textarea class="input-reply" placeholder="Reply to comment" rows="4"></textarea>
                                    <button class="reply-submit" type="submit">Submit</button>
                                    <button type="button" onclick="closeForm(this)" >Cancel</button>
                                    </form>
                                </ul>
                                
                            </div>
                            <div id ="reply-2" class="reply-item__container">
                                <li class="reivew-row">
                                    <span class="review__reviewer-name">
                                        Netizen
                                    </span>
                                    <p class="review__reviewer-comment">
                                       Th??i th??i m ?????ng c?? m?? b???c ph??t
                                    </p>
                                </li>
                                <ul class="review-option">
                                    <li class="review-option__item">Hide</li>     
                                    <li class="review-option__item"
                                        onclick="replybutton(this)">Reply
                                    </li>
                                    <form method="POST" class="reply-form d-none" id="comment-1-reply-form">
                                    <textarea class="input-reply" placeholder="Reply to comment" rows="4"></textarea>
                                    <button class="reply-submit" type="submit">Submit</button>
                                    <button type="button" onclick="closeForm(this)" >Cancel</button>
                                    </form>
                                </ul>
                                
                            </div>
                        </div>
                    </div>
                </div>
        </div> 
            <footer>
                <div class="grid footer-border">
                        
                    <h2 class="foot-tittle">Contact us</h2>
                    <div class="foot-info">    
                        <div class="foot-left-info">
                            <div class="foot-left-info__mail">
                                <i class="fas fa-envelope"></i>
                                <span class="foot-left-info__mail-addres">SE15AppleStore@gmail.com</span>
                            </div>
                            <div class="foot-left-info__phonenumber">
                                <i class="fas fa-phone-square-alt"></i>
                                <span class="foot-left-info__phonenumber-number">0839440343</span>
                            </div>
                            <div class="foot-left-info__shop-address">
                                <i class="fas fa-map-marker-alt"></i>
                                <span class="foot-left-info__shop-address-text">Cupertino, California,America</span>
                            </div>
                        </div>
                        <div class="foot-right-info">
                            <div class="foot-right-info__apple-icon"><i class="fab fa-apple"></i></div>
                            <div class="foot-right-info__link">
                                <div class="foot-right-info__product">
                                    <a href="" class="foot-right-info__product-link">Iphone</a>
                                    <a href="" class="foot-right-info__product-link">Ipad</a>
                                    <a href="" class="foot-right-info__product-link">Mac</a>
                                    <a href="" class="foot-right-info__product-link">Others</a>
                            </div>
                            <div class="foot-right-info__policy">
                                    <a href="" class="foot-right-info__policy-link">Privacy Policies</a>
                                    <a href="" class="foot-right-info__policy-link">Sale and refund</a>
                            </div>
                            </div>
                        </div>      
                    </div>
                </div>
            </footer>
        </div>
        </div>                 
    </body>
    <script>
        function textResize() {
        var elmnt = document.getElementById("input-des");
        var y = elmnt.scrollHeight;
        var x = elmnt.scrollWidth;
        var height = (y-50)+"px";
        if(document.getElementById("ch").checked) {
            
            elmnt.style.height = height;   
        }
        else{
            elmnt.style.height = "200px" ;
        }
      }
    function replybutton(btn){
        
        btn.nextElementSibling.style.display = "block";
        
    }
    function closeForm(btn){
        btn.parentElement.style.display="none";
    }
      </script>
</html>    