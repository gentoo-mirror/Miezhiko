# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer-meson

DESCRIPTION="OpenCV elements for GStreamer"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND=">=media-libs/opencv-4.1.2-r3:=[contrib,contribdnn,${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

multilib_src_configure() {
	local emesonargs=(
		# We need to disable here to avoid colliding w/ gst-plugins-bad
		# on translations, because we currently do a "full" install in
		# multilib_src_install in this package. See bug #907480.
		-Dnls=disabled
	)

	gstreamer_multilib_src_configure
}

multilib_src_install() {
	DESTDIR="${D}" eninja install
	
	#clean up clonflicts LOL
	rm      ${D}/usr/include/gstreamer-1.0/gst/interfaces/photography-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/interfaces/photography.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/rtcsessiondescription.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/rtpreceiver.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/webrtc_fwd.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/icetransport.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/rtpsender.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/sctptransport.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/rtptransceiver.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/webrtc.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/ice.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/datachannel.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/webrtc-enumtypes.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/icestream.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/webrtc/dtlstransport.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/play/gstplay-signal-adapter.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/play/gstplay-types.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/play/gstplay-video-renderer.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/play/gstplay-video-overlay-video-renderer.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/play/play-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/play/gstplay.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/play/gstplay-media-info.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/play/gstplay-visualization.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/play/play.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/audio/audio-bad-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/audio/gstnonstreamaudiodecoder.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/audio/gstplanaraudioadapter.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/analytics/gstanalyticsmeta.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/analytics/analytics.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/analytics/gstanalyticsobjectdetectionmtd.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/analytics/gstanalyticsobjecttrackingmtd.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/analytics/gstanalyticsclassificationmtd.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/analytics/analytics-meta-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gstmpegtsdescriptor.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gst-hdmv-section.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gst-metadata-descriptor.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gstmpegts-enumtypes.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gstmpegtssection.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gst-dvb-descriptor.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/mpegts-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gst-dvb-section.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gst-mpegtspesmetadatameta.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gst-atsc-section.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gst-isdb-descriptor.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gst-atsc-descriptor.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/gst-scte-section.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mpegts/mpegts.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gstvp9parser.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gstmpeg4parser.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gsth265parser.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gstmpegvideoparser.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gstvc1parser.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gstjpegparser.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gstvp8rangedecoder.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gstjpeg2000sampling.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gsth264parser.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gstmpegvideometa.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gstvp8parser.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/codecparsers-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/codecparsers/gstav1parser.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/sctp/sctpsendmeta.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/sctp/sctp-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/sctp/sctpreceivemeta.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/transcoder/transcoder-enumtypes.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/transcoder/gsttranscoder.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/transcoder/transcoder-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/transcoder/gsttranscoder-signal-adapter.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/isoff/gstisoff.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/cuda/cuda-gst.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/cuda/gstcudanvrtc.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/cuda/gstcudabufferpool.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/cuda/gstcudacontext.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/cuda/gstcudaloader.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/cuda/gstcuda.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/cuda/gstcudastream.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/cuda/cuda-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/cuda/gstcudautils.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/cuda/gstcudamemory.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mse/gstmsesrc.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mse/gstsourcebufferlist.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mse/gstsourcebuffer.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mse/gstmediasource.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mse/mse-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mse/mse.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/mse/mse-enumtypes.h
	rm      ${D}/usr/bin/gst-transcoder-1.0
	rm      ${D}/usr/lib64/libgstplayer-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstadaptivedemux-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstmpegts-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstanalytics-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstphotography-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgsturidownloader-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstplay-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgsttranscoder-1.0.so.0
	rm      ${D}/usr/lib64/libgstwebrtc-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstcuda-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstinsertbin-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstbasecamerabinsrc-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstisoff-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstsctp-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstmse-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstcodecparsers-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstbadaudio-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/libgstcodecs-1.0.so.0.2408.0
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-mse-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-insertbin-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-photography-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-webrtc-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-cuda-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-codecparsers-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-player-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-play-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-transcoder-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-bad-audio-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-analytics-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-mpegts-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-plugins-bad-1.0.pc
	rm      ${D}/usr/lib64/pkgconfig/gstreamer-sctp-1.0.pc
	rm      ${D}/usr/share/gstreamer-1.0/encoding-profiles/online-services/youtube.gep
	rm      ${D}/usr/share/gstreamer-1.0/encoding-profiles/file-extension/flv.gep
	rm      ${D}/usr/share/gstreamer-1.0/encoding-profiles/file-extension/ts.gep
	rm      ${D}/usr/share/gstreamer-1.0/encoding-profiles/file-extension/mp4.gep
	rm      ${D}/usr/share/gstreamer-1.0/encoding-profiles/file-extension/oga.gep
	rm      ${D}/usr/share/gstreamer-1.0/encoding-profiles/file-extension/mp3.gep
	rm      ${D}/usr/share/gstreamer-1.0/encoding-profiles/file-extension/mkv.gep
	rm      ${D}/usr/share/gstreamer-1.0/encoding-profiles/file-extension/avi.gep
	rm      ${D}/usr/share/gstreamer-1.0/encoding-profiles/file-extension/webm.gep
	rm      ${D}/usr/share/gstreamer-1.0/encoding-profiles/file-extension/ogv.gep
	rm      ${D}/usr/share/gstreamer-1.0/encoding-profiles/device/dvd.gep
	rm      ${D}/usr/lib64/libgsturidownloader-1.0.so.0
	rm      ${D}/usr/lib64/libgstmpegts-1.0.so
	rm      ${D}/usr/lib64/libgstcodecs-1.0.so.0
	rm      ${D}/usr/lib64/libgstbasecamerabinsrc-1.0.so
	rm      ${D}/usr/lib64/libgstplay-1.0.so.0
	rm      ${D}/usr/lib64/libgstcuda-1.0.so.0
	rm      ${D}/usr/lib64/libgstplayer-1.0.so.0
	rm      ${D}/usr/lib64/libgstisoff-1.0.so.0
	rm      ${D}/usr/lib64/libgstinsertbin-1.0.so
	rm      ${D}/usr/lib64/libgstwebrtc-1.0.so
	rm      ${D}/usr/lib64/libgstbadaudio-1.0.so.0
	rm      ${D}/usr/lib64/libgstphotography-1.0.so.0
	rm      ${D}/usr/lib64/libgstinsertbin-1.0.so.0
	rm      ${D}/usr/lib64/libgstanalytics-1.0.so
	rm      ${D}/usr/lib64/libgstphotography-1.0.so
	rm      ${D}/usr/lib64/libgstisoff-1.0.so
	rm      ${D}/usr/lib64/libgstadaptivedemux-1.0.so
	rm      ${D}/usr/lib64/libgstplayer-1.0.so
	rm      ${D}/usr/lib64/libgstadaptivedemux-1.0.so.0
	rm      ${D}/usr/lib64/libgstcodecparsers-1.0.so.0
	rm      ${D}/usr/lib64/libgstbasecamerabinsrc-1.0.so.0
	rm      ${D}/usr/lib64/libgstplay-1.0.so
	rm      ${D}/usr/lib64/libgsturidownloader-1.0.so
	rm      ${D}/usr/lib64/libgstcodecparsers-1.0.so
	rm      ${D}/usr/lib64/libgstanalytics-1.0.so.0
	rm      ${D}/usr/lib64/libgstmse-1.0.so.0
	rm      ${D}/usr/lib64/libgstmse-1.0.so
	rm      ${D}/usr/lib64/libgstsctp-1.0.so.0
	rm      ${D}/usr/lib64/libgsttranscoder-1.0.so
	rm      ${D}/usr/lib64/libgstbadaudio-1.0.so
	rm      ${D}/usr/lib64/libgstsctp-1.0.so
	rm      ${D}/usr/lib64/libgstwebrtc-1.0.so.0
	rm      ${D}/usr/lib64/libgstcuda-1.0.so
	rm      ${D}/usr/lib64/libgstmpegts-1.0.so.0
	rm      ${D}/usr/lib64/libgstcodecs-1.0.so
	rm      ${D}/usr/include/gstreamer-1.0/gst/player/gstplayer.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/player/gstplayer-visualization.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/player/gstplayer-signal-dispatcher.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/player/gstplayer-media-info.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/player/gstplayer-video-renderer.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/player/gstplayer-types.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/player/player-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/player/gstplayer-g-main-context-signal-dispatcher.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/player/player.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/player/gstplayer-video-overlay-video-renderer.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/insertbin/gstinsertbin.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/uridownloader/gsturidownloader_debug.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/uridownloader/gstfragment.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/uridownloader/gsturidownloader.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/uridownloader/uridownloader-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/basecamerabinsrc/basecamerabinsrc-prelude.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/basecamerabinsrc/gstcamerabinpreview.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/basecamerabinsrc/gstcamerabin-enum.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/basecamerabinsrc/gstbasecamerasrc.h
	rm      ${D}/usr/include/gstreamer-1.0/gst/interfaces/photography-enumtypes.h
}
