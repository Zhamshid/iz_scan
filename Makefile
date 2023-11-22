.PHONY: Makefile



gen-build-delete:
	@echo "* Running build runner with deletion of conflicting outputs *"
	@flutter pub run build_runner build  --delete-conflicting-outputs

gen-clean:
	@echo "* Cleaning build runner *"
	@flutter pub run build_runner clean


gen-watch:
	@echo "* Running build runner in watch mode *"
	@flutter pub run build_runner watch



