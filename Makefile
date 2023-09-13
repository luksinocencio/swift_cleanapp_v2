clean: ## Remove Pods folder, *xcodeproj, *xcworkspace, and SPM folders; Clean its cache and reinstall all dependencies.
	@rm -rf CleanApp.xcodeproj
	@find . -name '.DS_Store' -type f -delete

generate:
	@bash ./Scripts/killXcode.sh $(close)
	@rm -rf CleanApp.xcodeproj
	@find . -name '.DS_Store' -type f -delete
	@xcodegen generate
	@bash ./Scripts/posGenerate.sh $(open)