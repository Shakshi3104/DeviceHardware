# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
swift build                                          # build
swift test                                           # run all tests
swift test --filter DeviceHardwareTests/testCpu     # run a single test
```

The test target asserts against the maintainer's specific machine (currently a Mac mini M2 Pro), so most tests will fail when run on any other host. That is expected — do not "fix" them by editing assertions to match a different machine.

A push of a tag matching `*.*.*` triggers `.github/workflows/release.yml`, which creates a GitHub Release with auto-generated notes.

## Architecture

The package exposes a single internal `DeviceHardware` protocol (`Sources/DeviceHardware/DeviceHardware.swift`) defining the read-only properties (`modelName`, `processorName`, `cpu`, `gpu`, `neuralEngine`, `modelIdentifier`, `processorCount`, `ram`, `ramString`). Two public conforming classes are surfaced as singletons:

- `UIDeviceHardware.deviceHardware` — iOS / iPadOS / Catalyst
- `MacDeviceHardware.deviceHardware` — macOS

Both follow the same pattern: read the hardware identifier via `sysctlbyname` (`hw.machine` on iOS, `hw.model` on Mac), look it up in a private `ModelIdentifier` enum whose raw values are the literal Apple identifier strings (`"iPhone17,5"`, `"Mac17,2"`, …), and dispatch through `switch` statements to return chip specs.

A few details that are easy to miss:

- **GPU on iOS comes from Metal at runtime** (`DeviceHardware.getMetalGpu`), not from the enum. The hardcoded `gpu()` switch is only the pre-Metal fallback. Test results will reflect Metal's `MTLDevice.name`, not what's written in `gpu()`.
- **Mac CPU clock is hardcoded per chip family; core count is dynamic.** `MacDeviceHardware.getCpu` returns `"<hardcoded GHz> \(getPhysicalCore())-core"`, where `getPhysicalCore` reads `hw.physicalcpu`. Intel Macs take a separate path that parses `machdep.cpu.brand_string`.
- **Some Mac identifiers cover multiple model years** (e.g. `MacBookAir7,2` = 2015 *and* 2017). `MacDeviceHardware.getModelName` disambiguates these by matching against the Intel CPU brand string before falling back to `ModelIdentifier.modelName`. New Apple Silicon Macs do not have this problem and just go through the default branch.
- **iPhones with the same SoC but different GPU bins are split.** e.g. `iPhone17,5` (16e) returns `"4-core"` GPU while `iPhone17,3/4` (16/16 Plus, same A18) returns `"5-core"`. Keep this in mind when grouping new cases.
- **`hasDynamicIsland()` is iPhone-only and must be updated when a new Dynamic Island device ships.** "e" models historically don't have it.

## Adding a new device

This is the most common task in this repo. For each new model identifier:

1. Add a `case <enum_name> = "<raw identifier>"` to the appropriate `ModelIdentifier` enum, grouped by product line under the existing `// MARK:` sections.
2. Add the case to **every** `switch` in that file: `modelName()`, `processorName()`, `cpu()`, `gpu()`, `neuralEngine()`, plus `hasDynamicIsland()` for iPhones with Dynamic Island. The Swift compiler will flag any switch you forget because they're exhaustive.
3. Group the case with siblings that share the same chip / core count rather than adding a new branch — e.g. a new A19 iPhone joins the existing `case .iPhone18_1, .iPhone18_2, …:` line.
4. On the Mac side, also extend `getCpu()` in the file's `extension MacDeviceHardware` if the device introduces a new chip family clock.

Authoritative sources for model identifiers (see issue #38):

- iPhone / iPad / iPod: <https://gist.github.com/adamawolf/3048717>
- Mac: Apple support pages linked from issue #38 (one per product line); ipsw.me (`https://api.ipsw.me/v4/devices`) tends to have the newest entries first.

Cross-reference chip specs against Apple's `apple.com/<product>/specs/` page — particularly GPU core count, since that varies by binning.
