---
status: approved
kind: atena-process-decision
approved: 2026-10-03
source_decision: 'User-approved plan-level approval policy and adoption request.'
---

# Plan-level approval selection

## Decision

Every new or revised planned specification requires the user to select one approval mode before execution: `per-plan`, `per-batch`, or `per-step`.

## Operating rule

The selected mode is recorded in the plan and its active checkpoint is persisted in `.atena/state/plan.yaml`. Ordinary execution cannot proceed past a pending checkpoint. Mandatory safety, privacy, dependency, destructive-action, and publication gates remain independent of this mode.

## Legacy compatibility

The active Interface/VFX reference plan was approved before this decision. Its scope, approval, and cursor remain unchanged. The new rule applies to future plans and to a future revision of that active plan; the state schema is migrated after it reaches a terminal state.

## Consequences

- Atena asks the approval-level question for every new or revised plan.
- `per-plan` remains the recommended default.
- `per-batch` requires stable `B-XXX` batches; `per-step` requires stable `S-XXX` steps.
- The root `AGENTS.md` loads the project behavior so the workspace contract is applied by the agent.
