generate:
	flutter pub run build_runner watch -d

format:
	dart format . --set-exit-if-changed

analyze:
	flutter analyze --no-fatal-infos --no-fatal-warnings

.PHONY: generate analyze