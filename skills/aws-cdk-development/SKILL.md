---
name: aws-cdk-development
description: Use when building/refactoring AWS infrastructure with CDK (TypeScript/Python), validating stacks, or handling `cdk synth/deploy` workflows with current AWS documentation checks.
context: fork
skills:
  - aws-mcp-setup
allowed-tools:
  - mcp__cdk__*
  - mcp__aws-mcp__*
  - mcp__awsdocs__*
  - Bash(cdk *)
  - Bash(npm *)
  - Bash(npx *)
  - Bash(aws cloudformation *)
  - Bash(aws sts get-caller-identity)
hooks:
  PreToolUse:
    - matcher: Bash(cdk deploy*)
      command: aws sts get-caller-identity --query Account --output text
      once: true
---

# AWS CDK Development

CDK workflow guidance with mandatory up-to-date AWS verification via MCP tools.

## AWS Docs Verification (Required)

Before answering AWS/CDK capability questions:
1. Use AWS MCP docs/search/read tools when available.
2. Verify regional availability for required services.
3. Verify current limits/features/API behavior.

If AWS MCP unavailable:
- guide setup via `aws-mcp-setup`
- choose path by environment:
  - has `uvx` + AWS credentials -> full AWS MCP server
  - no credentials/Python -> docs-only MCP
- if uncertain, ask user which path to configure

## Integrated Servers

### AWS Documentation MCP
Use for current AWS service features, limits, regions, and security guidance.

### CDK MCP
Use for construct selection, property guidance, CDK best-practice patterns, and CDK-specific optimization.

## When to Use

- create new CDK apps/stacks/constructs
- refactor CDK architecture
- embed Lambda in CDK stacks
- pre-deploy validation and synthesis review
- region/service capability confirmation

## Core Principles

### 1) Resource naming (critical)

Do **not** set optional explicit resource names unless strictly required.

Why:
- reusable constructs
- parallel deployments without collisions
- cleaner shared patterns
- automatic stack isolation

```typescript
// Avoid unless required
new lambda.Function(this, 'Fn', { functionName: 'my-lambda' })

// Preferred
new lambda.Function(this, 'Fn', {
  // let CDK/CloudFormation generate unique name
})
```

Security note: use separate AWS accounts for env isolation (dev/stage/prod), not naming tricks.

### 2) Lambda construct choice

- TypeScript/JavaScript: `NodejsFunction`
- Python: `PythonFunction`

Benefits: bundled dependencies/transpilation/packaging handled by construct.

```typescript
import { NodejsFunction } from 'aws-cdk-lib/aws-lambda-nodejs'
new NodejsFunction(this, 'Fn', { entry: 'lambda/handler.ts', handler: 'handler' })
```

```typescript
import { PythonFunction } from '@aws-cdk/aws-lambda-python-alpha'
new PythonFunction(this, 'Fn', { entry: 'lambda', index: 'handler.py', handler: 'handler' })
```

## Validation Strategy (Required)

### Layer 1: IDE/synth feedback (recommended)

Use `cdk-nag` aspects:

```bash
npm install --save-dev cdk-nag
```

```typescript
import { Aspects } from 'aws-cdk-lib'
import { AwsSolutionsChecks } from 'cdk-nag'

const app = new App()
Aspects.of(app).add(new AwsSolutionsChecks())
```

### Layer 2: Synthesis validation (required)

```bash
cdk synth
```

Suppress only with explicit reason:

```typescript
NagSuppressions.addResourceSuppressions(resource, [
  {
    id: 'AwsSolutions-L1',
    reason: 'Required runtime constraint for Lambda@Edge compatibility'
  }
])
```

### Layer 3: Pre-commit checks

```bash
npm run build
npm test
./scripts/validate-stack.sh
```

Validation script scope:
- language detection
- template/resource-size sanity
- synthesis success
- anti-pattern depth handled primarily by `cdk-nag`

## Workflow

1. design resources and boundaries
2. verify AWS capability/region/limits via MCP
3. implement constructs with CDK patterns
4. validate (build/test/synth/nag/script)
5. review synthesized templates
6. deploy
7. verify deployed state

## Stack Organization

- use nested stacks for complexity control
- split by concern/domain
- export only required cross-stack values
- use context for environment-specific values

## Testing

- unit test constructs
- integration test synthesized stack behavior
- snapshot templates where appropriate
- assert critical resource properties/relationships

## MCP Usage Rules

### Use AWS docs MCP for
- new service feature checks
- regional availability
- limits/quotas
- latest security recommendations

### Use CDK MCP for
- construct/API selection
- property-level tradeoffs
- stack design patterns
- CDK-specific anti-pattern avoidance

### Best practices
1. verify first, then implement
2. always validate target region
3. combine MCP data with this skill's patterns
4. treat MCP as source of truth for time-sensitive AWS facts

## Detailed Pattern Reference

- `references/cdk-patterns.md` for deeper pattern/anti-pattern/security/cost/perf guidance.
- `scripts/validate-stack.sh` for pre-deploy validation.

## GitHub Actions Rule

If `.github/workflows/` exists, ensure all defined checks pass before commit to avoid CI regressions.
