const Feedback = require("../models/Feedback");
const User = require("../models/User");
const jwt = require("jsonwebtoken");

// Admin Login
exports.adminLogin = async (req, res) => {
  const { email, password } = req.body;
  const user = await User.findOne({ email, isAdmin: true });

  if (!user) return res.status(403).json({ message: "Access Denied" });

  const token = jwt.sign({ id: user._id, isAdmin: true }, process.env.JWT_SECRET, { expiresIn: "1h" });

  res.json({ token, user });
};

// Get All Feedback
exports.getAllFeedback = async (req, res) => {
  const feedbacks = await Feedback.find().populate("userId", "name");
  res.json(feedbacks);
};

// Delete Feedback
exports.deleteFeedback = async (req, res) => {
  await Feedback.findByIdAndDelete(req.params.id);
  res.json({ message: "Feedback Deleted" });
};
