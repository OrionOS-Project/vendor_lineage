PRODUCT_VERSION_MAJOR = 16
PRODUCT_VERSION_MINOR = 0
ORION_VERSION = Ozone
ORION_RELEASE_TYPE = Beta
ORION_MAINTAINER_LINK ?= https://orionos.tech
ORION_MAINTAINER ?= Unknown

CURRENT_DEVICE := $(wordlist 2,3,$(subst _, ,$(TARGET_PRODUCT)))
DEVICE_LIST := $(file < vendor/official_maintainer/orion.devices)
MAINTAINER_LIST := $(file < vendor/official_maintainer/orion.maintainers)

ORION_BUILD_TYPE ?= Unofficial

ifneq ($(filter $(CURRENT_DEVICE),$(DEVICE_LIST)),)
    ifneq ($(ORION_MAINTAINER),)
        ifneq ($(filter $(ORION_MAINTAINER),$(MAINTAINER_LIST)),)
            ORION_BUILD_TYPE := Official
        endif
    endif
endif

ifeq ($(WITH_GMS),true)
ORION_BUILD_VARIANT := Gapps
else
ORION_BUILD_VARIANT := Vanilla
endif

# Internal Version
LINEAGE_VERSION := OrionOS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(ORION_VERSION)-$(ORION_RELEASE_TYPE)-$(LINEAGE_BUILD)-$(ORION_BUILD_TYPE)-$(ORION_BUILD_VARIANT)-$(shell date +%Y%m%d)

# Display version
LINEAGE_DISPLAY_VERSION := v$(ORION_VERSION)-$(shell date +%Y%m%d)

ORION_BUILD_INFO := $(LINEAGE_VERSION)

PRODUCT_SYSTEM_PROPERTIES += \
    ro.orion.build.version=$(LINEAGE_VERSION) \
    ro.orion.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.orion.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(ORION_VERSION) \
    ro.orion.build.type=$(ORION_BUILD_TYPE) \
    ro.orion.maintainer=$(ORION_MAINTAINER) \
    ro.orion.maintainer_link=$(ORION_MAINTAINER_LINK) \
    ro.orion.build.variant=$(ORION_BUILD_VARIANT)

# dex2oat
PRODUCT_SYSTEM_PROPERTIES += \
    dalvik.vm.dex2oat-threads=2 \
    dalvik.vm.restore-dex2oat-threads=2 \
    dalvik.vm.dex2oat-cpu-set=$(DEX2OAT_CORES) \
    dalvik.vm.restore-dex2oat-cpu-set=$(DEX2OAT_CORES)

