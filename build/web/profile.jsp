<%@page import="com.profile.ProfileBean"%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile Saved</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<div class="form-wrapper">

<%
    ProfileBean profile = (ProfileBean) request.getAttribute("profile");
%>

    <h1>Profile Saved Successfully</h1>
    <p class="form-subtitle">The profile information has been stored in the database.</p>

    <div class="profile-box">
        <p><b>Student ID:</b> <%= profile.getStudentID() %></p>
        <p><b>Name:</b> <%= profile.getName() %></p>
        <p><b>Programme:</b> <%= profile.getProgramme() %></p>
        <p><b>Email:</b> <%= profile.getEmail() %></p>
        <p><b>Hobbies:</b> <%= profile.getHobbies() %></p>
        <p><b>Introduction:</b> <%= profile.getIntroduction() %></p>
    </div>

    <a href="index.html" class="link-button">Add New Profile</a>
    <a href="viewProfiles.jsp" class="link-button">View Profiles</a>

</div>

</body>
</html>
