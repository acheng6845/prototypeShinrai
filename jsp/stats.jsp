<%--
  Created by IntelliJ IDEA.
  User: Aaron
  Date: 4/27/2016
  Time: 7:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Monster.MonsterBean" %>
<%@ page import="Monster.LeaderSkillBean" %>
<%@ page import="java.net.URLDecoder" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>View Stats</title>

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
                    data-target="#collapse-header">
                <span class="sr-only">Toggle Navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">PaDHelper</a>
        </div>
        <div class="navbar-collapse collapse" id="collapse-header">
            <ul class="nav navbar-nav" id="nav-buttons">
                <% if (session.getAttribute("verifiedLogin") == null) { %>
                <li><a href="/pad/register" class="btn btn-primary"><span class="glyphicon glyphicon-user"></span>
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
                <li class="active"><a href="#">View Stats</a></li>
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

<%
    MonsterBean[] team = (MonsterBean[]) session.getAttribute("team");
    int[] hp = new int[6];
    int[] atk = new int[6];
    int[] rcv = new int[6];
    String[] name = new String[6];
    String[] mattr = new String[6];
    String[] sattr = new String[6];
    String[] ftype = new String[6];
    String[] stype = new String[6];
    String[] ttype = new String[6];
    String[] type = new String[6];
    String[] attr = new String[6];

    int hp_total = 0;
    int rcv_total = 0;
    double fire_atk_total = 0;
    double water_atk_total = 0;
    double wood_atk_total = 0;
    double light_atk_total = 0;
    double dark_atk_total = 0;

    for (int i = 0; i < 6; i++) {
        name[i] = team[i].getName();
        hp[i] = team[i].getHP();
        atk[i] = team[i].getATK();
        rcv[i] = team[i].getRCV();
        mattr[i] = team[i].getMainAttribute();
        sattr[i] = team[i].getSubAttribute();
        ftype[i] = team[i].getFirstType();
        stype[i] = team[i].getSecondType();
        ttype[i] = team[i].getThirdType();
    }
    for (int i = 0; i < 6; i++) {
        type[i] = ftype[i];
        attr[i] = mattr[i];
        if(stype[i] != null) type[i] += "/"+stype[i];
        if(ttype[i] != null) type[i] += "/"+ttype[i];
        if(sattr[i] != null) {
            attr[i] += "/"+sattr[i];
            if(sattr[i].equals("Fire")) {
                if (mattr[i].equals(sattr[i])) fire_atk_total += (double) (atk[i]) * 0.1;
                else fire_atk_total += (double) (atk[i]) * 0.3;
            }
            else if(sattr[i].equals("Water")) {
                if (mattr[i].equals(sattr[i])) water_atk_total += (double) (atk[i]) * 0.1;
                else water_atk_total += (double) (atk[i]) * 0.3;
            }
            else if(sattr[i].equals("Wood")) {
                if (mattr[i].equals(sattr[i])) wood_atk_total += (double) (atk[i]) * 0.1;
                else wood_atk_total += (double) (atk[i]) * 0.3;
            }
            else if(sattr[i].equals("Light")) {
                if (mattr[i].equals(sattr[i])) light_atk_total += (double) (atk[i]) * 0.1;
                else light_atk_total += (double) (atk[i]) * 0.3;
            }
            else {
                if (mattr[i].equals(sattr[i])) dark_atk_total += (double) (atk[i]) * 0.1;
                else dark_atk_total += (double) (atk[i]) * 0.3;
            }
        }
        hp_total += hp[i];
        rcv_total += rcv[i];
        if(mattr[i].equals("Fire")) fire_atk_total += atk[i];
        else if(mattr[i].equals("Water")) water_atk_total += atk[i];
        else if(mattr[i].equals("Wood")) wood_atk_total += atk[i];
        else if(mattr[i].equals("Light")) light_atk_total += atk[i];
        else dark_atk_total += atk[i];
    }

    LeaderSkillBean leaderSkill1 = (LeaderSkillBean) session.getAttribute("leaderSkill1");
    LeaderSkillBean leaderSkill2 = (LeaderSkillBean) session.getAttribute("leaderSkill2");

%>

<div class="container">
    <div class="table-responsive">
        <table class="table">
            <thead><h2>Individual Stats</h2></thead>
            <tbody>
            <tr class="active" id="imageRow">
                <th></th>
                <td><img class="img-responsive"
                         src=<%=URLDecoder.decode("/pad/images/"+name[0].replace(" ", "")+".png")%> alt="Pic1"></td>
                <td><img class="img-responsive"
                         src=<%=URLDecoder.decode("/pad/images/"+name[1].replace(" ", "")+".png")%> alt="Pic2"></td>
                <td><img class="img-responsive"
                         src=<%=URLDecoder.decode("/pad/images/"+name[2].replace(" ", "")+".png")%> alt="Pic3"></td>
                <td><img class="img-responsive"
                         src=<%=URLDecoder.decode("/pad/images/"+name[3].replace(" ", "")+".png")%> alt="Pic4"></td>
                <td><img class="img-responsive"
                         src=<%=URLDecoder.decode("/pad/images/"+name[4].replace(" ", "")+".png")%> alt="Pic5"></td>
                <td><img class="img-responsive"
                         src=<%=URLDecoder.decode("/pad/images/"+name[5].replace(" ", "")+".png")%> alt="Pic6"></td>
            </tr>
            <!-- <tr class="active">
                <th>Name</th>
                <td><//%= name[0] %></td>
                <td><//%= name[1] %></td>
                <td><//%= name[2] %></td>
                <td><//%= name[3] %></td>
                <td><//%= name[4] %></td>
                <td><//%= name[5] %></td>
            </tr> !-->
            <tr id="typeRow">
                <th>Type</th>
                <td>
                    <img class="img-responsive" alt=<%=type[0]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+ftype[0]+".png")%>>
                    <% if (stype[0] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+stype[0]+".png")%>>
                    <% if (ttype[0] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+ttype[0]+".png")%>>
                    <% }} %>
                </td>
                <td>
                    <img class="img-responsive" alt=<%=type[1]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+ftype[1]+".png")%>>
                    <% if (stype[1] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+stype[1]+".png")%>>
                    <% if (ttype[1] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+ttype[1]+".png")%>>
                    <% }} %>
                </td>
                <td>
                    <img class="img-responsive" alt=<%=type[2]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+ftype[2]+".png")%>>
                    <% if (stype[2] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+stype[2]+".png")%>>
                    <% if (ttype[2] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+ttype[2]+".png")%>>
                    <% }} %>
                </td>
                <td>
                    <img class="img-responsive" alt=<%=type[3]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+ftype[3]+".png")%>>
                    <% if (stype[3] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+stype[3]+".png")%>>
                    <% if (ttype[3] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+ttype[3]+".png")%>>
                    <% }} %>
                </td>
                <td>
                    <img class="img-responsive" alt=<%=type[4]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+ftype[4]+".png")%>>
                    <% if (stype[4] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+stype[4]+".png")%>>
                    <% if (ttype[4] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+ttype[4]+".png")%>>
                    <% }} %>
                </td>
                <td>
                    <img class="img-responsive" alt=<%=type[5]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+ftype[5]+".png")%>>
                    <% if (stype[5] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+stype[5]+".png")%>>
                    <% if (ttype[5] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+ttype[5]+".png")%>>
                    <% }} %>
                </td>
            </tr>
            <tr id="elementRow">
                <th>Element</th>
                <td>
                    <img class="img-responsive" alt=<%=attr[0]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+mattr[0]+".png")%>>
                    <% if (sattr[0] != null) { %>
                        | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+sattr[0]+".png")%>>
                    <% } %>
                </td>
                <td>
                    <img class="img-responsive" alt=<%=attr[1]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+mattr[1]+".png")%>>
                    <% if (sattr[1] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+sattr[1]+".png")%>>
                    <% } %>
                </td>
                <td>
                    <img class="img-responsive" alt=<%=attr[2]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+mattr[2]+".png")%>>
                    <% if (sattr[2] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+sattr[2]+".png")%>>
                    <% } %>
                </td>
                <td>
                    <img class="img-responsive" alt=<%=attr[3]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+mattr[3]+".png")%>>
                    <% if (sattr[3] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+sattr[3]+".png")%>>
                    <% } %>
                </td>
                <td>
                    <img class="img-responsive" alt=<%=attr[4]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+mattr[4]+".png")%>>
                    <% if (sattr[4] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+sattr[4]+".png")%>>
                    <% } %>
                </td>
                <td>
                    <img class="img-responsive" alt=<%=attr[5]%>,
                         src=<%= URLDecoder.decode("/pad/images/icons/"+mattr[5]+".png")%>>
                    <% if (sattr[5] != null) { %>
                    | <img class="img-responsive" src=<%= URLDecoder.decode("/pad/images/icons/"+sattr[5]+".png")%>>
                    <% } %>
                </td>
            </tr>
            <tr>
                <th>Health</th>
                <td><%= hp[0] %></td>
                <td><%= hp[1] %></td>
                <td><%= hp[2] %></td>
                <td><%= hp[3] %></td>
                <td><%= hp[4] %></td>
                <td><%= hp[5] %></td>
            </tr>
            <tr>
                <th>Attack</th>
                <td><%= atk[0] %></td>
                <td><%= atk[1] %></td>
                <td><%= atk[2] %></td>
                <td><%= atk[3] %></td>
                <td><%= atk[4] %></td>
                <td><%= atk[5] %></td>
            </tr>
            <tr>
                <th>Recovery</th>
                <td><%= rcv[0] %></td>
                <td><%= rcv[1] %></td>
                <td><%= rcv[2] %></td>
                <td><%= rcv[3] %></td>
                <td><%= rcv[4] %></td>
                <td><%= rcv[5] %></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="container">
    <div class="table-responsive">
        <table class="table" id="teamStatsTable">
            <thead><h2>Team Stats</h2></thead>
            <tbody>
            <tr class="active">
                <th>Health</th>
                <th>Recovery</th>
            </tr>
            <tr>
                <td id="healthTotal"><%= hp_total %></td>
                <td id="rcvTotal"><%= rcv_total %></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="container">
    <div class="table-responsive">
        <table class="table" id="teamDamageTable">
            <thead><h2>Damage By Element</h2></thead>
            <tbody>
            <tr>
                <th class="danger">Fire</th>
                <th class="info">Water</th>
                <th class="success">Wood</th>
                <th class="warning">Light</th>
                <th bgcolor="#dda0dd">Dark</th>
                <th>Total</th>
            </tr>
            <tr>
                <td class="danger" id="fireAtkTotal"><%= (int)fire_atk_total %></td>
                <td class="info" id="waterAtkTotal"><%= (int)water_atk_total %></td>
                <td class="success" id="woodAtkTotal"><%= (int)wood_atk_total %></td>
                <td class="warning" id="lightAtkTotal"><%= (int)light_atk_total %></td>
                <td bgcolor="#dda0dd" id="darkAtkTotal"><%= (int)dark_atk_total %></td>
                <td id="atkTotal">
                    <%= (int)(fire_atk_total+water_atk_total+wood_atk_total+light_atk_total+dark_atk_total) %>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="container">
    <div class="table-responsive">
        <table class="table" id="teamLeaderSkills">
            <thead><h2>Leader Skills</h2></thead>
            <tbody>
            <tr>
                <th>Your Leader Skill</th>
                <th>Ally's Leader Skill</th>
            </tr>
            <tr>
                <td><%=leaderSkill1.getLeaderSkillName()%></td>
                <td><%=leaderSkill2.getLeaderSkillName()%></td>
            </tr>
            <tr>
                <td><a href="#leaderSkill1" data-toggle="modal"><%=leaderSkill1.getLeaderSkillDescr()%></a></td>
                <td><a href="#leaderSkill2" data-toggle="modal"><%=leaderSkill2.getLeaderSkillDescr()%></a></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="navbar navbar-default navbar-fixed-bottom" role="navigation">
    <div class="container">
        <div class="navbar-collapse collapse" id="collapse-attribute">

        </div>
    </div>
</div>
<div class="navbar navbar-inverse navbar-fixed-bottom" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#collapse-footer">
                <span class="sr-only">Toggle Navigation</span>
                <span class="glyphicon glyphicon-cog"></span>
            </button>
            <a class="navbar-brand" href="#">Settings</a>
        </div>
        <div class="navbar-collapse collapse" id="collapse-footer">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropup">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
                       aria-expanded="false">Set HP%<span class="glyphicon glyphicon-triangle-top"></span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <div class="row">
                                <div class="col-sm-offset-1 col-sm-7">
                                    Health %<br />
                                    <span class="glyphicon glyphicon-heart"></span>:
                                    <input type="text" id="hpValue" value="" size="1">
                                </div>
                                <div class="col-sm-2">
                                    <div id="hpSlider" style="height:100px;"></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </li>
                <li class="dropup">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">SetCombo#
                        <span class="glyphicon glyphicon-triangle-top"></span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <div class="row">
                                <div class="col-sm-offset-1 col-sm-7">
                                    Combo #<br />
                                    <span class="glyphicon glyphicon-scale"></span>:
                                    <input type="text" id="comboCount" value="" size="1">
                                </div>
                                <div class="col-sm-2">
                                    <div id="comboSlider" style="height:100px;"></div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </li>
                <li class="dropup">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">Toggle Attributes
                        <span class="glyphicon glyphicon-triangle-top"></span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <button type="button" class="btn btn-danger" data-toggle="button" aria-pressed="false"
                                    autocomplete="off" id="fire-toggle">Fire</button>
                        </li>
                        <li>
                            <button type="button" class="btn btn-info" data-toggle="button" aria-pressed="false"
                                    autocomplete="off" id="water-toggle">Water</button>
                        </li>
                        <li>
                            <button type="button" class="btn btn-success" data-toggle="button" aria-pressed="false"
                                    autocomplete="off" id="wood-toggle">Wood</button>
                        </li>
                        <li>
                            <button type="button" class="btn btn-warning" data-toggle="button" aria-pressed="false"
                                    autocomplete="off" id="light-toggle">Light</button>
                        </li>
                        <li>
                            <button type="button" class="btn btn-primary" data-toggle="button" aria-pressed="false"
                                    autocomplete="off" id="dark-toggle">Dark</button>
                        </li>
                        <li>
                            <button type="button" class="btn btn-default" data-toggle="button" aria-pressed="false"
                                    autocomplete="off" id="heart-toggle">Heart</button>
                        </li>
                        <li>
                            <button type="button" class="btn btn-default" data-toggle="button" aria-pressed="false"
                                    autocomplete="off" id="jammer-toggle">Jammer</button>
                        </li>
                        <li>
                            <button type="button" class="btn btn-default" data-toggle="button" aria-pressed="false"
                                    autocomplete="off" id="poison-toggle">Poison</button>
                        </li>
                    </ul>
                </li>
                <li>
                    <button type="button" class="btn btn-warning" data-toggle="ls1toggle" aria-pressed="false"
                            autocomplete="off" id="leader1toggle">Toggle Your LS</button>
                </li>
                <li>
                    <button type="button" class="btn btn-warning" data-toggle="ls2toggle" aria-pressed="false"
                            autocomplete="off" id="leader2toggle">Toggle Ally's LS</button>
                </li>
            </ul>
        </div>
    </div>
</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<div class="modal fade" id="leaderSkill1" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Your Leader Skill</h2>
            </div>
            <div class="modal-body">
                <%=leaderSkill1.getLeaderSkillDescr()%>
            </div>
            <div class="modal-footer">
                <a class="btn btn-primary" data-dismiss="modal">Close</a>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="leaderSkill2" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Ally's Leader Skill</h2>
            </div>
            <div class="modal-body">
                <%=leaderSkill2.getLeaderSkillDescr()%>
            </div>
            <div class="modal-footer">
                <a class="btn btn-primary" data-dismiss="modal">Close</a>
            </div>
        </div>
    </div>
</div>
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
<script type="text/javascript">
    var leaderSkill1 = <%= session.getAttribute("leaderSkill1")%>;
    var leaderSkill2 = <%= session.getAttribute("leaderSkill2")%>;
    var team = <%= session.getAttribute("team")%>;
</script>
<script src="js/custom.js"></script>
</body>
</html>
