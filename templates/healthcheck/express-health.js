const { Router } = require("express");

// Mount with: app.use("/api/health", require("./health"))
// Returns HTTP 200 with { status, version, timestamp } when healthy.
const router = Router();

router.get("/", (_req, res) => {
  res.json({
    status: "ok",
    version: process.env.npm_package_version ?? "1.0.0",
    timestamp: new Date().toISOString(),
  });
});

module.exports = router;
