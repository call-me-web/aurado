# Aurado Native — Build Automation

.PHONY: run run-dev build-apk build-ios clean

# Development standard
run:
	flutter run

# Alias for run
dev: run

# Build release APK
build-apk:
	flutter build apk --release

# Build release iOS
build-ios:
	flutter build ios --release

# Clean build artifacts
clean:
	flutter clean
	flutter pub get
