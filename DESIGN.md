---
version: "1.1"
name: "Architectural Schematic Mobile"
framework: "Flutter"
platforms: ["Android", "iOS"]
componentSystem: "shadcn_ui 0.55.x"
fontStrategy: "Bundled fonts"
primaryFont: "IBM Plex Sans"
technicalFont: "IBM Plex Mono"
mode: "light"
---

# Architectural Schematic Mobile

Design system for a precise, calm mobile product inspired by architectural
drawings, floor plans, measurement diagrams, and technical reports. The UI
must feel engineered and purposeful, never like a compressed web dashboard or
a generic Shadcn gallery.

## Source of truth

Use this document for semantic decisions. Use `lib/design_system/` for Dart
tokens and theme implementation. Feature widgets must consume the theme and
tokens instead of declaring raw design values.

## Tokens

### Colors

| Token | Value | Use |
| --- | --- | --- |
| background | `#F9F9F9` | App background |
| foreground | `#222222` | Primary text and icons |
| surface | `#FCFCFC` | Cards, sheets, dialogs, forms |
| surfaceContainer | `#F1F2F3` | Muted groups and secondary sections |
| surfaceContainerHigh | `#E8EAEC` | Strong neutral emphasis |
| primary | `#5B9BD5` | Main action, active state, progress |
| draftingBlue | `#4A90E2` | Strong active path and markers |
| primaryContainer | `#DCEBFA` | Selected or highlighted content |
| onPrimaryContainer | `#17344F` | Text on primary container |
| pencilGrey | `#808080` | Technical labels and annotations |
| mutedForeground | `#676C72` | Secondary text |
| outline | `#C7CBD0` | Component borders |
| outlineStrong | `#9CA2A8` | Structural lines and input borders |
| divider | `#D9DDE1` | Subtle separators |
| error | `#B3261E` | Error state |
| success | `#2E7D5B` | Success state |
| warning | `#A15C00` | Warning state |

Never use pure black, gradients, glow, or heavy shadows. Do not introduce
arbitrary colors in feature widgets.

### Type

Use IBM Plex Sans for interface copy and IBM Plex Mono for short technical
metadata: measurements, coordinates, identifiers, revision numbers,
timestamps, quantities, and status codes. Do not use monospace for paragraphs.

| Style | Size | Weight | Line height |
| --- | ---: | ---: | ---: |
| display | 40 | 700 | 1.1 |
| headline | 32 | 700 | 1.15 |
| title | 24 | 600 | 1.25 |
| section | 18 | 600 | 1.35 |
| body | 16 | 400 | 1.5 |
| bodySmall | 14 | 400 | 1.5 |
| label | 12 | 500 | 1.3 |
| technical | 12 | 500 | 1.4 |

Keep no more than four hierarchy levels on one screen. Use sentence case for
buttons and labels. Reserve uppercase for short technical annotations.

### Layout

Use a four-pixel spacing scale: `2, 4, 8, 12, 16, 24, 32, 48`. Use 16px
screen padding on compact phones, 20px on larger phones, and 24-32px on
tablets. Use 8px component radius, 0 elevation, and 1px borders by default.

All interactive targets are at least 48x48 logical pixels. Use constraints,
`LayoutBuilder`, `Expanded`, `Flexible`, and `Wrap`; do not use device-name
checks or fixed-height containers around variable text.

## Component rules

`shadcn_ui` is the primary component system. Prefer, in order:

1. Existing project-specific component.
2. An appropriate Shad component.
3. Composition of Shad components.
4. Material or Cupertino for platform-native behavior.
5. A custom component only when the above cannot satisfy the requirement.

Use `ShadButton` variants by meaning: primary, secondary, outline, ghost,
destructive, and link. Use `ShadCard` only for meaningful standalone groups,
with a surface background, 1px outline, 8px radius, and 16px padding. Prefer
headings and separators over wrapping every list item in a card.

Every form field has a persistent visible label. Use Shad form components and
handle keyboard insets, validation, focus traversal, disabled, error, and
submission states. Prefer `ShadSheet` over cramped mobile popovers.

Use bottom navigation only for three to five top-level destinations. Use
`ShadTabs` for related content within one screen, not primary navigation.

## Schematic language

Structural lines clarify boundaries, grouping, relationships, progress, or
measurement. Use 1px lines for borders and dividers; reserve 1.5-2px for
focus, selection, active paths, and important diagram relationships.

Use no more than one prominent schematic visualization per screen. Dimension
markers may represent distance, duration, progress, capacity, quantity,
comparison, completion, or steps. Technical labels must be short, real, and
supportive; never invent codes solely for decoration. Do not put grid patterns
behind ordinary content-heavy screens.

## States and accessibility

Network-dependent screens must represent loading, empty, offline, timeout,
server error, partial data, retry, and background refresh failure. Explain what
happened and what the user can do next. Do not show the same error in multiple
surfaces at once.

Empty states use a line-based schematic icon, direct explanation, and one
recommended action. Custom controls, diagrams, progress indicators, status
elements, and icon-only buttons require semantics. Decorative drafting elements
must be excluded from semantics. Never communicate state through color alone.

Support text scaling without clipping, overlap, essential-action truncation,
or fixed-height text containers. Keep one primary scrolling region per screen
and respect safe areas and keyboard insets.

## Motion and copy

Motion is measured: micro-interaction 150ms, component transition 250ms,
content entrance 420ms, page transition 200ms. Prefer fade, small translation,
press scale, expansion, progress-line drawing, and subtle list staggering.
Avoid bounce, elastic overshoot, parallax, animated gradients, and decorative
motion.

Use direct action-specific copy such as `Save plan`, `Retry connection`,
`Add location`, `View details`, and `Download report`. Avoid vague marketing
copy and do not use lorem ipsum.

## Flutter architecture

```text
lib/
  design_system/
    tokens/app_colors.dart
    tokens/app_spacing.dart
    theme/app_shad_theme.dart
  features/
```

Theme hierarchy:

```text
DESIGN.md tokens -> ShadColorScheme -> ShadThemeData -> Shad components -> screens
```

The installed `shadcn_ui` API uses `ShadColorScheme` fields `background`,
`foreground`, `card`, `popover`, `primary`, `secondary`, `muted`, `accent`,
`destructive`, `border`, `input`, `ring`, and `selection`, plus `custom` for
project-specific colors. Verify package APIs against the locked version before
changing them. Keep Material theme derivation centralized in the app theme.

## Prototype acceptance

The first prototype is a component workspace, not a product dashboard. It
must visibly demonstrate the theme, typography, button variants, input,
switch, badge, progress/dimension widget, empty state, status, safe-area
scrolling, and at least one working interaction. It should remain usable on a
compact phone width and under increased text scale.
