const Feedback = require("../models/Feedback");

// ✅ Submit Feedback
exports.submitFeedback = async (req, res) => {
  try {
    if (!req.user || !req.user.id) {
      return res.status(401).json({ message: "Unauthorized access" });
    }

    const feedback = new Feedback({
      userId: req.user.id,
      message: req.body.message,
    });

    await feedback.save();
    res.status(201).json({ message: "Feedback Submitted Successfully!" });

  } catch (error) {
    res.status(500).json({ message: "Server Error", error: error.message });
  }
};

// ✅ Get Feedback for a Specific User
exports.getUserFeedback = async (req, res) => {
  try {
    if (!req.user || !req.user.id) {
      return res.status(401).json({ message: "Unauthorized access" });
    }

    const feedbacks = await Feedback.find({ userId: req.user.id })
      .select("message createdAt") // Only include message & createdAt
      .sort({ createdAt: -1 });

    res.status(200).json(feedbacks);
  } catch (error) {
    res.status(500).json({ message: "Error fetching feedback", error: error.message });
  }
};

// ✅ Get All Feedback (Admin Only)
exports.getAllFeedback = async (req, res) => {
    try {
      const feedbacks = await Feedback.find()
        .populate({ path: "userId", select: "name" }) // ✅ Ensure only user name is fetched
        .select("message createdAt userId"); // ✅ Ensure userId is included
  
      res.status(200).json(feedbacks);
    } catch (error) {
      res.status(500).json({ message: "Server Error", error: error.message });
    }
  };
  
  

// ✅ Delete Feedback (Admin Only)
exports.deleteFeedback = async (req, res) => {
  try {
    if (!req.user || !req.user.isAdmin) {
      return res.status(403).json({ message: "Access Denied. Admin Only." });
    }

    const { id } = req.params;
    const feedback = await Feedback.findByIdAndDelete(id);

    if (!feedback) {
      return res.status(404).json({ message: "Feedback Not Found" });
    }

    res.status(200).json({ message: "Feedback Deleted Successfully" });
  } catch (error) {
    res.status(500).json({ message: "Server Error", error: error.message });
  }
};

// ✅ Update Feedback (Admin Only)
exports.updateFeedback = async (req, res) => {
    try {
      const { id } = req.params;
      const { message } = req.body;
  
      if (!message) {
        return res.status(400).json({ message: "Message is required for updating feedback" });
      }
  
      const feedback = await Feedback.findById(id);
      if (!feedback) {
        return res.status(404).json({ message: "Feedback Not Found" });
      }
  
      // ✅ Allow Admins to edit any feedback
      if (req.user.isAdmin || feedback.userId.toString() === req.user.id) {
        feedback.message = message;
        await feedback.save();
  
        return res.status(200).json({ message: "Feedback Updated Successfully", feedback });
      }
  
      return res.status(403).json({ message: "Unauthorized: You can only edit your own feedback" });
    } catch (error) {
      res.status(500).json({ message: "Server Error", error: error.message });
    }
  };
  
  
