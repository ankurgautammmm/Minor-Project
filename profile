<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Neon Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500&display=swap" rel="stylesheet">
  <style>
    /* ---------- GLOBAL ---------- */
    * { box-sizing: border-box; margin:0; padding:0; font-family: 'Orbitron', sans-serif; }
    body {
      background: #0f0f15;
      color: #fff;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }
    a { text-decoration: none; color: inherit; }

    /* ---------- NAVBAR ---------- */
    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1rem 2rem;
      background: rgba(255,255,255,0.05);
      backdrop-filter: blur(10px);
      box-shadow: 0 0 10px #0ff;
      position: sticky;
      top:0;
      z-index: 10;
    }
    .navbar .logo { font-size: 1.5rem; color: #0ff; }
    .navbar .nav-links { display: flex; gap: 1rem; }
    .navbar button { 
      padding: 0.5rem 1rem; 
      border: none; 
      border-radius: 10px; 
      background: linear-gradient(45deg, #0ff, #0f0, #0ff); 
      color:#000; 
      cursor:pointer; 
      transition: all 0.3s ease;
    }
    .navbar button:hover { filter: brightness(1.2); }

    /* ---------- AVATAR ---------- */
    .avatar-btn {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      overflow: hidden;
      border: 2px solid #0ff;
      cursor: pointer;
    }
    .avatar-btn img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    /* ---------- DASHBOARD ---------- */
    .dashboard {
      flex:1;
      display:flex;
      justify-content:center;
      align-items:center;
      font-size:2rem;
      color:#0ff;
      text-align:center;
      padding:2rem;
    }

    /* ---------- PROFILE DRAWER ---------- */
    .profile-drawer {
      position: fixed;
      top:0;
      right: -350px;
      width: 350px;
      height: 100%;
      background: rgba(20,20,30,0.95);
      backdrop-filter: blur(15px);
      box-shadow: -5px 0 20px #0ff;
      padding: 2rem;
      transition: right 0.3s ease;
      display:flex;
      flex-direction:column;
      gap:1rem;
      z-index: 20;
    }
    .profile-drawer.active { right:0; }

    .profile-drawer h2 { color:#0ff; text-align:center; }
    .profile-drawer label { color:#0ff; font-size:0.9rem; }
    .profile-drawer input, .profile-drawer select, .profile-drawer textarea {
      width:100%;
      padding:0.5rem;
      border-radius:10px;
      border:none;
      outline:none;
      background: rgba(255,255,255,0.05);
      color:#fff;
      margin-bottom:0.5rem;
    }
    .profile-drawer button {
      background: linear-gradient(45deg, #0ff, #0f0, #0ff);
      border:none;
      padding:0.5rem;
      border-radius:10px;
      cursor:pointer;
      font-weight:bold;
      color:#000;
    }

    /* ---------- AUTH MODAL ---------- */
    .auth-container {
      position: fixed;
      top:0;
      left:0;
      width:100%;
      height:100%;
      background: rgba(0,0,0,0.85);
      display:flex;
      justify-content:center;
      align-items:center;
      z-index:30;
    }
    .auth-box {
      background: rgba(20,20,30,0.95);
      backdrop-filter: blur(15px);
      padding:2rem;
      border-radius:15px;
      box-shadow: 0 0 20px #0ff;
      width:300px;
      display:flex;
      flex-direction:column;
      gap:1rem;
    }
    .auth-box h2 { color:#0ff; text-align:center; }
    .auth-box input {
      padding:0.5rem;
      border-radius:10px;
      border:none;
      outline:none;
      background: rgba(255,255,255,0.05);
      color:#fff;
    }
    .auth-box button {
      background: linear-gradient(45deg, #0ff, #0f0, #0ff);
      border:none;
      padding:0.5rem;
      border-radius:10px;
      cursor:pointer;
      font-weight:bold;
      color:#000;
    }
    .auth-toggle { color:#0ff; cursor:pointer; text-align:center; font-size:0.85rem; }
  </style>
</head>
<body>

  <!-- NAVBAR -->
  <div class="navbar">
    <div class="logo">NeonApp</div>
    <div class="nav-links">
      <button id="logoutBtn">Logout</button>
      <div class="avatar-btn" id="avatarBtn">
        <img src="https://i.pravatar.cc/100" alt="avatar" id="navAvatar">
      </div>
    </div>
  </div>

  <!-- DASHBOARD -->
  <div class="dashboard" id="dashboard">Welcome, Guest</div>

  <!-- PROFILE DRAWER -->
  <div class="profile-drawer" id="profileDrawer">
    <h2>Edit Profile</h2>
    <label>Username</label>
    <input type="text" id="profileUsername">
    <label>Email</label>
    <input type="email" id="profileEmail">
    <label>Phone</label>
    <input type="text" id="profilePhone">
    <label>Gender</label>
    <select id="profileGender">
      <option value="">Select Gender</option>
      <option>Male</option>
      <option>Female</option>
      <option>Other</option>
    </select>
    <label>Class/Year</label>
    <input type="text" id="profileClass">
    <label>Bio</label>
    <textarea id="profileBio" rows="3"></textarea>
    <label>Avatar</label>
    <input type="file" id="profileAvatar" accept="image/*">
    <button id="saveProfileBtn">Save Profile</button>
  </div>

  <!-- AUTH MODAL -->
  <div class="auth-container" id="authContainer">
    <div class="auth-box" id="loginBox">
      <h2>Login</h2>
      <input type="email" id="loginEmail" placeholder="Email">
      <input type="password" id="loginPassword" placeholder="Password">
      <button id="loginBtn">Login</button>
      <div class="auth-toggle" id="showSignup">Don't have an account? Signup</div>
    </div>

    <div class="auth-box" id="signupBox" style="display:none;">
      <h2>Signup</h2>
      <input type="text" id="signupUsername" placeholder="Username">
      <input type="email" id="signupEmail" placeholder="Email">
      <input type="password" id="signupPassword" placeholder="Password">
      <button id="signupBtn">Signup</button>
      <div class="auth-toggle" id="showLogin">Already have an account? Login</div>
    </div>
  </div>

  <script>
    // ---------- LOCALSTORAGE USERS ----------
    let users = JSON.parse(localStorage.getItem('users')) || [];
    let currentUser = JSON.parse(localStorage.getItem('currentUser')) || null;

    const authContainer = document.getElementById('authContainer');
    const loginBox = document.getElementById('loginBox');
    const signupBox = document.getElementById('signupBox');

    const dashboard = document.getElementById('dashboard');
    const avatarBtn = document.getElementById('avatarBtn');
    const profileDrawer = document.getElementById('profileDrawer');
    const navAvatar = document.getElementById('navAvatar');
    const logoutBtn = document.getElementById('logoutBtn');

    // ---------- AUTH TOGGLE ----------
    document.getElementById('showSignup').onclick = () => { loginBox.style.display='none'; signupBox.style.display='flex'; }
    document.getElementById('showLogin').onclick = () => { signupBox.style.display='none'; loginBox.style.display='flex'; }

    // ---------- SIGNUP ----------
    document.getElementById('signupBtn').onclick = () => {
      const username = document.getElementById('signupUsername').value;
      const email = document.getElementById('signupEmail').value;
      const password = document.getElementById('signupPassword').value;

      if(!username||!email||!password){ alert('Fill all fields'); return; }
      if(users.find(u=>u.email===email)){ alert('User already exists'); return; }

      const newUser = { username,email,password,phone:'',gender:'',class:'',bio:'',avatar:'https://i.pravatar.cc/100' };
      users.push(newUser);
      localStorage.setItem('users', JSON.stringify(users));
      alert('Signup successful!');
      loginBox.style.display='flex'; signupBox.style.display='none';
    }

    // ---------- LOGIN ----------
    document.getElementById('loginBtn').onclick = () => {
      const email = document.getElementById('loginEmail').value;
      const password = document.getElementById('loginPassword').value;
      const user = users.find(u=>u.email===email && u.password===password);
      if(!user){ alert('Invalid credentials'); return; }
      currentUser = user;
      localStorage.setItem('currentUser', JSON.stringify(currentUser));
      authContainer.style.display='none';
      renderDashboard();
    }

    // ---------- LOGOUT ----------
    logoutBtn.onclick = () => {
      currentUser = null;
      localStorage.removeItem('currentUser');
      authContainer.style.display='flex';
    }

    // ---------- RENDER DASHBOARD ----------
    function renderDashboard(){
      if(currentUser){
        dashboard.textContent = `Welcome, ${currentUser.username}`;
        navAvatar.src = currentUser.avatar || 'https://i.pravatar.cc/100';
        // Fill drawer fields
        document.getElementById('profileUsername').value = currentUser.username;
        document.getElementById('profileEmail').value = currentUser.email;
        document.getElementById('profilePhone').value = currentUser.phone;
        document.getElementById('profileGender').value = currentUser.gender;
        document.getElementById('profileClass').value = currentUser.class;
        document.getElementById('profileBio').value = currentUser.bio;
      }
    }

    // ---------- PROFILE DRAWER TOGGLE ----------
    avatarBtn.onclick = () => profileDrawer.classList.toggle('active');

    // ---------- SAVE PROFILE ----------
    document.getElementById('saveProfileBtn').onclick = () => {
      currentUser.username = document.getElementById('profileUsername').value;
      currentUser.email = document.getElementById('profileEmail').value;
      currentUser.phone = document.getElementById('profilePhone').value;
      currentUser.gender = document.getElementById('profileGender').value;
      currentUser.class = document.getElementById('profileClass').value;
      currentUser.bio = document.getElementById('profileBio').value;

      const avatarFile = document.getElementById('profileAvatar').files[0];
      if(avatarFile){
        const reader = new FileReader();
        reader.onload = () => {
          currentUser.avatar = reader.result;
          navAvatar.src = currentUser.avatar;
          localStorage.setItem('currentUser', JSON.stringify(currentUser));
          users = users.map(u=>u.email===currentUser.email?currentUser:u);
          localStorage.setItem('users', JSON.stringify(users));
          profileDrawer.classList.remove('active'); // auto-close
          renderDashboard();
        }
        reader.readAsDataURL(avatarFile);
      } else {
        localStorage.setItem('currentUser', JSON.stringify(currentUser));
        users = users.map(u=>u.email===currentUser.email?currentUser:u);
        localStorage.setItem('users', JSON.stringify(users));
        profileDrawer.classList.remove('active'); // auto-close
        renderDashboard();
      }
    }

    // ---------- AUTO-LOGIN IF SESSION ----------
    if(currentUser){ authContainer.style.display='none'; renderDashboard(); }
  </script>
</body>
</html>
