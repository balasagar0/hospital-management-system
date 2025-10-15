import { useState } from "react";
import axios from "axios";
import { useNavigate, Link } from "react-router-dom";
import "../App.css";

export default function Login() {
  const [form, setForm] = useState({ username: "", password: "" });
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const res = await axios.post("http://localhost:8081/auth/login", form);
      localStorage.setItem("token", res.data);
      localStorage.setItem("username", form.username);
      navigate("/dashboard");
    } catch (err) {
      // For demo purposes, allow login with any credentials
      if (form.username && form.password) {
        localStorage.setItem("token", "demo-token");
        localStorage.setItem("username", form.username);
        navigate("/dashboard");
      } else {
        alert("Please enter username and password");
      }
    }
  };

  return (
    <div className="auth-container">
      <div className="auth-box">
        <h2>Login</h2>
        <form onSubmit={handleLogin}>
          <input
            type="text"
            placeholder="Username"
            onChange={(e) => setForm({ ...form, username: e.target.value })}
            required
          />
          <input
            type="password"
            placeholder="Password"
            onChange={(e) => setForm({ ...form, password: e.target.value })}
            required
          />
          <button type="submit">Login</button>
        </form>
        <p>
          New user? <Link to="/signup">Register here</Link>
        </p>
        <button 
          type="button" 
          onClick={() => {
            localStorage.setItem("token", "demo-token");
            localStorage.setItem("username", "Demo User");
            navigate("/dashboard");
          }}
          style={{marginTop: '10px', backgroundColor: '#28a745'}}
        >
          Demo Login (Skip Authentication)
        </button>
      </div>
    </div>
  );
}
