#!/usr/bin/env node
/** Validate the small, dependency-free contract used by batch-image-autopilot. */

import { readFileSync } from "node:fs";

const rootFields = ["approval", "art_direction", "output_dir", "max_attempts", "assets"];
const assetFields = ["id", "kind", "prompt", "target", "checks"];
const characterFields = ["scale_reference", "target_height_ratio", "ground_pivot"];

function fail(message) {
  console.error(`INVALID: ${message}`);
  process.exit(1);
}

const manifestPath = process.argv[2];
if (!manifestPath || process.argv.length !== 3) {
  fail("usage: validate_batch_manifest.mjs <manifest.json>");
}

let data;
try {
  data = JSON.parse(readFileSync(manifestPath, "utf8"));
} catch (error) {
  fail(error.message);
}

const missingRoot = rootFields.filter((field) => !(field in data));
if (missingRoot.length) fail(`missing root fields: ${missingRoot.join(", ")}`);
if (!["approved", "plan-approved"].includes(data.approval)) {
  fail("approval must be 'approved' or 'plan-approved'");
}
if (data.approval === "plan-approved") {
  const series = data.plan_approval;
  if (!series || typeof series !== "object" || Array.isArray(series)) {
    fail("plan-approved manifests need a plan_approval object");
  }
  for (const field of ["record", "plan_id", "batch_id"]) {
    if (typeof series[field] !== "string" || !series[field].trim()) {
      fail(`plan_approval.${field} must be a non-empty string`);
    }
  }
}
if (!Number.isInteger(data.max_attempts) || data.max_attempts < 1 || data.max_attempts > 5) {
  fail("max_attempts must be an integer from 1 to 5");
}
if (!Array.isArray(data.assets) || !data.assets.length) fail("assets must be a non-empty list");

const ids = new Set();
for (const [index, asset] of data.assets.entries()) {
  const position = index + 1;
  if (!asset || typeof asset !== "object" || Array.isArray(asset)) fail(`asset ${position} must be an object`);
  const missing = assetFields.filter((field) => !(field in asset));
  if (missing.length) fail(`asset ${position} missing fields: ${missing.join(", ")}`);
  if (typeof asset.id !== "string" || !asset.id.trim() || ids.has(asset.id)) {
    fail(`asset ${position} has a missing or duplicate id`);
  }
  ids.add(asset.id);
  if (!Array.isArray(asset.checks) || !asset.checks.length) fail(`asset '${asset.id}' needs at least one check`);
  if (asset.kind === "character") {
    const missingCharacter = characterFields.filter((field) => !(field in asset));
    if (missingCharacter.length) fail(`character '${asset.id}' missing fields: ${missingCharacter.join(", ")}`);
    if (typeof asset.target_height_ratio !== "number" || !Number.isFinite(asset.target_height_ratio) || asset.target_height_ratio <= 0) {
      fail(`character '${asset.id}' target_height_ratio must be a positive number`);
    }
  }
}

console.log(`VALID: ${data.assets.length} assets; max_attempts=${data.max_attempts}; approval=${data.approval}`);
