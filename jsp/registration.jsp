<%--
  Created by IntelliJ IDEA.
  User: Aaron
  Date: 5/9/2016
  Time: 6:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Registration</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/jquery-ui-1.10.3.custom.css" rel="stylesheet">
    <link href="css/custom.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target=".navbar-collapse">
                <span class="sr-only">Toggle Navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">PaDHelper</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav" id="nav-buttons">
                <% if (session.getAttribute("verifiedLogin") == null) { %>
                <li><a href="#" class="btn btn-primary"><span class="glyphicon glyphicon-user"></span>
                    Sign Up</a></li>
                <li><a href="#login" data-toggle="modal" class="btn btn-success">
                    <span class="glyphicon glyphicon-log-in"></span>
                    Login</a></li>
                <% } else { %>
                <li><a href="#" class="btn btn-primary">Welcome, <%=session.getAttribute("userName")%></a></li>
                <li><a href="/pad/logout" class="btn btn-success">Logout</a></li>
                <% } %>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="index.jsp">Home</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Data Book
                        <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li class="dropdown-header">Monsters</li>
                        <li><a href="#">Allies</a></li>
                        <li><a href="#">Enemies</a></li>
                        <li role="separator" class="divider"></li>
                        <li class="dropdown-header">Others</li>
                        <li><a href="#">Dungeons</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Select Team
                        <b class="caret"></b></a></li>
                <li><a href="/pad/stats">View Stats</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tools
                        <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li class="dropdown-header">Calculators</li>
                        <li><a href="#">Min OTK</a></li>
                        <li><a href="#">Survival</a></li>
                        <li role="separator" class="divider"></li>
                        <li class="dropdown-header">Information</li>
                        <li><a href="#">Compare Subs</a></li>
                        <li><a href="#">Dungeon Info</a></li>
                    </ul>
                </li>
                <li><a href="#">Simulator</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="container">
    <% if(session.getAttribute("incorrectUsername") != null) {%>
    <div class="alert alert-danger">
        <strong>Invalid Username and Password Combination!</strong> Please try again.
    </div>
    <% } %>
    <div class="row">
        <div class="col-sm-offset-2">
            <h2>Registration Form</h2>
        </div>
    </div>
    <form class="form-horizontal" role="form" action="register" method="post">
        <div class="form-group">
            <label class="control-label col-sm-2" for="registerName">Username:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" name="registerName" id="registerName" placeholder="Enter Username">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="password1">Password:</label>
            <div class="col-sm-4">
                <input type="password" class="form-control" id="password1" name="password1" placeholder="Enter Password">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="password2">Confirm Password:</label>
            <div class="col-sm-4">
                <input type="password" class="form-control" id="password2" name="password2" placeholder="Enter Password">
            </div>
        </div>
        <div class="row">
            <div class="col-sm-offset-2">
                <div id="checkPassword"></div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-default">Register</button>
            </div>
        </div>
    </form>
</div>

<div class="navbar navbar-inverse navbar-fixed-bottom" role="navigation">
    <div class="container">
        <div class="navbar-text pull-left">
            <p></p>
        </div>
    </div>
</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<div class="modal fade" id="login" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Sign In</h2>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="login" method="post">
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="userName">Username:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="userName" id="userName"
                                   placeholder="Enter Username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="password">Password:</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="Enter password">
                        </div>
                    </div>
                    <div class="col-sm-offset-2 col-sm-10">
                        <div class="checkbox">
                            <label><input type="checkbox"> Remember me</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-default">Login</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <a class="btn btn-primary" data-dismiss="modal">Close</a>
            </div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="js/custom.js"></script>
</body>
</html>
