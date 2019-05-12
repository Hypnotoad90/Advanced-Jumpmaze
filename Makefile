# Use one of these targets to build:
# debug, beta, release, clean

# Variables and targets needed for build
include utilities/common.make

# ACS files
acsDir := pk3/acs
sourceDir := pk3/scripts
coreSourceDir := pk3/scripts/core
acsFiles := \
	$(acsDir)/advjm.o

$(coreSourceDir):
	if [ "$(hostOS)" = "windows" ]; then \
		cmd //C mklink //J $(subst /,\\,$(coreSourceDir)) dependencies\\jumpmaze-zan\\jm_core\\pk3\\scripts; true; \
	else \
		ln -s $(abspath dependencies/jumpmaze-zan/jm_core/pk3/scripts) $(abspath $(coreSourceDir));  \
	fi 
$(acsDir):
	@$(MKDIR) $(MKDIRFLAGS) $@
$(acsDir)/advjm.o: $(sourceDir)/advjm.acs | $(acsDir) $(coreSourceDir)
	$(ACC) $< $@

# PK3 files
advjmContents = $(shell $(FIND) pk3 $(FINDFLAGS) -newer $(targetDir)/advancedJM-$(targetSuffix).pk3 2>/dev/null)

pk3Files := \
	$(targetDir)/advancedJM-$(targetSuffix).pk3

$(targetDir):
	@$(MKDIR) $(MKDIRFLAGS) $@
$(targetDir)/advancedJM-$(targetSuffix).pk3: pk3 $(advjmContents) $(acsFiles) | $(targetDir)
	@$(DEL) $(DELFLAGS) $@
	$(SEVENZA) $(SEVENZAFLAGS) $@ ./$</*

# Build target
build: $(pk3Files)

# Clean target
clean: cleanCommon
	@$(DEL) $(DELFLAGS) $(acsDir)/*
	@echo Clean operation complete.
