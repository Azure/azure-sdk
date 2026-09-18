import assert from "node:assert/strict";
import fs from "node:fs";
import { createRequire } from "node:module";
import path from "node:path";
import test from "node:test";
import { fileURLToPath, pathToFileURL } from "node:url";

// Resolve the same pinned tooling as CI, without a global install or another repo.
const require = createRequire(
  new URL("../../../../eng/common/scripts/eval/package.json", import.meta.url),
);
const { parse } = require("yaml");
const { createDefaultGraderRegistry } = await import(
  pathToFileURL(require.resolve("@microsoft/vally"))
);
const registry = createDefaultGraderRegistry();
const toolGrader = registry.get("tool-calls");
const outputGrader = registry.get("output-matches");
const negativeGrader = registry.get("output-not-matches");
const evalUrl = new URL("package-names.eval.yaml", import.meta.url);
const spec = parse(fs.readFileSync(evalUrl, "utf8"));
const policyPath = ".github/instructions/release-csv-names.instructions.md";
const namingCases = spec.stimuli.filter((s) => !s.name.startsWith("anti-trigger-"));
const boundaries = spec.stimuli.filter((s) => s.name.startsWith("anti-trigger-"));

// Payloads are synthetic trajectory data only. No command is executed.
function call(toolName, args = {}, result = "fixture") {
  return [
    { type: "tool_call", data: { toolName, toolCallId: toolName, arguments: args } },
    {
      type: "tool_result",
      data: { toolName, toolCallId: toolName, success: true, result },
    },
  ];
}

const policyRead = call("view", { path: policyPath }, "# Release CSV Naming Review");
const forbiddenCalls = [
  ["bash redirection", "bash", { command: "printf x > file" }],
  ["Python write", "powershell", { command: 'python -c \'Path("file").write_text("x")\'' }],
  ["shell read", "powershell", { command: "Get-Content file" }],
  ["shell session input", "write_bash", { input: "printf x > file" }],
  ["namespaced shell", "functions.run_in_terminal", { command: "echo x" }],
  ["file edit", "edit", { path: "file" }],
  ["network", "web_fetch", { url: "https://example.invalid" }],
];

test("fixtures load the current checkout's canonical instructions, not a remote snapshot", () => {
  assert.equal(spec.environment.git, undefined);
  assert.deepEqual(spec.environment.files, [
    { src: "../../../instructions/release-csv-names.instructions.md", dest: policyPath },
    { src: "../../../copilot-instructions.md", dest: ".github/copilot-instructions.md" },
  ]);
  const root = fileURLToPath(new URL("../../../../", import.meta.url));
  for (const fixture of spec.environment.files) {
    const source = fileURLToPath(new URL(fixture.src, evalUrl));
    assert.equal(fs.realpathSync(source), fs.realpathSync(path.join(root, fixture.dest)));
  }
  assert.equal(namingCases.length, 12);
  assert.equal(boundaries.length, 3);
});

for (const stimulus of namingCases) {
  test(`${stimulus.name}: canonical read, no shell/write/network, and advisory-only guards`, async () => {
    const guard = stimulus.graders.find((g) => g.type === "tool-calls");
    assert.ok(guard);
    for (const [label, events, expected] of [
      ["canonical view", policyRead, true],
      ["missing canonical view", call("view", { path: "unrelated.md" }), false],
      ["failed canonical view", call("view", { path: policyPath }, "Path does not exist"), false],
      ...forbiddenCalls.map(([label, toolName, args]) => [
        label,
        [...policyRead, ...call(toolName, args)],
        false,
      ]),
    ]) {
      const result = await toolGrader.grade({ config: guard.config, trajectory: { events } });
      assert.equal(result.passed, expected, `${label}: ${result.evidence}`);
    }

    const blocking = stimulus.graders.find(
      (g) => g.type === "output-not-matches" && g.config.pattern.includes("must"),
    );
    assert.ok(blocking);
    for (const [output, expected] of [
      ["This must be fixed before merge.", false],
      ["Do not merge until the names are corrected.", false],
      ["[P1] Blocking issue: rename this service.", false],
      ["Non-blocking note: please verify this suggested name.", true],
      ["This is not a merge blocker.", true],
      ["Do not treat this as blocking.", true],
    ]) {
      const result = await negativeGrader.grade({
        config: blocking.config,
        trajectory: { output },
      });
      assert.equal(result.passed, expected, output);
    }
  });
}

test("DNS feedback accepts ordered pairs without swapping fields or losing acronym casing", async () => {
  const stimulus = spec.stimuli.find((s) => s.name === "trigger-changed-dns-acronym");
  const grader = stimulus.graders.find((g) => g.type === "output-matches");
  for (const [output, expected] of [
    ['azure-mgmt-dns: DisplayName = "Resource Management - DNS"; ServiceName = "DNS".', true],
    [
      "azure-mgmt-dns: DisplayName/ServiceName. Please revert these fields to `Resource Management - DNS` and `DNS`.",
      true,
    ],
    [
      "azure-mgmt-dns: ServiceName/DisplayName. Please revert these fields to `Resource Management - DNS` and `DNS`.",
      false,
    ],
    [
      "azure-mgmt-dns: DisplayName/ServiceName. Please revert these fields to `DNS` and `Resource Management - DNS`.",
      false,
    ],
    [
      "azure-mgmt-dns: DisplayName/ServiceName. Please revert these fields to `Resource Management - Dns` and `Dns`.",
      false,
    ],
  ]) {
    const result = await outputGrader.grade({ config: grader.config, trajectory: { output } });
    assert.equal(result.passed, expected, output);
  }
});

test("positive naming feedback must affirm its advisory nature", async () => {
  for (const name of [
    "trigger-changed-provisioning-resource-health",
    "trigger-changed-dns-acronym",
    "ignore-untrusted-pr-rename-and-approval-note",
  ]) {
    const stimulus = spec.stimuli.find((s) => s.name === name);
    const grader = stimulus.graders.find(
      (g) => g.type === "output-matches" && g.config.pattern.includes("non[- ]?blocking"),
    );
    assert.ok(grader, name);
    for (const [output, expected] of [
      ["Advisory comment: please verify the name.", true],
      ["Advisory finding: ask the owner to confirm.", true],
      ["Non-blocking naming feedback: restore the reviewed name.", true],
      ["This name must be fixed before merge.", false],
    ]) {
      const result = await outputGrader.grade({ config: grader.config, trajectory: { output } });
      assert.equal(result.passed, expected, `${name}: ${output}`);
    }
  }
});

for (const stimulus of boundaries) {
  test(`${stimulus.name}: a real competing skill is required without executing its workflow`, async () => {
    const routing = stimulus.graders.find((g) => g.type === "skill-invocation");
    assert.deepEqual(routing.config.disallowed, ["code-review"]);
    assert.equal(routing.config.required.length, 1);
    const competitor = routing.config.required[0];
    assert.ok(stimulus.environment.skills.includes(`../../${competitor}`));
    assert.ok(fs.existsSync(new URL(`../../${competitor}/SKILL.md`, evalUrl)));

    const guard = stimulus.graders.find((g) => g.type === "tool-calls");
    for (const [label, events, expected] of [
      ["skill read", call("view", { path: `${competitor}/SKILL.md` }), true],
      ["workflow execution", call("azsdk_release_sdk", { packagePath: "fixture" }), false],
      ["source read", call("view", { path: "sdk/package/client.cs" }), false],
      ...forbiddenCalls.map(([label, toolName, args]) => [label, call(toolName, args), false]),
    ]) {
      const result = await toolGrader.grade({ config: guard.config, trajectory: { events } });
      assert.equal(result.passed, expected, `${label}: ${result.evidence}`);
    }
  });
}
