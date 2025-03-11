const express = require("express");
const {
  submitFeedback,
  getUserFeedback,
  getAllFeedback,
  deleteFeedback,
  updateFeedback
} = require("../controllers/feedbackController");
const authMiddleware = require("../middleware/authMiddleware");
const adminMiddleware = require("../middleware/adminMiddleware"); // Ensure Admin Access

const router = express.Router();

// ✅ User can submit feedback
router.post("/add", authMiddleware, submitFeedback);

// ✅ User can view their feedback
router.get("/list", authMiddleware, getUserFeedback);

// ✅ Admin can view all feedback
router.get("/all", authMiddleware, adminMiddleware, getAllFeedback);

// ✅ Admin can delete feedback
router.delete("/delete/:id", adminMiddleware, deleteFeedback);

// ✅ Admin can update feedback
router.put("/update/:id", authMiddleware, updateFeedback);

// ✅ Handle Invalid Routes
router.all("*", (req, res) => {
  res.status(404).json({ message: "Invalid Feedback API Route" });
});

module.exports = router;
