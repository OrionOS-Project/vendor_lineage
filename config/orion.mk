# Audio
$(call inherit-product, vendor/lineage/config/audio.mk)

# Overlay
include vendor/addons/config.mk

# Certification
$(call inherit-product, vendor/certification/config.mk)

# DRM Service
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    drm.service.enabled=true \
    media.mediadrmservice.enable=true

# Disable RescueParty due to high risk of data loss
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.disable_rescue=true

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Blur
TARGET_ENABLE_BLUR ?= false
ifeq ($(TARGET_ENABLE_BLUR),true)
PRODUCT_SYSTEM_PROPERTIES += \
    ro.custom.blur.enable=true
else
PRODUCT_SYSTEM_PROPERTIES += \
    ro.custom.blur.enable=false
endif

# ColumbusService
ifneq ($(TARGET_SUPPORTS_QUICK_TAP),false)
PRODUCT_PACKAGES += \
    ColumbusService
endif

# Cloned app exemption
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/sysconfig/preinstalled-packages-orion.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/preinstalled-packages-orion.xml

# Disable async MTE on system_server
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    arm64.memtag.process.system_server=off

# Enable dex2oat64 to do dexopt
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    dalvik.vm.dex2oat64.enabled=true

# Filtering LMODroidEdgeCutout
ifneq ($(filter %_pro1 %_pro1x %_l01k %_joan %_judyp %_judypn %_caymanslm %_racer %_berlin %_pstar %_berlna %_dubai %_tundra %_eqs %_rtwo %_nio %_xpeng %_nx606j %_d1 %_d1x %_d2s %_d2x %_beyond1lte %_beyondx %_beyond2lte %_beyond0lte %_r8q %_cupid %_zeus %_tokay %_caiman %_komodo %_mayfly %_thor %_nuwa %_umi %_cmi %_thyme %_tucana %_zahedan,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += LMODroidEdgeCutout
endif

# Extra packages
PRODUCT_PACKAGES += \
    BatteryStatsViewer \
	GameSpace \
	LMOFreeform \
    CertifiedKeyboxOverlay \
	LMOFreeformSidebar \
	OmniStyle \
	Miniature \
	SoundPickerPrebuilt_32000142

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= $(TARGET_SUPPORTS_64_BIT_APPS)
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
    PRODUCT_PACKAGES += \
        FaceUnlock
    PRODUCT_SYSTEM_EXT_PROPERTIES += \
        ro.face.sense_service=true
    PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/android.hardware.biometrics.face.xml
else
    PRODUCT_PACKAGES += \
        SettingsGoogleFutureFaceEnroll \
        PixelTrafficLightFaceOverlay \
        FaceEnrollSettingsOverlay #FaceEnroll - Settings RRO
endif

# StorageManager configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.storage_manager.show_opt_in=false

