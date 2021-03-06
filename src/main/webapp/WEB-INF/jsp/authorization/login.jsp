<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false"%>


<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>

<html>
<head>
    <title><fmt:message key="login"/></title>
    <jsp:include page="../includes/headers.jsp"/>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>
<jsp:include page="../includes/navbar.jsp"/>
<div class="container mt-5">
    <form class="form-inline ml-4  float-right" action="/register" method="get">
        <button class="btn btn-outline-success btn-sm my-2 my-sm-0" type="submit"><fmt:message key="addNewUser"/></button>
    </form>
    <br>

    <c:if test="${message != null}">
        <div class="alert alert-success" role="alert">
            <fmt:message key="${message}"/>
        </div>
    </c:if>
    <c:if test="${error != null}">
        <div class="alert alert-danger" role="alert">
            <fmt:message key="${error}"/>
        </div>
    </c:if>


    <form action="/login" method="post">
        <div class="form-group">
            <label for="exampleInputEmail1"><fmt:message key="emailAddress"/></label>
            <input type="email" class="form-control" required id="exampleInputEmail1" name="email"
                   aria-describedby="emailHelp" placeholder="<fmt:message key="enterEmail"/>">
        </div>
        <div class="form-group">
            <label for="exampleInputPassword1"><fmt:message key="password"/> </label>
            <input type="password" class="form-control" required id="exampleInputPassword1" name="password"
                   placeholder="<fmt:message key="enterPassword"/>">
        </div>
        <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="check" name="rememberMe">
            <label class="form-check-label" for="check"><fmt:message key="rememberMe"/></label>
        </div>
        <div class="g-recaptcha" data-sitekey="6Le077sZAAAAAIeMmf4scOUpty-44ymjx8yMb39t"></div>
        <br>
        <div class="col-sm-6 mt-3">
            <button type="submit" class="btn btn-primary"><fmt:message key="login"/> </button>
        </div>
    </form>

</div>
</body>
</html>

