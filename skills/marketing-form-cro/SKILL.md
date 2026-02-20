---
name: form-cro
version: 1.0.0
description: Use when optimizing non-signup forms (lead/contact/demo/application/survey/checkout/quote), improving completion rate, reducing friction, or diagnosing field-level drop-off.
---

# Form CRO

Optimize form completion without losing required data quality.

## Initial Assessment

1. If `.codex/product-marketing-context.md` exists, read it first.
2. Ask only for missing task-specific inputs.
3. Capture:
- Form type
- Current field count and completion metrics
- Device split and abandonment points
- Submission workflow and true field usage
- Compliance/legal constraints

## Core Principles

1. **Every field has conversion cost**
- 3 fields: baseline
- 4-6 fields: often 10-25% completion drop
- 7+ fields: often 25-50%+ drop

2. **Value must exceed effort**
- clear benefit above form
- explicit outcome
- low perceived effort

3. **Minimize cognitive load**
- one question per field
- simple labels
- logical sequence
- defaults/autofill where safe

## Field Optimization Rules

### Email
- one field, no confirmation
- inline validation
- typo hinting
- email keyboard on mobile

### Name
- test single `Name` vs split first/last
- split only if downstream requires it

### Phone
- optional unless required
- if required, explain reason
- format while typing
- handle country code

### Company
- autocomplete/suggest
- enrich post-submit where possible
- consider deriving from email domain

### Role/title
- dropdown for fixed categories
- free text for broad variation
- optional by default

### Message/comments
- optional unless essential
- concise guidance
- auto-expand on focus

### Selects/checkboxes
- placeholder prompt (`Select one...`)
- searchable for long lists
- radios when <5 options
- `Other` + conditional text input
- parallel, unambiguous labels

## Layout and Flow

### Field order
1. easiest first
2. commitment before sensitive data
3. sensitive fields late (phone, company size)
4. group related fields

### Labels/placeholders
- labels must remain visible
- placeholders are examples only
- helper text only when it removes ambiguity

Good:

```text
Email
[name@company.com]
```

Bad:

```text
[Enter your email address]
```

### Visual structure
- clear hierarchy + spacing
- prominent CTA
- touch targets >=44px
- prefer single column (especially mobile)
- multi-column only for tightly related short fields

## Multi-Step Forms

Use multi-step when:
- >5-6 fields
- distinct sections exist
- conditional branching needed
- form complexity is high

Required patterns:
- step indicator
- easy -> sensitive progression
- back navigation
- state persistence across refresh
- required/optional clarity

Progressive commitment sequence:
1. low-friction opener (often email)
2. profile basics
3. qualification questions
4. contact preferences

## Validation and Errors

### Inline validation
- validate on field exit or stable input points
- avoid aggressive per-keystroke interruptions

### Error message rules
- specific cause
- explicit fix
- near field
- preserve user input

Good: `Enter a valid email (name@company.com)`
Bad: `Invalid input`

### Submit-time behavior
- focus first invalid field
- summarize if many errors
- never clear valid data on error

## Submit Button

### Copy
Prefer action + value over generic verbs.

Examples:
- `Get My Free Quote`
- `Download the Guide`
- `Request Demo`
- `Send Message`

### Placement/state
- directly after last field
- visually obvious
- high contrast
- loading state required (disable + spinner)
- clear success and failure follow-up states

## Trust and Friction Reduction

Near-form trust elements:
- privacy promise
- response-time expectation
- relevant social proof
- security markers when sensitive data collected

Perceived effort reduction:
- completion-time hint (e.g., `~30 seconds`)
- field count signal
- low visual clutter

## Form-Type Specific Baselines

### Lead capture
- minimum viable fields (often email only)
- explicit content value
- test email-only vs email+name
- move enrichment post-submit

### Contact
- required: name/email + message
- phone optional
- response-time expectation
- alternate channels (chat/phone)

### Demo request
- usually required: name/email/company
- phone optional with contact preference
- use-case question can improve qualification
- calendar embed may increase show rates

### Quote/estimate
- multi-step usually beneficial
- simple to complex progression
- save progress

### Survey
- progress bar required
- one-question screens for long flows
- skip logic for relevance
- incentive testing when appropriate

## Mobile Rules

- single column only
- touch targets >=44px
- field-type keyboard optimization
- autofill support
- minimize typing via choices/autocomplete
- sticky or always-visible submit CTA

## Measurement

### Core metrics
- form start rate (views -> first interaction)
- completion rate (start -> submit)
- field drop-off
- field error rate
- time to complete
- device-segment completion

### Event instrumentation
- form view
- first focus
- per-field completion
- per-field errors
- submit attempt
- successful submit

## Output Format

### Form audit entry
- Issue
- Impact (estimated)
- Fix
- Priority (High/Medium/Low)

### Recommended design spec
- required fields + rationale
- optional fields + rationale
- field order
- label/placeholder/button copy
- error messages
- layout guidance

### Test hypotheses
- A/B idea
- expected directional impact
- primary metric

## Experiment Backlog

### Structure/flow
- single vs multi-step
- single vs two-column
- embedded vs standalone form page
- above-fold placement variants
- progressive profiling vs full upfront capture

### Field strategy
- remove non-essential fields
- required vs optional for phone/company
- conditional fields
- enrichment vs manual input

### Copy/design
- label and microcopy clarity
- button copy variants
- trust message placement
- response-time messaging

### Mobile UX
- sticky CTA variants
- keyboard/autofill improvements
- touch target sizing

## Task Questions

1. Current completion rate?
2. Field-level analytics available?
3. What happens after submit?
4. Which captured fields are actually used?
5. Compliance constraints?
6. Mobile vs desktop split?

## Related Skills

- `signup-flow-cro`: signup/registration forms
- `popup-cro`: popup/modal forms
- `page-cro`: page-level CRO around form
- `ab-test-setup`: experimentation setup
