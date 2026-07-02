import { describe, expect, it, vi } from "vitest";

import {
  hasApiViewReviewId,
  isAllowedHost,
  validateUrl,
} from "../../src/arch-board-review/url-validation.js";

describe("url-validation", () => {
  it("rejects non-allowlisted hosts", async () => {
    await expect(validateUrl("https://evil.example.com/path")).resolves.toEqual({
      valid: false,
      reason: "host-not-allowed",
    });
    expect(isAllowedHost("https://evil.example.com/path")).toBe(false);
  });

  it("requires an APIView review id", async () => {
    expect(hasApiViewReviewId("https://apiview.dev/Assemblies/Review/abc123")).toBe(true);
    expect(hasApiViewReviewId("https://apiview.dev/Assemblies")).toBe(false);

    await expect(validateUrl("https://apiview.dev/Assemblies")).resolves.toEqual({
      valid: false,
      reason: "missing-apiview-review-id",
    });
  });

  it("uses HEAD/GET for non-APIView allowlisted urls", async () => {
    const fetchImpl = vi
      .fn()
      .mockResolvedValueOnce({ ok: false, status: 500 })
      .mockResolvedValueOnce({ ok: true, status: 200 });

    await expect(
      validateUrl("https://github.com/Azure/azure-sdk/pull/10037", { fetchImpl }),
    ).resolves.toEqual({
      valid: true,
      reason: null,
    });
    expect(fetchImpl).toHaveBeenCalledTimes(2);
  });
});
