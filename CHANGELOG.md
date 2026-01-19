# Changelog

All notable changes to this project will be documented in this file.

## [0.0.2] - 2026-01-19

### Added
- Support for `CLOCK_FILE` environment variable to set the clock file path
- Support for `GIT_ROOT` prefix in `CLOCK_FILE` to resolve paths relative to the git repository root
- Automatic directory creation for clock file paths
- Error handling when `GIT_ROOT` is used but no git repository is found

### Changed
- Updated help text to document the new `CLOCK_FILE` environment variable
- Updated README.md with documentation and examples for the new feature

## [0.0.1] - Initial Release

### Added
- Initial release with basic time tracking functionality
- Commands: in, out, log, list, help, completion
- Support for task-based time tracking
- Options for message, file location, date filtering, and sorting
