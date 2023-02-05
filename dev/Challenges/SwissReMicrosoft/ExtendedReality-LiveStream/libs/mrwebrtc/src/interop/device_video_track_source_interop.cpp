// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

// This is a precompiled header, it must be on its own, followed by a blank
// line, to prevent clang-format from reordering it with other headers.
#include "pch.h"

#include "device_video_track_source_interop.h"
#include "interop/global_factory.h"
#include "media/device_video_track_source.h"

using namespace Microsoft::MixedReality::WebRTC;

mrsResult MRS_CALL mrsDeviceVideoTrackSourceCreate(
    const mrsLocalVideoDeviceInitConfig* init_config,
    mrsDeviceVideoTrackSourceHandle* source_handle_out) noexcept {
  if (!source_handle_out) {
    RTC_LOG(LS_ERROR) << "Invalid NULL video track source handle.";
    return Result::kInvalidParameter;
  }
  *source_handle_out = nullptr;

  ErrorOr<RefPtr<DeviceVideoTrackSource>> result =
      DeviceVideoTrackSource::Create(*init_config);
  if (!result.ok()) {
    RTC_LOG(LS_ERROR) << "Failed to create device video track source.";
    return result.error().result();
  }
  *source_handle_out = result.value().release();
  return Result::kSuccess;
}
