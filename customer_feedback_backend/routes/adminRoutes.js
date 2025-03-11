const express = require("express");
const {
  getAllFeedback,
  deleteFeedback,
  updateFeedback,  // ✅ Add updateFeedback controller
} = require("../controllers/feedbackController");

const authMiddleware = require("../middleware/authMiddleware");
const adminMiddleware = require("../middleware/adminMiddleware");

const router = express.Router();

// ✅ Admin can view all feedback
router.get("/feedback", authMiddleware, adminMiddleware, getAllFeedback);

// ✅ Admin can update feedback (Fix)
router.put("/feedback/:id", authMiddleware, adminMiddleware, updateFeedback);

// ✅ Admin can delete feedback
router.delete("/feedback/:id", authMiddleware, adminMiddleware, deleteFeedback);

module.exports = router;
