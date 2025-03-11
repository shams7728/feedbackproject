const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");
const connectDB = require("./config/db");

// Load environment variables
dotenv.config();

// Initialize Express
const app = express();

// Middleware
app.use(express.json());
app.use(cors());

// Connect to MongoDB
connectDB();

// Routes
app.use("/api/auth", require("./routes/authRoutes"));
app.use("/api/feedback", require("./routes/feedbackRoutes"));
app.use("/api/admin", require("./routes/adminRoutes"));

// Get IP from .env or default to 0.0.0.0 (accessible from any device)
const HOST = process.env.HOST || "0.0.0.0";
const PORT = process.env.PORT || 5000;

// Start server
app.listen(PORT, HOST, () => {
  console.log(`🚀 Server running on http://${HOST}:${PORT}`);
});
