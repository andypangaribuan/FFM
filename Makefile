all: help

help:
	@echo '✦ analyze'
	@echo '✦ publish-dry-run'
	@echo '✦ publish'

analyze:
	@fvm flutter analyze

publish-dry-run:
	@fvm flutter pub publish --dry-run

publish:
	@fvm flutter pub publish