<%@ page import="com.shans.kaluhin.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<%User user = (User) request.getSession(false).getAttribute("user");%>

<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>

<html>
<head>
    <title><fmt:message key="editProfile"/></title>
    <jsp:include page="../includes/headers.jsp"/>
</head>
<body>

<jsp:include page="../includes/navbar.jsp"/>
<div class="container mt-5">
    <h4><fmt:message key="editProfile"/></h4>
    <br>

    <div class="form-group">
        <label for="password"><fmt:message key="changePassword"/>: </label>
        <br>
        <button type="button" class="btn btn-outline-success" data-toggle="collapse" data-target="#Collapse"
                id="password">
            <fmt:message key="password"/>
        </button>
        <br>

        <div class="collapse ${show}"
             id="Collapse">
            <div class="card card-body">
                <c:if test="${error != null}">
                    <div class="alert alert-danger" role="alert">
                        <fmt:message key="${error}"/>
                    </div>
                </c:if>
                <form method="post" action="edit/password">
                    <div class="form-group">
                        <label for="Input">Old password</label>
                        <input type="text" class="form-control" id="Input" placeholder="Old password" name="old">
                    </div>
                    <div class="form-group">
                        <label for="Input2">New password</label>
                        <input type="text" class="form-control" id="Input2" placeholder="New password" name="new">
                    </div>
                    <div class="form-group">
                        <label for="Input3">Repeat password</label>
                        <input type="text" class="form-control" id="Input3" placeholder="Repeat password" name="repeat">
                    </div>
                    <div class="col-sm-6 mt-3">
                        <button type="submit" class="btn btn-primary"><fmt:message key="save"/></button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <form class="md-form" action="/profile" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="photo"><fmt:message key="changePhoto"/>: </label>
            <br>
            <input type="file" name="photo" id="photo">
        </div>

        <div class="form-group">
            <label for="InputEmail"><fmt:message key="email"/></label>
            <input type="email" class="form-control" id="InputEmail" name="email"
                   value="<%=user.getEmail()%>">
        </div>

        <div class="form-group">
            <label for="name"><fmt:message key="name"/></label>
            <input type="text" class="form-control" id="name" name="name"
                   value="<%=user.getName()%>">
        </div>
        <div class="form-group">
            <label for="lastName"><fmt:message key="surname"/></label>
            <input type="text" class="form-control" id="lastName" name="lastName"
                   value="<%=user.getLastName()%>">
        </div>
        <br>
        <div class="col-sm-6 mt-3">
            <button type="submit" class="btn btn-primary"><fmt:message key="save"/></button>
        </div>
    </form>
</div>
</body>
</html>
